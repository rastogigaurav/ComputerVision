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
    var viewModel : LiveCameraViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = LiveCameraViewModel(featureDetectionWrapper: openCVWrapper)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDidAppear(){
        self.viewModel.didAppear()
        XCTAssertTrue(self.openCVWrapper.startCaptureCalled)
    }
    
    func testWillDisappear(){
        self.viewModel.willDisappear()
        XCTAssertTrue(self.openCVWrapper.stopCaptureCalled)
    }
    
    func testDidTap(){
        self.viewModel.didTap(tappedPoint: CGPoint())
        XCTAssertTrue(self.openCVWrapper.pointOfInterestCalled)
    }
}
