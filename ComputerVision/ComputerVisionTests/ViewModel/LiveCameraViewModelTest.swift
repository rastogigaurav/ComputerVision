//
//  LiveCameraViewModelTest.swift
//  ComputerVisionTests
//
//  Created by Gaurav Rastogi on 4/19/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import XCTest

@testable import ComputerVision

class LiveCameraViewModelTest: XCTestCase {
    
    var openCVWrapper = OpenCVWrapperMock()
    var visionWrapper = VisionWrapperMock()
    var viewModel : LiveCameraViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDidAppearForOpenCV(){
        self.viewModel = LiveCameraViewModel(featureDetectionWrapper: openCVWrapper)
        self.viewModel.didAppear()
        XCTAssertTrue(self.openCVWrapper.startCaptureCalled)
    }
    
    func testWillDisappearForOpenCV(){
        self.viewModel = LiveCameraViewModel(featureDetectionWrapper: openCVWrapper)
        self.viewModel.willDisappear()
        XCTAssertTrue(self.openCVWrapper.stopCaptureCalled)
    }
    
    func testDidTapForOpenCV(){
        self.viewModel = LiveCameraViewModel(featureDetectionWrapper: openCVWrapper)
        self.viewModel.didTap(tappedPoint: CGPoint())
        XCTAssertTrue(self.openCVWrapper.pointOfInterestCalled)
    }
    
    func testDidAppearForVisionFramework(){
        self.viewModel = LiveCameraViewModel(featureDetectionWrapper: visionWrapper)
        self.viewModel.didAppear()
        XCTAssertTrue(self.visionWrapper.startCaptureCalled)
    }
    
    func testWillDisappearForVisionFramework(){
        self.viewModel = LiveCameraViewModel(featureDetectionWrapper: visionWrapper)
        self.viewModel.willDisappear()
        XCTAssertTrue(self.visionWrapper.stopCaptureCalled)
    }    
}
