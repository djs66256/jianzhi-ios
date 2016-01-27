//
//  JZImagePickerComponentViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/28.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZImagePickerComponentViewControllerDelegate : NSObjectProtocol {
    func imagePickerComponentDidSelect(controller:JZImagePickerComponentViewController, image:UIImage)
}

class JZImagePickerComponentViewController: UIViewController, JZImagePickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate {

    var delegate: JZImagePickerComponentViewControllerDelegate?
    
    let imagePicker = JZImagePickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showController() {
        if self.parentViewController != nil {
            imagePicker.delegate = self
            imagePicker.showInController(self.parentViewController!)
        }
    }

    // MARK: - image picker
    func imagePickerFinished(controller: JZImagePickerViewController, type: JZImagePickerViewControllerType) {
        imagePicker.dismiss() {
            if UIImagePickerController.isSourceTypeAvailable(.Camera) && type == .Camera {
                let controller = UIImagePickerController()
                controller.delegate = self
                controller.sourceType = .Camera
                
                self.navigationController?.presentViewController(controller, animated: true, completion:nil)
            }
            else if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) && type == .Album {
                let controller = UIImagePickerController()
                controller.delegate = self
                controller.sourceType = .PhotoLibrary
                
                self.navigationController?.presentViewController(controller, animated: true, completion:nil)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let viewController = RSKImageCropViewController(image: image, cropMode: .Square)
            viewController.maskLayerStrokeColor = UIColor(white: 0.8, alpha: 1)
            viewController.maskLayerLineWidth = 1
            viewController.delegate = self
            picker.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - image crop
    
    func imageCropViewControllerDidCancelCrop(controller: RSKImageCropViewController) {
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    func imageCropViewController(controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        delegate?.imagePickerComponentDidSelect(self, image: croppedImage)
        
        controller.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageCropViewController(controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        imageCropViewController(controller, didCropImage: croppedImage, usingCropRect: cropRect, rotationAngle: 0)
    }
}
