//
//  VisionWrapperMock.swift
//  ComputerVisionTests
//
//  Created by Gaurav Rastogi on 4/21/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

@testable import ComputerVision

class VisionWrapperMock: NSObject,FeatureDetectionProtocol {
    var startCaptureCalled = false
    var stopCaptureCalled = false
    var pointOfInterestCalled = false
    
    func startCapture() {
        self.startCaptureCalled = true
    }
    
    func stopCapture() {
        self.stopCaptureCalled = true
    }
    
    func point(ofInterest point: CGPoint) {
        self.pointOfInterestCalled = true
    }
}
