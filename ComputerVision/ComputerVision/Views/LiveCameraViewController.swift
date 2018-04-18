//
//  LiveCameraViewController.swift
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/18/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

class LiveCameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIImageView!
    var wrapperType:FeatureDetectionWrapperType!
    
    var viewModel:LiveCameraViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.didAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.willDisappear()
    }
    
    func setupViewModel(){
        self.viewModel = LiveCameraViewModel.create(with: wrapperType, previewView: self.cameraView, scale: 2.0)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTap(_ gesture:UITapGestureRecognizer) ->Void{
        if gesture.state == .ended {
            self.viewModel.didTap(tappedPoint: gesture.location(in: self.cameraView))
        }
    }
}
