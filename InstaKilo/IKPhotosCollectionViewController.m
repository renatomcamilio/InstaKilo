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
    
    [self.groupingSegmentedControl addTarget:self action:@selector(didChangeGroupingType) forControlEvents:UIControlEventValueChanged];
    [self setupPhotos];
}

- (void)didChangeGroupingType {
    [self.collectionView reloadData];
//    [self.collectionView performBatchUpdates:^{
//        // reorder stuff based on indexPath, so it will animate...
//    } completion:^(BOOL finished) {
//        return;
//    }];
}

- (NSArray *)photosWithSection:(NSInteger)section {
    NSArray *groupingProperties = @[@"location", @"subject"];
    NSString *selectedGroupingType = [groupingProperties objectAtIndex:[self.groupingSegmentedControl selectedSegmentIndex]];
    
    return [self.photos filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [[(IKPhoto *)evaluatedObject valueForKey:selectedGroupingType] integerValue] == section;
    }]];
}

- (void)setupPhotos {
    NSArray *photoNames = @[@"IMG_0001", @"IMG_0002", @"IMG_0003", @"IMG_0004", @"IMG_0005",
                        @"IMG_0006.jpg", @"IMG_0007.jpg", @"IMG_0008.jpg", @"IMG_0009.jpg", @"IMG_0010"];
    self.photos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [photoNames count]; i++) {
        [self.photos addObject:[IKPhoto photoWithImage:[UIImage imageNamed:photoNames[i]] andSubject:i % 3 andLocation:i % 2]];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    int sections;
    
    switch ([self.groupingSegmentedControl selectedSegmentIndex]) {
        case 0:
            sections = 2; //group items by location
            break;
        case 1:
            sections = 3; //group items by subject
            break;
        default:
            break;
    }
    
    return sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self photosWithSection:section] count];
}

- (IKPhotoCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IKPhotoCollectionViewCell *cell = (IKPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.photo = [[self photosWithSection:indexPath.section] objectAtIndex:indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        NSArray *subjectNames = @[@"Screeshot", @"Camera", @"Web"];
        NSArray *locationNames = @[@"Sao Paulo", @"Vancouver"];
        NSArray *groupingNames = @[locationNames, subjectNames];
        
        IKHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        withReuseIdentifier:@"subjectHeader"
                                                                                               forIndexPath:indexPath];
        
        NSArray *currentGroupingNames = [groupingNames objectAtIndex:self.groupingSegmentedControl.selectedSegmentIndex];

        headerView.title.text = [currentGroupingNames objectAtIndex:indexPath.section];
        [headerView.title setTransform:CGAffineTransformMakeRotation(-M_PI_2 * 45)];
        
        return headerView;
    }
    
    return nil;
}

@end
