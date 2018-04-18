//
//  OpenCVWrapper.m
//  ComputerVision
//
//  Created by Gaurav Rastogi on 4/18/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+OpenCV.h"
#import "VideoCamera.h"

using namespace cv;

@interface OpenCVWrapper () <CvVideoCameraDelegate>{
    CascadeClassifier _faceDetector;
    
    std::vector<cv::Rect> _faceRects;
    std::vector<cv::Mat> _faceImgs;
}

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) VideoCamera* videoCamera;

@end

@implementation OpenCVWrapper

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

-(instancetype)initWithCameraView:(UIImageView *)view scale:(CGFloat)scale {
    self = [super init];
    if (self) {
        self.videoCamera = [[VideoCamera alloc] initWithParentView:view];
        self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
        self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        self.videoCamera.defaultFPS = 30;
        self.videoCamera.grayscaleMode = NO;
        self.videoCamera.delegate = self;
        self.videoCamera.letterboxPreview = YES;
        self.scale = scale;

        NSString *faceCascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2" ofType:@"xml"];
        
        const CFIndex CASCADE_NAME_LEN = 2048;
        char *CASCADE_NAME = (char *) malloc(CASCADE_NAME_LEN);
        CFStringGetFileSystemRepresentation( (CFStringRef)faceCascadePath, CASCADE_NAME, CASCADE_NAME_LEN);
        
        _faceDetector.load(CASCADE_NAME);
        free(CASCADE_NAME);
    }
    
    return self;
}

- (void)startCapture {
    [self.videoCamera start];
}

- (void)stopCapture {
    [self.videoCamera stop];
}

- (void)pointOfInterest:(CGPoint)point {
    if (self.videoCamera.running){
        [self.videoCamera setPointOfInterestInParentViewSpace:point];
    }
}

- (NSArray *)detectedFaces {
    NSMutableArray *facesArray = [NSMutableArray array];
    for( std::vector<cv::Rect>::const_iterator r = _faceRects.begin(); r != _faceRects.end(); r++ )
    {
        CGRect faceRect = CGRectMake(_scale*r->x/480., _scale*r->y/640., _scale*r->width/480., _scale*r->height/640.);
        [facesArray addObject:[NSValue valueWithCGRect:faceRect]];
    }
    return facesArray;
}

- (UIImage *)faceWithIndex:(NSInteger)idx {
    
    cv::Mat img = self->_faceImgs[idx];
    
    UIImage *ret = [UIImage imageFromCVMat:img];
    
    return ret;
}

- (void)processImage:(cv::Mat&)image {
    [self detectAndDrawFacesOn:image scale:_scale];
}

- (void)detectAndDrawFacesOn:(Mat&) img scale:(double) scale
{
    int i = 0;
    double t = 0;
    
    const static Scalar colors[] =  { CV_RGB(0,0,255),
        CV_RGB(0,128,255),
        CV_RGB(0,255,255),
        CV_RGB(0,255,0),
        CV_RGB(255,128,0),
        CV_RGB(255,255,0),
        CV_RGB(255,0,0),
        CV_RGB(255,0,255)} ;
    Mat gray, smallImg( cvRound (img.rows/scale), cvRound(img.cols/scale), CV_8UC1 );
    
    cvtColor( img, gray, COLOR_BGR2GRAY );
    resize( gray, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
    equalizeHist( smallImg, smallImg );
    
    
    
    t = (double)cvGetTickCount();
    double scalingFactor = 1.1;
    int minRects = 2;
    cv::Size minSize(30,30);
    
    self->_faceDetector.detectMultiScale( smallImg, self->_faceRects,
                                         scalingFactor, minRects, 0,
                                         minSize );
    
    t = (double)cvGetTickCount() - t;
    std::vector<cv::Mat> faceImages;
    
    for( std::vector<cv::Rect>::const_iterator r = _faceRects.begin(); r != _faceRects.end(); r++, i++ )
    {
        cv::Mat smallImgROI;
        cv::Point center;
        Scalar color = colors[i%8];
        std::vector<cv::Rect> nestedObjects;
        rectangle(img,
                  cvPoint(cvRound(r->x*scale), cvRound(r->y*scale)),
                  cvPoint(cvRound((r->x + r->width-1)*scale), cvRound((r->y + r->height-1)*scale)),
                  color, 1, 8, 0);
        
        smallImgROI = smallImg(*r);
        
        faceImages.push_back(smallImgROI.clone());
    }
    
    @synchronized(self) {
        self->_faceImgs = faceImages;
    }
}

@end
