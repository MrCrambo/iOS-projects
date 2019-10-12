//
//  ViewController.swift
//  FaceMarks
//
//  Created by mrCrambo on 11/10/2019.
//  Copyright © 2019 mrCrambo. All rights reserved.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {
    
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func clickButton(_ sender: Any) {
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
                self.chosenImage.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
            
        }
        present(picker, animated: true, completion: nil)
    }
}

