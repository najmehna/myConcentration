//
//  ThemeChooserViewController.swift
//  concentration
//
//  Created by najmeh nasiriyani on 2019-06-21.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit
import MobileCoreServices

class ThemeChooserViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var takePhotoBtn: UIButton!{
        didSet{
            takePhotoBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
    }
    
    @IBAction func startMyGame(_ sender: UIButton) {
        performSegue(withIdentifier: "Start Game", sender: self)
    }
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet var imageViewSet: [UIImageView]!
    
    var imageSet: [UIImage] = []{
        didSet{
                startGame.isEnabled = imageSet.count == 6
        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeImage as String]
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:true)
        
    }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.presentingViewController?.dismiss(animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = (info[UIImagePickerController.InfoKey.editedImage] ?? info[UIImagePickerController.InfoKey.originalImage]) as? UIImage{
                imageSet.append(image)
                imageViewSet[imageSet.count-1].image = image
            }
            picker.presentingViewController?.dismiss(animated: true)
            
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
    
    


    // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Start Game"{
        let vc = segue.destination as! ConcentrationViewController
        vc.imageSet = imageSet
    }
          }
    

}
