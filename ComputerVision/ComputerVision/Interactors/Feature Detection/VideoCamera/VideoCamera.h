//
//  VideoCamera.h
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/18/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

#import <opencv2/videoio/cap_ios.h>

@interface VideoCamera : CvVideoCamera

@property BOOL letterboxPreview;

- (void)setPointOfInterestInParentViewSpace:(CGPoint)point;

@end
