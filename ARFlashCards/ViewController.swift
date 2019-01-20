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

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var additionalText: UITextView!
    
    var arController: ARController!
    var shapesFactory: ShapesFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        shapesFactory = ShapesFactory(sceneView: sceneView)
        
        additionalText.delegate = self as? UITextViewDelegate
        additionalText.isHidden = false
        
        sceneView.showsStatistics = true
        downloadScn()
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
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func resetTrackingConfiguration() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
    }
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer,
                  didAdd node: SCNNode,
                  for anchor: ARAnchor) {
        
        
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
        sceneView.session.remove(anchor: anchor)
        
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        let imageName = referenceImage.name ?? "no name"
        print("image anchor :", imageAnchor)
        
        //        addBox(anchor: imageAnchor)
        addShape(name: imageName, anchor: imageAnchor)
        DispatchQueue.main.async {
            print(imageName)
        }
    }
    
    //    func addBox(anchor: ARImageAnchor) {
    //        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
    //
    //        let boxNode = SCNNode()
    //        boxNode.geometry = box
    //        print("anchor position:",anchor.transform[0])
    //        boxNode.position = SCNVector3(anchor.transform.columns.3.x, anchor.transform.columns.3.y, anchor.transform.columns.3.z)
    //
    //        sceneView.scene.rootNode.addChildNode(boxNode)
    //    }
    //
    
    func addShape(name: String,anchor: ARImageAnchor){
        
        print(name)
        var shape: SCNNode;
        switch name{
        case("IMG_0247"):
            
            let file = Bundle.main.path(forResource: "model10", ofType: "dae") ?? ""
//            let stringPath = Bundle.main.path(forResource: "model10", ofType: "dae")

            
            shape = shapesFactory.createShape(
                filePath: file, //"new.scnassets/model2.scn",
                anchor: anchor)
            
            
            //Create the the node and apply texture
            //this is only for the animal cell
//            shape.scale = SCNVector3(0.000001, 0.000001, 0.000001)
            
            
            shape.scale = SCNVector3Make(0.01,0.01,0.01)
            
            
        case("IMG_0248"):
            let sphere = SCNSphere(radius: 0.05)
            let sphereNode = SCNNode()
            sphereNode.geometry = sphere
            sphereNode.position = SCNVector3(anchor.transform.columns.3.x, anchor.transform.columns.3.y, anchor.transform.columns.3.z)
            sceneView.scene.rootNode.addChildNode(sphereNode)
            
        default:
            print("not working")
        }
    }
}
