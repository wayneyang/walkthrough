//
//  ALPhotoViewController.m
//  Album
//
//  Created by sodas on 11/20/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALPhotoViewController.h"
#import "ALPhoto.h"

@interface ALPhotoViewController ()

- (void)setupImage;
- (void)centerScrollViewContents;

@end

@implementation ALPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Recognizer dependency
    [self.singleTapRecognizer requireGestureRecognizerToFail:self.doubleTapRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupImage];
    [self centerScrollViewContents];
    
    int64_t delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:.5f animations:^{
            self.titleLabel.alpha = 0.0f;
        }];
    });
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.scrollView.zoomScale = 1.0f;
    [self setupImage];
    [self centerScrollViewContents];
}

#pragma mark - method

- (void)setupImage {
    self.navigationItem.title = self.photoData[ALPhotoInfoLocationKey];
    self.titleLabel.text = self.photoData[ALPhotoInfoTitleKey];

    UIImage *image = [UIImage imageNamed:self.photoData[ALPhotoInfoImageKey]];
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    self.scrollView.contentSize = image.size;
    self.scrollView.clipsToBounds = YES;
    
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    
    self.scrollView.zoomScale = minScale; // scale to fit screen now
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size; // Sroll view size (always the same)
    CGRect contentsFrame = self.imageView.frame; // Current size of image viwe (scaled)
    
    if (contentsFrame.size.width < boundsSize.width) {
        // image is smaller than screen ... center it
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        // image is smaller than screen ... center it
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0;
    }
    
    self.imageView.frame = contentsFrame;
}

#pragma mark - ScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [self centerScrollViewContents];
}

#pragma mark - IBAction

- (IBAction)done:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)singleTap:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration:.5f animations:^{
        self.titleLabel.alpha = self.titleLabel.alpha?0.0f:1.0f;
    }];
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden
                                             animated:YES];
    
    int64_t delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:.75f animations:^{
            self.titleLabel.alpha = 0.0f;
        }];
    });
}

- (IBAction)doubleTap:(UITapGestureRecognizer *)recognizer {    
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

@end
