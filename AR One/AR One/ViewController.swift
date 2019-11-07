//
//  ViewController.swift
//  AR One
//
//  Created by mrcrambo on 07/11/2019.
//  Copyright © 2019 mrcrambo. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var arView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arView.session.run(config)
    }


}

