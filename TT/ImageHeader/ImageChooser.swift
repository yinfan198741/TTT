//
//  ImageChooser.swift
//  TT
//
//  Created by 尹凡 on 1/21/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

import Foundation
import UIKit

internal class ImageViewVC: UIViewController {

  var imageView: UIImageView?
  let imageChooser = ImagePickerHelper()
  override func viewDidLoad() {
    let button = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    button.backgroundColor = UIColor.red
//    button.addTarget(self, action: @selector(buttonClick), for: .touchUpInside)
    button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    self.view.addSubview(button)
    self.view.backgroundColor = UIColor.white
    
    
   self.imageView = UIImageView.init(frame: CGRect(x:20,y: 200,width: 380, height:380))
    if let _imageV = self.imageView {
        self.view.addSubview(_imageV)
    }
  }

  @objc func buttonClick() {
      print("buttonClick")

    imageChooser.chooseImage(rootVc: self) { img in
      self.imageView?.image = img
    }
  }
}

class ImagePickerHelper: NSObject ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var selectedImage: UIImage?
  
  var choosedImg: ((UIImage) -> Void)?
  
  func chooseImage(rootVc: UIViewController , imageChoose: ((UIImage) -> Void)? ) {
    
    self.choosedImg = imageChoose
    
    let imgController = UIImagePickerController() // pathlint checked
    imgController.sourceType = .photoLibrary
    imgController.allowsEditing = true
   
    imgController.delegate = self
    rootVc.present(imgController,
                   animated: true,
                   completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
 

      if let image = info[UIImagePickerControllerEditedImage] as? UIImage ?? info[UIImagePickerControllerOriginalImage] as? UIImage
        {
        selectedImage = image
        if
          let image = self.choosedImg,
          let img = selectedImage{
          image(img)
        }
      }
    picker.delegate = nil
    picker.dismiss(animated: false)
  }
  
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.delegate = nil
    picker.dismiss(animated: false)
  }
  
  
}
