//
//  ViewController.swift
//  FaceMarks
//
//  Created by mrCrambo on 11/10/2019.
//  Copyright © 2019 mrCrambo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstPhoto: UIImageView!
    @IBOutlet weak var secondPhoto: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstPhoto.isUserInteractionEnabled = true
        firstPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstImageTapped(_:))))
        
        secondPhoto.isUserInteractionEnabled = true
        secondPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondImageTapped(_:))))
    }

    @objc private func firstImageTapped(_ recognizer: UITapGestureRecognizer) {
        print("first image tapped")
    }
    
    @objc private func secondImageTapped(_ recognizer: UITapGestureRecognizer) {
        print("second image tapped")
    }

}

