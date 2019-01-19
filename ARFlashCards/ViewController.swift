//
//  ViewController.swift
//  FalshAR
//
//  Created by Swapnik R. Katkoori on 1/18/19.
//  Copyright © 2019 Swapnik R. Katkoori. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var additionalText: UITextView!
    
    var arController: ARController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        additionalText.delegate = self as? UITextViewDelegate
        additionalText.isHidden = false
        
        self.arController = ARController(viewController: self)
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arController.resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer,
                  didAdd node: SCNNode,
                  for anchor: ARAnchor) {
        self.arController.renderer(renderer, didAdd: node, for: anchor)
    }
}
