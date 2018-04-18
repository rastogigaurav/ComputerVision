//
//  UIImage+OpenCV.h
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/18/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif


@interface UIImage (OpenCV)

+ (UIImage *)imageFromCVMat:(cv::Mat)mat;

- (cv::Mat)cvMatRepresentationColor;
- (cv::Mat)cvMatRepresentationGray;

@end
