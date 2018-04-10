//
//  GameObject.swift
//  GameDemo
//
//  Created by hezhiqiang on 2018/4/10.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import Foundation

class GameObject: NSObject {
    var components: [Component] = []
    var canPause = true

    
    // MARK: 添加组件到游戏对象
    func addComponent(component: Component) {
        components.append(component)
        // 组件到顶层游戏对象的引用
        component.gameObject = self
    }
    
    func remove(component : Component) {
        
        // Figure out the index at which this component exists
        
        // Note the use of the === (three equals) operator,
        // which checks to see if two variables refer to the same object
        // (as opposed to "==", which checks to see if two variables
        // have the same value, which means different things for
        // different types of data)
        
        if let index = components.index(where: { $0 === component}) {
            component.gameObject = nil
            components.remove(at: index)
        }
    }
    
    // Update this object by updating all components
    func update(deltaTime : Float) {
        for component in self.components {
            component.update(deltaTime: deltaTime)
        }
    }
    
    // Returns the first component of type T attached to this // game object
    func findComponent<T: Component>() -> T?{
        for component in self.components {
            if let theComponent = component as? T {
                return theComponent
            }
        }
        return nil;
    }
    
    // Returns an array of all components of type T
    // (this returned array might be empty)
    func findComponents<T: Component>() -> [T?] {
        // NOTE: this returns an array of T? (that is,
        // optionals), even though it doesn't strictly need
        // to. This is because Xcode 6.1.1's Swift compiler
        // was crashing when this function returned an array of T
        // (that is, non-optionals.) Your mileage may vary.
        
        var foundComponents : [T] = []
        
        for component in self.components {
            if let theComponent = component as? T {
                foundComponents.append(theComponent)
            }
        }
        return foundComponents
    }
}
