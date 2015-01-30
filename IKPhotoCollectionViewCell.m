//
//  IKPhotoCollectionViewCell.m
//  InstaKilo
//
//  Created by Renato Camilio on 1/29/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "IKPhotoCollectionViewCell.h"

@implementation IKPhotoCollectionViewCell

- (void)setPhoto:(IKPhoto *)photo {
    _photo = photo;
    _photoImageView.image = photo.image;
}

@end
