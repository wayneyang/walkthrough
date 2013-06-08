//
//  ALCollectionViewController.m
//  walkthrough
//
//  Created by wayneyang on 13/6/8.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//
#import "ALDataSource.h"
#import "ALCollectionViewController.h"
#import "ALCollectionViewControllerCell.h"
#import "ALWordViewController.h"
#import "ALChoiceViewController.h"
@interface ALCollectionViewController()
@end

@implementation ALCollectionViewController
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {        
    return [[[ALDataSource sharedDataSource] arrayWithTopics]count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *lessonCellIdentifier = @"lesson";
    // Get cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lessonCellIdentifier
                                                                           forIndexPath:indexPath];
    ALCollectionViewControllerCell *lessonCell = (ALCollectionViewControllerCell *)cell;

    lessonCell.LessonName.text = [NSString stringWithFormat:@"%@%@",@"", [[ALDataSource sharedDataSource]arrayWithTopics][indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showWord" sender:cell];
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    if ([segue.identifier isEqualToString:@"showWord"]) {
        // Fetch data by index path from data source
        UICollectionViewCell *cell = (UICollectionViewCell *)sender;
        NSIndexPath *wordIndex = [self.collectionView indexPathForCell:cell];
        NSString *topicSelect=[[ALDataSource sharedDataSource] arrayWithTopics][wordIndex.row];
        
        // Feed data to the destination of the segue
        ALChoiceViewController *choicePage = (ALChoiceViewController *)[[segue destinationViewController] topViewController];
        choicePage.topic = topicSelect;
        
        //ALWordViewController *wordPage = (ALWordViewController *)[[segue destinationViewController] topViewController];
        //wordPage.topic = topicSelect;
        
    }
}

@end
