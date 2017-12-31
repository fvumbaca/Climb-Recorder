//
//  RecorderController.swift
//  ClimbRecorder
//
//  Created by Frank Vumbaca on 2017-12-28.
//  Copyright © 2017 Frank Vumbaca. All rights reserved.
//

import UIKit

class RecorderController: UIViewController, MotionReadingHandler {
    
    private let motionService = Service(withName: "MotionRecordingService")
    private let readingManager = ReadingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStartStopSessionClicked(_ sender: Any) {
        if motionService.isRunning {
            print("Stopping motion service...")
            readingManager.stopReadings()
        } else {
            print("Starting motion service...")
            readingManager.listener = self
            readingManager.startReadings()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Motion Recording
    func readingStarted() {
        motionService.start()
    }
    
    func readingEnded() {
        motionService.stop()
    }
    
    func onRead(reading: MotionReading) {
        
        // TODO: Record the data to core data
        
        print("The motion value reads: x:", reading.accelX, "y:", reading.accelY, "z:", reading.accelZ)
    }

}
