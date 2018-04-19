//
//  OpenCVViewController.swift
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/16/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

class OpenCVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(OpenCVWrapper.openCVVersionString())")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOpenCVLiveCamera"{
            if let liveCameraViewController = segue.destination as? LiveCameraViewController{
                liveCameraViewController.wrapperType = .openCV
            }
        }
    }
}
