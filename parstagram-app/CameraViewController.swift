//
//  CameraViewController.swift
//  parstagram-app
//
//  Created by Ermain Paul on 3/11/22.
//

import UIKit
import AlamofireImage
import Parse


class CameraViewController: UIViewController, UIImagePickerControllerDelegate,
	UINavigationControllerDelegate
{

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var commentField: UITextField!

	var refreshControl: UIRefreshControl!

	override func viewDidLoad() {
        super.viewDidLoad()
		refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
		
        // Do any additional setup after loading the view.
    }
    

	@IBAction func onSubmitButton(_ sender: Any) {
		let post = PFObject(className: "Posts")
		// Set attributes of the Post object
		post["caption"] = commentField.text!
		post["author"] = PFUser.current()

		let imageData = imageView.image!.pngData()
		let file = PFFileObject(data: imageData!)
		post["image"] = file

		post.saveInBackground{ succeeded, error in
			if succeeded {
				self.dismiss(animated: true, completion: nil)
				print("Saved!")
			} else {
				print("Error!")
			}
		}
	}
	
	
	@IBAction func onCameraButton(_ sender: Any) {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.allowsEditing = true
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			picker.sourceType = .camera
		} else {
			picker.sourceType = .photoLibrary
		}
		
		present(picker, animated: true, completion: nil)
	
	}
	
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let image = info[.editedImage] as! UIImage
		
		let imageSize = CGSize(width: 300, height: 300)
		let scaledImage = image.af.imageAspectScaled(toFill: imageSize)
		imageView.image = scaledImage
		
		dismiss(animated: true, completion: nil)
	}

	@objc func onRefresh() {

	}
}
