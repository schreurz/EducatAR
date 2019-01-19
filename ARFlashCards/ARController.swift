//
//  ARController.swift
//  ARFlashCards
//
//  Created by Zack Schreur on 1/19/19.
//  Copyright © 2019 Zack Schreur. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class ARController {
    
    weak var viewController: ViewController!
    var objectHidden = true;
    var shapesFactory: ShapesFactory!
    
    init (viewController: ViewController) {
        self.viewController = viewController
        shapesFactory = ShapesFactory(sceneView: self.viewController.sceneView)
    }
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        self.viewController.sceneView.session.run(configuration, options: options)
    }
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer,
                  didAdd node: SCNNode,
                  for anchor: ARAnchor) {
        self.viewController.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
        self.viewController.sceneView.session.remove(anchor: anchor)
        
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        let imageName = referenceImage.name ?? "no name"
        print("image anchor :", imageAnchor)
        
        //        addBox(anchor: imageAnchor)
        addShape(name: imageName,anchor: imageAnchor)
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
            
            shape = shapesFactory.createShape(
                filePath: "new.scnassets/model.scn",
                anchor: anchor)
            
            shape.scale = SCNVector3(0.01, 0.01, 0.01)
            
            
        case("IMG_0248"):
            let sphere = SCNSphere(radius: 0.05)
            let sphereNode = SCNNode()
            sphereNode.geometry = sphere
            sphereNode.position = SCNVector3(anchor.transform.columns.3.x, anchor.transform.columns.3.y, anchor.transform.columns.3.z)
            self.viewController.sceneView.scene.rootNode.addChildNode(sphereNode)
            
        default:
            print("not working")
        }
    }
}
