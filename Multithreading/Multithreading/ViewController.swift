//
//  ViewController.swift
//  Multithreading
//
//  Created by P, Rajeswari on 12/05/19.
//  Copyright © 2019 P, Rajeswari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performAsyncTaskIntoConcurrentQueue(with: {
            print("###### All images are downloaded")
        })
       // workItem()
        //synnQueue()
        //asynnQueue()
        //queuesWithQos()
        //queuesWithQosWithTwoDifferentPriorites()
        //queuesWithQosWithThreeoDifferentPriorites()
    }

    // Dispatch Group
    
    func performAsyncTaskIntoConcurrentQueue(with completion: @escaping () -> ()) {
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        let group = DispatchGroup()
        for i in 1...5 {
            concurrentQueue.async {
                group.enter()
                let imageURL = URL(string: "https://i.stack.imgur.com/Xs4RX.jpg")!
                let _ = try! Data(contentsOf: imageURL)
                print("###### Image \(i) Downloaded ######")
                group.leave()
            }
        }
        
         group.wait()
         DispatchQueue.main.async {
         completion()
         }
        
        group.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
// Work Item
    
    func workItem() {
        var workItem: DispatchWorkItem?
        workItem = DispatchWorkItem {
            for i in 1..<6 {
                guard let item = workItem, !item.isCancelled else {
                    print("cancelled")
                    break
                }
                sleep(1)
                print(String(i))
            }
        }
        
        workItem?.notify(queue: .main) {
            print("done")
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            workItem?.cancel()
        }
        DispatchQueue.main.async(execute: workItem!)
    }
    // Sync Queues
    
    func synnQueue() {
        let queue = DispatchQueue(label: "com.multithreading")
        queue.sync {
            for i in 0..<10 {
                print("Order is",i)
            }
        }
        
        for i in 100..<110 {
            print("Order is",i)
        }
    }
    
    // Async Queues
    
    func asynnQueue() {
        let queues = DispatchQueue(label: "com.multithreading")
        queues.async {
            for i in 0..<10 {
                print("async Order is",i)
            }
            
        }
        for i in 100..<110 {
            print("async oreder is",i)
        }
        
        DispatchQueue.main.sync {
            for i in 0..<100_000_000 {
                print("async Order is",i)
            }
            
            for j in 0..<100_000_000 {
                print("async Order is",j)
            }
            
            for i in 0..<100_000_000 {
                print("async Order is",i)
            }
            
            for j in 0..<100_000_000 {
                print("async Order is",j)
            }
        }
    }
    
    // Qos: Quality of Service
    
    func queuesWithQos() {
        
        let queue1 = DispatchQueue(label: "com.async1", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "com.async2", qos: .userInitiated)
        
        queue1.async {
            for i in 0..<10 {
                print("Queue1 order is", i)
            }
        }
        queue2.async {
            for i in 10..<20 {
                print("Queue2 order is", i)
            }
        }
    }
    
    func queuesWithQosWithTwoDifferentPriorites() {
        
        let queue1 = DispatchQueue(label: "com.async1", qos: .utility)
        let queue2 = DispatchQueue(label: "com.async2", qos: .userInitiated)
        let queue3 = DispatchQueue(label: "com.async3", qos: .userInitiated)
        
        queue1.async {
            for i in 0..<10 {
                print("Queue1 order is", i)
            }
        }
        
        queue2.async {
            for i in 100..<110 {
                print("Queue2 order is", i)
            }
        }
        
        queue3.async {
            for i in 10..<20 {
                print("Queue3 order is", i)
            }
        }
    }
    
    func queuesWithQosWithThreeoDifferentPriorites() {
        
        let queue1 = DispatchQueue(label: "com.async1", qos: .userInteractive)
        let queue2 = DispatchQueue(label: "com.async2", qos: .userInitiated)
        let queue3 = DispatchQueue(label: "com.async3", qos: .default)
        let queue4 = DispatchQueue(label: "com.async4", qos: .utility)
        let queue5 = DispatchQueue(label: "com.async5", qos: .background)
        let queue6 = DispatchQueue(label: "com.async6", qos: .unspecified)
        
        queue1.async {
            for i in 0..<10 {
                print("Queue1 order is", i)
            }
        }
        
        queue2.async {
            for i in 10..<20 {
                print("Queue2 order is", i)
            }
        }
        
        queue3.async {
            for i in 20..<30 {
                print("Queue3 order is", i)
            }
        }
        
        queue4.async {
            for i in 30..<40 {
                print("Queue4 order is", i)
            }
        }
        
        queue5.async {
            for i in 40..<50 {
                print("Queue5 order is", i)
            }
        }
        
        queue6.async {
            for i in 50..<60 {
                print("Queue6 order is", i)
            }
        }
    }
}

