//
//  ViewController.swift
//  Image Recognition App
//
//  Created by Drakosha on 30/09/2019.
//  Copyright © 2019 Drakosha. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var predictionScoreText: UILabel!
    
    var sImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectBtnClicked(_ sender: Any) {
        // creating image picker from camera and photo library
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Sourece", preferredStyle: .actionSheet)
        
        // adding camera to action sheet
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                imagePickerController.showsCameraControls = true
                self.present(imagePickerController, animated: true, completion: nil)
            } else{
                print("Camera is Not Available")
            }
        }))
        
        // adding photo library to action sheet
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        // adding cancel button to action sheet
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        selectedImage.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.dismiss(animated: true, completion: nil)
        
        if let ciImage = CIImage(image: selectedImage.image!){
            self.sImage = ciImage
        }
        
        predictByImage(image: sImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
    
    func predictByImage(image: CIImage){
        
        predictionScoreText.text = "Predicting.."
        
        if let model = try? VNCoreMLModel(for: Resnet50().model) {
            let request = VNCoreMLRequest(model: model, completionHandler: {(vnRequest, err) in
                guard let results = vnRequest.results as? [VNClassificationObservation] else {return}
                
                let topResult = results.first
                DispatchQueue.main.async {
                    let confidenceRate = Int ((topResult?.confidence)! * 100)
                    self.predictionScoreText.text = "\(confidenceRate)% it's \(topResult?.identifier ?? "Unknown")"
                }
                
            })
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Err :(")
                }
            }
        }
        
    }
    
}

