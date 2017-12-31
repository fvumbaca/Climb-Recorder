//
//  ReadingManager.swift
//  ClimbRecorder
//
//  Created by Frank Vumbaca on 2017-12-30.
//  Copyright © 2017 Frank Vumbaca. All rights reserved.
//

import Foundation
import CoreMotion

struct MotionReading {
    let time: Date
    let accelX: Float
    let accelY: Float
    let accelZ: Float
}

protocol MotionReadingHandler {
    func readingStarted()
    func readingEnded()
    func onRead(reading: MotionReading)
}

class ReadingManager {
    
    static let INITAL_READ_RATE = 1.0 / 30.0
    
    private var mManager: CMMotionManager
    private var queue: OperationQueue
    var readRate: Double {
        didSet {
            mManager.deviceMotionUpdateInterval = self.readRate
        }
    }
    
    var listener: MotionReadingHandler? {
        willSet {
            mManager.stopDeviceMotionUpdates()
        }
    }
    
    init() {
        mManager = CMMotionManager()
        mManager.deviceMotionUpdateInterval = ReadingManager.INITAL_READ_RATE
        readRate = ReadingManager.INITAL_READ_RATE
        queue = OperationQueue()
    }
    
    func read(motion: CMDeviceMotion) -> MotionReading {
        let accel = motion.userAcceleration
        let x = Float(accel.x),
            y = Float(accel.y),
            z = Float(accel.z)
        
        return MotionReading(time: Date(), accelX: x, accelY: y, accelZ: z)
    }
    
    func stopReadings() {
        mManager.stopDeviceMotionUpdates()
        if listener != nil {
            listener?.readingEnded()
        }
    }
    
    func startReadings() {
        if listener != nil {
            listener?.readingStarted()
        }
        mManager.startDeviceMotionUpdates(to: queue) { (motion, err) in
            if motion != nil {
                let reading = self.read(motion: motion!)
                self.listener?.onRead(reading: reading)
            }
        }
    }
    
}
