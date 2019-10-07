//
//  ViewController.swift
//  CardViewUI
//
//  Created by mrCrambo on 04/10/2019.
//  Copyright © 2019 mrCrambo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // making image view circle
        imageView.layer.borderWidth = 4.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
    }
    
}

final class CustomButton: UIButton {

    private var shadowLayer: CAShapeLayer!

    // new Button class with shadow and corners, also here is adding background color
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
            shadowLayer.fillColor = UIColor(red: 30.0/255.0, green: 150.0/255.0, blue: 233.0/255.0, alpha: 1.0).cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.3
            shadowLayer.shadowRadius = 2
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

}

class ShadowView: UIView {

    // new UIView class with shadows, used in storyboard
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
    }

}
