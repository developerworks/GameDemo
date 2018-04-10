//
//  Events.swift
//  GameDemo
//
//  Created by hezhiqiang on 2018/4/10.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import Foundation
import UIKit

class ApplicationEvent: NSObject {
    
    static let shared = ApplicationEvent.init()
    
    // MARK: 注册事件处理器
    func registerHandlers()  {
        let center = NotificationCenter.default
        let didBecomeActive = #selector(
            self.applicationDidBecomeActive
        )
        let willEnterForeground = #selector(
            self.applicationWillEnterForeground
        )
        let willResignActive = #selector(
            self.applicationWillResignActive
        )
        let didEnterBackground = #selector(
            self.applicationDidEnterBackground
        )
        // 变为活动状态
        center.addObserver(
            self,
            selector: didBecomeActive,
            name: Notification.Name.UIApplicationDidBecomeActive,
            object: nil
        )
        // 将要进入后台
        center.addObserver(
            self,
            selector: willEnterForeground,
            name: Notification.Name.UIApplicationWillEnterForeground,
            object: nil
        )
        // 将要进入不活动状态
        center.addObserver(
            self,
            selector: willResignActive,
            name: Notification.Name.UIApplicationWillResignActive,
            object: nil
        )
        // 已进入后台
        center.addObserver(
            self,
            selector: didEnterBackground,
            name: Notification.Name.UIApplicationDidEnterBackground,
            object: nil
        )
    }
    
    @objc private func applicationDidBecomeActive(notification : Notification) {
        print("Application became active")
    }
    
    @objc private func applicationDidEnterBackground(notification : Notification) {
        print("Application entered background - unload textures!")
    }
    
    @objc private func applicationWillEnterForeground(notification : Notification) {
        print("Application will enter foreground - reload any textures that were unloaded")
    }
    
    @objc private func applicationWillResignActive(notification : Notification) {
        print("Application will resign active - pause the game now!")
    }
    
    deinit {
        // Remove this object from the notification center
        NotificationCenter.default.removeObserver(self)
    }
}
