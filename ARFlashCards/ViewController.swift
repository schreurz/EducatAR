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
import Alamofire
import FirebaseDatabase

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var additionalText: UITextView!
    
    var arController: ARController! // render 3d objects
    var firebaseCom: FirebaseCommunicator! // communicator for firebase
    
    // runs when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        additionalText.delegate = self as? UITextViewDelegate
        additionalText.isHidden = true
        
        self.arController = ARController(viewController: self)
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        firebaseCom = FirebaseCommunicator()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    func downloadScn(){
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendingPathComponent("modal21.dae")
//
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
        
//        Alamofire.download("blah", to: destination).response { response in
//            print(response)
//
//            if response.error == nil, let imagePath = response.destinationURL {
//                SCNScene(url: imagePath, options: nil)
//            }
//        }
        guard let urlPath = Bundle.main.url(forResource: "model10", withExtension: "dae"),
            let scene = try? SCNScene(url: urlPath, options: nil) else {
                print("Creating the scene failed")
                return
        }
        
        let objNode = scene.rootNode.childNodes[0]
        self.sceneView.scene.rootNode.addChildNode(objNode)
    }
    
    @objc func didTapView(_ sender: UIView) {
        view.endEditing(true)
    }
    
    // ADDITIONAL TEXT
    func showAdditionalText(name: String) {
        DispatchQueue.main.async {
            self.additionalText.isHidden = false
        }
    }
    
    func hideAdditionalText(name: String) {
        DispatchQueue.main.async {
            self.additionalText.isHidden = true
        }
    }
    // ADDITIONAL TEXT
    
    /// ----------------------------------------- ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arController.resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor){
                  self.arController.renderer(renderer, didAdd: node, for: anchor)
        
    }
}
