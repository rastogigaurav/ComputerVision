//
//  NativeViewController.swift
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/16/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

class NativeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNativeLiveCamera"{
            if let liveCameraViewController = segue.destination as? LiveCameraViewController{
                liveCameraViewController.wrapperType = .native
            }
        }
    }
}
