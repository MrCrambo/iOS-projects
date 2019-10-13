//
//  ViewController.swift
//  FaceMarks
//
//  Created by mrCrambo on 11/10/2019.
//  Copyright © 2019 mrCrambo. All rights reserved.
//

import UIKit
import YPImagePicker
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var image: UIImage!
    
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
                self.image = photo.image
                
                self.findFaceLandmarks()
            }
            picker.dismiss(animated: true, completion: nil)
            
        }
        present(picker, animated: true, completion: nil)
    }
    
    func findFaceLandmarks(){
        
        var orientation:Int32 = 0

        // detect image orientation, we need it to be accurate for the face detection to work
        switch image.imageOrientation {
        case .up:
            orientation = 1
        case .right:
            orientation = 6
        case .down:
            orientation = 3
        case .left:
            orientation = 8
        default:
            orientation = 1
        }
        
        let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: self.handleFaceFeatures)
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, orientation: CGImagePropertyOrientation(rawValue: CGImagePropertyOrientation.RawValue(orientation))! ,options: [:])
        do {
            try requestHandler.perform([faceLandmarksRequest])
        } catch {
            print(error)
        }
    }
    
    func handleFaceFeatures(request: VNRequest, errror: Error?) {
        guard let observations = request.results as? [VNFaceObservation] else {
            fatalError("unexpected result type!")
        }

        for face in observations {
            print(face.landmarks?.allPoints?.normalizedPoints ?? 0)
            print(face.landmarks?.medianLine)
        }
    }
}

