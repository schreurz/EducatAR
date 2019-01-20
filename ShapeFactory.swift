//
//  ShapeFactory.swift
//  ARFlashCards
//
//  Created by Zack Schreur on 1/19/19.
//  Copyright © 2019 Zack Schreur. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class ShapesFactory {
    
    var sceneView: ARSCNView!
    var firebaseCom: FirebaseCommunicator! 
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
        
        firebaseCom = FirebaseCommunicator()
    }
    
    func createShape(filePath: String, anchor: ARImageAnchor) -> SCNNode {
        let urlPath = Bundle.main.url(forResource: "model10", withExtension: "dae")!
        let urlPath2 = firebaseCom.getFile()
        
        print("URL!!!!",urlPath2)
        let obj = try? SCNScene(url: urlPath, options: nil)
        let objNode = obj?.rootNode.childNodes[0]
        self.sceneView.scene.rootNode.addChildNode(objNode!)
        print("anchor position:", anchor.transform[0])
        objNode!.position = SCNVector3(
            anchor.transform.columns.3.x,
            anchor.transform.columns.3.y,
            anchor.transform.columns.3.z)
        

        return objNode!
    }
    
}
