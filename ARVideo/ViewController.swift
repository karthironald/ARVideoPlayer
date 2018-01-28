//
//  ViewController.swift
//  ARVideo
//
//  Created by Karthick Selvaraj on 27/01/18.
//  Copyright © 2018 Mallow technologies. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SpriteKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var selectedProductName: String?
    
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(create), with: nil, afterDelay: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }

    
    // MARK: - Custom methods
    
    @objc func create() {
        if let productName = selectedProductName {
            
            // Create new SKNVideoNode with chosen local video file name.
            let playerNode = SKVideoNode(fileNamed: "\(productName).mp4")
            
            // Create new SKScene instance to add video node in it. For size property give as much you want. Im give some random size.
            let spriteKitScene = SKScene(size: CGSize(width: 1276.0 / 2.0, height: 712.0 / 2.0))
            spriteKitScene.scaleMode = .aspectFit
            
            // Set the position of video node in SKScene.
            playerNode.position = CGPoint(x: spriteKitScene.size.width / 2.0, y: spriteKitScene.size.height / 2.0)
            
            // Add video video node to SKScene.
            spriteKitScene.addChild(playerNode)
            
            // Create new scene kit geometry to place video player in 3D space.
            let sphere = SCNPlane(width: 2, height: 1)
            
            // Create new material for geometry.
            let material = SCNMaterial()
            material.diffuse.contents = spriteKitScene
            material.isDoubleSided = true // Make video to visible in double side of node.
            material.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0) // When you first see your video in 3D space you will be seeing your video in upside down. So change the content transform to make it normal.
            
            sphere.firstMaterial = material
            
            // Create new scene kit node.
            let node = SCNNode(geometry: sphere)
            node.position = SCNVector3(x: 0, y: 0, z: -1)
            sceneView.scene.rootNode.addChildNode(node)
            
            // Play the video in node.
            playerNode.play()
            sceneView.isPlaying = true
        }
    }
    
    
    // MARK: - ARSCNViewDelegate
    
    // Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let node = SCNNode()
//
//        return node
//    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
