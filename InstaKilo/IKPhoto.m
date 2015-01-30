//
//  IKPhoto.m
//  InstaKilo
//
//  Created by Renato Camilio on 1/29/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "IKPhoto.h"

@implementation IKPhoto

+ (IKPhoto *)photoWithImage:(UIImage *)image andSubject:(IKPhotoSubject)subject andLocation:(IKPhotoLocation)location {
    IKPhoto *newPhoto = [[IKPhoto alloc] init];
    newPhoto.image = image;
    newPhoto.subject = subject;
    newPhoto.location = location;
    
    return newPhoto;
}

@end
