//
//  IKPhotoCollectionViewCell.h
//  InstaKilo
//
//  Created by Renato Camilio on 1/29/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKPhoto.h"


@interface IKPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IKPhoto *photo;

- (void)setPhoto:(IKPhoto *)photo;

@end
