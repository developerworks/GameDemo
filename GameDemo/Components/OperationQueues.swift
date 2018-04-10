//
//  OperationQueues.swift
//  GameDemo
//
//  Created by hezhiqiang on 2018/4/11.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import Foundation

// TODO:: 如何获得资源加载的进度, 网络下载速度
// 资源总大小, 下载速度, 动态计算加载进度百分比

class OperationQueues: NSObject {
    
    // TODO: 在2D网格中存储对象
    // You want to store objects in a two-dimensional grid
    
    // TODO: 单元测试, 目标是隔离的测试游戏的不同部分, 保证每一个部分(组件)都能正常工作
    
    
    // MARK: 加载资源
    func loadImages() {
        // 要加载的资源清单
        let imagesToLoad = [
            "Image 1.jpg",
            "Image 2.jpg",
            "Image 3.jpg"
        ]
        // 后台操作队列
        let imageLoadingQueue = OperationQueue()
        
        // 队列参数
        imageLoadingQueue.qualityOfService = QualityOfService.background
        imageLoadingQueue.maxConcurrentOperationCount = 10
        
        // 完成回调
        let loadingComplete = BlockOperation { () -> Void in
            print("Loading complete!")
        }
        
        // 加载操作数组, 顺序处理
        var loadingOperations: [Operation] = []
        
        for image in imagesToLoad {
            let operation = BlockOperation { () -> Void in
                print("Loading image \(image)")
            }
            loadingOperations.append(operation)
            // 真个加载过程分为很多个操作, 把完成操作设置为依赖所有其他操作
            // 在其他所有加载操作完成后才调用
            loadingComplete.addDependency(operation)
        }
        // 添加加载操作数组和加载完成操作
        imageLoadingQueue.addOperations(loadingOperations, waitUntilFinished: true)
        imageLoadingQueue.addOperation(loadingComplete)
    }
    
    // MARK: [异步:asyncAfter]调度一个操作在未来执行
    func dispatchAt() {
        let dispatch_at = DispatchTime.now() + 10
        print("任务将在\(dispatch_at)执行")
        DispatchQueue.main.asyncAfter(deadline: dispatch_at) {
            let now = DispatchTime.now()
            print("执行时间: \(now)")
        }
    }
    
    // MARK: 通知主线程
    func notifyMainQueue() {
        // 后台操作队列
        let backgroundQueue = OperationQueue()
        backgroundQueue.addOperation { () -> Void in
            // TODO:: 在后台执行任务
            // 一旦后台任务完成, 在主线程中执行操作
            OperationQueue.main.addOperation({
                () -> Void in
                print("Notify main thread: ")
            })
        }
    }
    
    // MARK: 创建并行队列
    func createConcurrentQueue() -> OperationQueue {
        let concurrentQueue = OperationQueue()
        let mainQueue = OperationQueue.main
        
        mainQueue.addOperation { () -> Void in
            print("Main queue operation 1:")
        }
        mainQueue.addOperation {
            () -> Void in
            print("Main queue operation 2:")
        }
        mainQueue.addOperation {
            () -> Void in
            print("Main queue operation 3:")
        }
        
        // 任务并行度取决于几个条件, 包括:
        // - CPU的核心数
        // - 任务优先级
        // 默认情况, 如果不指定该属性, 由操作队列来决定同时可以并行执行多少任务.
        concurrentQueue.maxConcurrentOperationCount = 10
        
        concurrentQueue.addOperation {
            self.task1()
        }
        concurrentQueue.addOperation {
            self.task2()
        }
        concurrentQueue.addOperation {
            self.task3()
        }
        return concurrentQueue
    }
    
    func task1() {
        
    }
    func task2() {
        
    }
    func task3() {
        
    }
    func SaveGame() {
    }
    func DownloadMaps() {
    }
    func UploadScore() {
        
    }
}
