//
//  ViewController.swift
//  FaceDetecting
//
//  Created by Drakosha on 02/10/2019.
//  Copyright © 2019 Drakosha. All rights reserved.
//

import UIKit
import YPImagePicker
import Alamofire

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func choosePhoto(_ sender: Any) {
        
        // using ImagePicker pods library for instagram like picker without video
        
        var config = YPImagePickerConfiguration()
        config.usesFrontCamera = true
        config.onlySquareImagesFromCamera = false
        config.showsPhotoFilters = false
        config.screens = [.library, .photo]
        config.startOnScreen = YPPickerScreen.library
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        config.library.mediaType = YPlibraryMediaType.photo
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
            
            self.uploadImage(img: self.imageView.image!)
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    func uploadImage(img: UIImage){

        let minScale = max(img.size.width / 400, img.size.height / 500)
        let resizedImage = img.resized(to: CGSize(width: img.size.width / minScale, height: img.size.height / minScale))
        
        let jpegData = resizedImage.jpegData(compressionQuality: 0.94)
        let jpegSize: Int = jpegData?.count ?? 0
        print("size of jpeg image in KB: %f ", Double(jpegSize) / 1024.0)
        
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(resizedImage.jpegData(compressionQuality: 0.94)!, withName: "image" , fileName: "user_photo.jpeg", mimeType: "image/*jpeg")
        }, to: "PUT SOME URL", method: .post , headers: headers).responseJSON { resp in
            
            let respJson: NSDictionary = resp.value as! NSDictionary
            
            if (respJson["code"] as! String == "ok"){
                self.textView.text = respJson["score"] as? String
            } else {
                self.textView.text = "There is no face in photo"
            }
        }
    }
    

}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

