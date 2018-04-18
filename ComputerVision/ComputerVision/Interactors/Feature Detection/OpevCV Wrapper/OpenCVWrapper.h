//
//  OpenCVWrapper.h
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/18/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FeatureDetectionProtocol.h"

@interface OpenCVWrapper : NSObject <FeatureDetectionProtocol>

- (instancetype)initWithCameraView:(UIImageView *)view scale:(CGFloat)scale;

- (NSArray *)detectedFaces;
- (UIImage *)faceWithIndex:(NSInteger)idx;

+ (NSString *)openCVVersionString;

@end
