//
//  Timer.swift
//  GameDemo
//
//  Created by hezhiqiang on 2018/4/10.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import Foundation

// This is a dummy object, used in the example below.
class MovingObject {
    func move(distance: Double) {
    }
}
let someMovingObject = MovingObject()

// BEGIN deltatime_timekeeper
class TimeKeeper {
    var lastFrameTime : Double = 0.0
}
// END deltatime_timekeeper
extension TimeKeeper {
    // BEGIN deltatime_calculating
    func update(currentTime : Double) {
        // Calculate the time since this method was last called
        let deltaTime = currentTime - lastFrameTime
        // Move at 3 units per second
        let movementSpeed = 3.0
        // Multiply by deltaTime to work out how far
        // an object needs to move this frame
        someMovingObject.move(distance: movementSpeed * deltaTime)
        // Set last frame time to current time, so that
        // we can calculate the delta time when we're next
        // called
        self.lastFrameTime = currentTime
    }
    // END deltatime_calculating
    
    func currentTime() -> Double {
        // BEGIN deltatime_getting_current_time
        let currentTime = Date.timeIntervalSinceReferenceDate as Double
        return currentTime
        // END deltatime_getting_current_time
    }
}
