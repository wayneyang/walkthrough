//
//  ALAlbumViewController.m
//  Album
//
//  Created by sodas on 11/20/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALAlbumViewController.h"
#import "ALPhotoViewController.h"
#import "ALPhoto.h"

#define TagOfImageViewInCell 1001
#define TagOfLabelInSupplementatyHeader 1001

@interface ALAlbumViewController ()

@end

@implementation ALAlbumViewController

#pragma mark - Data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[[ALPhoto sharedSource] arrayOfLocations] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *location = [[ALPhoto sharedSource] arrayOfLocations][section];
    NSArray *photos = [[ALPhoto sharedSource] arrayWithPhotosInLocation:location];
    
    return [photos count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *albumHeadIdentifier = @"AlbumHeader";
    
    UICollectionReusableView *supplementaryView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                               withReuseIdentifier:albumHeadIdentifier
                                                                      forIndexPath:indexPath];
        UILabel *label = (UILabel *)[supplementaryView viewWithTag:TagOfLabelInSupplementatyHeader];
        label.text = [[ALPhoto sharedSource] arrayOfLocations][indexPath.section];
    }
    return supplementaryView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *landscapeImageCellIdentifier = @"LandscapePhoto";
    static NSString *portraitImageCellIdentifier = @"PortraitPhoto";
    
    // Get data first
    NSDictionary *photo = [[ALPhoto sharedSource] photoAtIndexPath:indexPath];
    
    // Direction
    NSString *cellIdentifier = nil;
    NSString *direction = photo[ALPhotoInfoDirectionKey];
    if ([direction isEqualToString:@"L"]) { // Landscape
        cellIdentifier = landscapeImageCellIdentifier;
    } else if ([direction isEqualToString:@"P"]) { // Portrait
        cellIdentifier = portraitImageCellIdentifier;
    }
    
    // Get cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                           forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:TagOfImageViewInCell];
    imageView.image = [UIImage imageNamed:photo[ALPhotoInfoThumbKey]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Get data first
    NSString *location = [[ALPhoto sharedSource] arrayOfLocations][indexPath.section];
    NSArray *photos = [[ALPhoto sharedSource] arrayWithPhotosInLocation:location];
    NSDictionary *photo = photos[indexPath.row];
    
    // Direction
    NSString *direction = photo[ALPhotoInfoDirectionKey];
    if ([direction isEqualToString:@"L"]) {
        return CGSizeMake(88.0f, 66.0f);
    } else {
        return CGSizeMake(66.0f, 88.0f);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ShowDetail" sender:cell];
}

// Menu: Table view delegate has the same api.

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView
//      canPerformAction:(SEL)action
//    forItemAtIndexPath:(NSIndexPath *)indexPath
//            withSender:(id)sender {
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView
//         performAction:(SEL)action
//    forItemAtIndexPath:(NSIndexPath *)indexPath
//            withSender:(id)sender {
//    // Copy, Cut, and Paste only
//}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        // Get data
        UICollectionViewCell *cell = (UICollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        NSDictionary *photo = [[ALPhoto sharedSource] photoAtIndexPath:indexPath];
        
        ALPhotoViewController *dest = (ALPhotoViewController *)[[segue destinationViewController] topViewController];
        dest.photoData = photo;
    }
}

@end
