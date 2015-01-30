//
//  IKPhotosCollectionViewController.m
//  InstaKilo
//
//  Created by Renato Camilio on 1/29/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "IKPhotosCollectionViewController.h"
#import "IKPhotoCollectionViewCell.h"
#import "IKPhoto.h"
#import "IKHeaderCollectionReusableView.h"

@interface IKPhotosCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UISegmentedControl *groupingSegmentedControl;

@end

@implementation IKPhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.groupingSegmentedControl addTarget:self action:@selector(groupPhotos:) forControlEvents:UIControlEventValueChanged];
    [self setupPhotos];
}

- (NSArray *)photosWithSubject:(IKPhotoSubject)subject {
//    NSArray *groupingProperties = @[@"location", @"subject"];
//    NSInteger selectedGrouping = self.groupingSegmentedControl.selectedSegmentIndex;
    
    return [self.photos filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [(IKPhoto *)evaluatedObject subject] == subject;
    }]];
}

- (void)setupPhotos {
    NSArray *photos = @[@"IMG_0001", @"IMG_0002", @"IMG_0003", @"IMG_0004", @"IMG_0005",
                        @"IMG_0006.jpg", @"IMG_0007.jpg", @"IMG_0008.jpg", @"IMG_0009.jpg", @"IMG_0010"];
    self.photos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [photos count]; i++) {
        [self.photos addObject:[IKPhoto photoWithImage:[UIImage imageNamed:photos[i]] andSubject:i % 3 andLocation:i % 2]];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self photosWithSubject:section] count];
}

- (IKPhotoCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IKPhotoCollectionViewCell *cell = (IKPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.photo = [[self photosWithSubject:indexPath.section] objectAtIndex:indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        NSArray *subjectNames = @[@"Screeshot", @"Camera", @"Web"];
        IKHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:@"subjectHeader"
                                                                                         forIndexPath:indexPath];
        headerView.title.text = [subjectNames objectAtIndex:[[[self photosWithSubject:indexPath.section] objectAtIndex:indexPath.item] subject]];
        [headerView.title setTransform:CGAffineTransformMakeRotation(-M_PI_2 * 45)];
        
        return headerView;
    }
    
    return nil;
}

@end
