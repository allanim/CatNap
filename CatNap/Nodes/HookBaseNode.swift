//
//  HookBaseNode.swift
//  CatNap
//
//  Created by Allan Im on 2019-06-11.
//  Copyright © 2019 Allan Im. All rights reserved.
//

import SpriteKit

class HookBaseNode: SKSpriteNode, EventListenerNode {
    
    private var hookNode = SKSpriteNode(imageNamed: "hook")
    private var ropeNode = SKSpriteNode(imageNamed: "rope")
    private var hookJoint: SKPhysicsJointFixed!
    
    var isHooked: Bool {
        return hookJoint != nil
    }
    
    func didMoveToScene() {
        guard let scene = scene else {
            return
        }
        
        // scene
        let ceilingFix = SKPhysicsJointFixed.joint(withBodyA:
            scene.physicsBody!, bodyB: physicsBody!, anchor: CGPoint.zero)
        scene.physicsWorld.add(ceilingFix)
        
        ropeNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        ropeNode.zRotation = CGFloat(270).degreesToRadians()
        ropeNode.position = position
        scene.addChild(ropeNode)
        
        // hook
        hookNode.position = CGPoint(
            x: position.x,
            y: position.y - ropeNode.size.width)
        hookNode.physicsBody =
            SKPhysicsBody(circleOfRadius: hookNode.size.width/2)
        hookNode.physicsBody!.categoryBitMask = PhysicsCategory.Hook
        hookNode.physicsBody!.contactTestBitMask = PhysicsCategory.Cat
        hookNode.physicsBody!.collisionBitMask = PhysicsCategory.None
        scene.addChild(hookNode)
        
        // spring joint
        let hookPosition = CGPoint(x: hookNode.position.x,
                                   y: hookNode.position.y+hookNode.size.height/2)
        let ropeJoint = SKPhysicsJointSpring.joint(
            withBodyA: physicsBody!, bodyB: hookNode.physicsBody!,
            anchorA: position,
            anchorB: hookPosition)
        scene.physicsWorld.add(ropeJoint)
    }
}
