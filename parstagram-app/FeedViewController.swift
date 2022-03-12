//
//  FeedViewController.swift
//  parstagram-app
//
//  Created by Ermain Paul on 3/11/22.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var posts: [PFObject] = [PFObject]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
        // Do any additional setup after loading the view.
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let query = PFQuery(className: "Posts")
		query.includeKey("author")
		query.limit = 20
		
		query.findObjectsInBackground{ (posts, error) in
			if posts != nil {
				self.posts = posts!
				self.tableView.reloadData()
			}
			
		}
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

		
		let post = posts[indexPath.row]
		let user = post["author"] as! PFUser
		
		cell.usernameLabel.text = user.username
		cell.captionLabel.text = (post["caption"] as! String)
		
		let imageFile = post["image"] as! PFFileObject
		let urlString = imageFile.url!
		let url = URL(string: urlString)!
		
		cell.photoView.af.setImage(withURL: url)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
}
