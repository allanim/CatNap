//
//  CatNode.swift
//  CatNap
//
//  Created by Allan Im on 2019-06-07.
//  Copyright © 2019 Allan Im. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode {
    func didMoveToScene() {
        print("cat added to scene")
    }
}
