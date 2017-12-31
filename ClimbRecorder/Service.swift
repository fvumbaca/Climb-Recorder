//
//  Service.swift
//  ClimbRecorder
//
//  Created by Frank Vumbaca on 2017-12-30.
//  Copyright © 2017 Frank Vumbaca. All rights reserved.
//

import UIKit
class Service {
    
    let name: String?
    
    private var app: UIApplication {
        get {
            return UIApplication.shared
        }
    }
    
    var isRunning: Bool {
        get {
            return self.currentTaskPID != nil
        }
    }
    
    private var currentTaskPID: UIBackgroundTaskIdentifier? {
        willSet {
            if currentTaskPID != nil {
                app.endBackgroundTask(currentTaskPID!)
            }
        }
    }
    
    init(withName: String? = nil) {
        name = withName
    }
    
    // MARK: - Controls
    
    func start() {
        currentTaskPID = app.beginBackgroundTask(withName: name) {
            self.start()
        }
    }
    
    func stop() {
        currentTaskPID = nil
    }
}
