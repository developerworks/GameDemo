//
//  GameViewController.swift
//  GameDemo
//
//  Created by hezhiqiang on 2018/4/10.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import QuartzCore

class GameViewController: UIViewController {
    
    var displayLink: CADisplayLink?
    var gameStartAt: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        ApplicationEvent.shared.registerHandlers()
        
        var _: Timer? = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateWith), userInfo: nil, repeats: true)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.screenUpdate))
        self.displayLink?.add(to: RunLoop.main, forMode: .commonModes)
        self.displayLink?.isPaused = true
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
    
    @objc func screenUpdate(displayLink: CADisplayLink)  {
        print("screen updated: \(displayLink)")
    }
    
    @objc func updateWith(timer: Timer)  {
//        print("Timer went off!")
        let now: Date = Date()
        let interval = now.timeIntervalSince(self.gameStartAt)
//        print("游戏运行时间, \(interval) 秒.")
    }

    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
