//
//  FeatureDetectionProtocol.h
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/19/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FeatureDetectionProtocol <NSObject>

- (void)startCapture;
- (void)stopCapture;

@optional
- (void)pointOfInterest:(CGPoint )point;

@end
