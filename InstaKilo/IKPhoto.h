//
//  IKPhoto.h
//  InstaKilo
//
//  Created by Renato Camilio on 1/29/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IKPhotoSubject) {
    IKPhotoSubjectScreenshot,
    IKPhotoSubjectCamera,
    IKPhotoSubjectWeb
};

typedef NS_ENUM(NSUInteger, IKPhotoLocation) {
    IKPhotoLocationSaoPaulo,
    IKPhotoLocationVancouver
};

@interface IKPhoto : NSObject

@property (nonatomic, strong) UIImage *image;
@property (assign) IKPhotoSubject subject;
@property (assign) IKPhotoLocation location;

+ (IKPhoto *)photoWithImage:(UIImage *)image andSubject:(IKPhotoSubject)subject andLocation:(IKPhotoLocation)location;

@end
