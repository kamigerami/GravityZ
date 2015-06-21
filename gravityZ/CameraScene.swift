//
//  CameraScene.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-20.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import UIKit

class CameraScene: SKScene {
   
    // Flag indicating whether we've setup the camera system yet.
    var isCreated: Bool = false
    // The root node of your game world. Attach game entities
    // (player, enemies, &c.) to here.
    var world: SKNode?
    // The root node of our UI. Attach control buttons & state
    // indicators here.
    var overlay: SKNode?
    // The camera. Move this node to change what parts of the world are visible.
    var camera: SKNode?
    
    override func didMoveToView(view: SKView) {
        if !isCreated {
            isCreated = true
            
            // Camera setup
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKNode()
            self.world?.name = "world"
            addChild(self.world)
            self.camera = SKNode()
            self.camera?.name = "camera"
            self.world?.addChild(self.camera)
            
            // UI setup
            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay?.name = "overlay"
            addChild(self.overlay)
        }
    }
    
    
    override func didSimulatePhysics() {
        if self.camera != nil {
            self.centerOnNode(self.camera!)
        }
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene: CGPoint = node.scene.convertPoint(node.position, fromNode: node.parent)
        
        node.parent.position = CGPoint(x:node.parent.position.x - cameraPositionInScene.x, y:node.parent.position.y - cameraPositionInScene.y)
    }
    
}