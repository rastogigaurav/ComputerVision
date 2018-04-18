//
//  LiveCameraViewModel.swift
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/18/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Foundation

struct LiveCameraViewModel {
    
    var wrapper:FeatureDetectionProtocol
    
    init( featureDetectionWrapper : FeatureDetectionProtocol) {
        self.wrapper = featureDetectionWrapper
    }
    
    func didAppear(){
        self.wrapper.startCapture()
    }
    
    func willDisappear(){
        self.wrapper.stopCapture()
    }
    
    func didTap(tappedPoint:CGPoint){
        self.wrapper.point!(ofInterest: tappedPoint)
    }
}

extension LiveCameraViewModel {
    static func create(with wrapperType:FeatureDetectionWrapperType, previewView: UIImageView, scale:CGFloat) -> LiveCameraViewModel{
        switch wrapperType {
        case .openCV:
            let wrapper = OpenCVWrapper(cameraView: previewView, scale: 2.0)!
            return LiveCameraViewModel(featureDetectionWrapper: wrapper)
        case .native:
            let wrapper = OpenCVWrapper(cameraView: previewView, scale: 2.0)!
            return LiveCameraViewModel(featureDetectionWrapper: wrapper)
        }
    }
}
