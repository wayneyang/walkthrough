//
//  ALPageViewController.m
//  Album
//
//  Created by sodas on 11/20/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALPageViewController.h"

@interface ALPageViewController ()

@end

@implementation ALPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Why set here?
    CGSize frameSize = self.view.frame.size;
    self.scrollView.contentSize = CGSizeMake(frameSize.width*3, frameSize.height);
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat width = self.scrollView.frame.size.width;

    // Change to next page if you scroll over than half page.
    NSInteger currentPage = ((self.scrollView.contentOffset.x - width / 2) / width) + 1;
    self.pageControl.currentPage = currentPage;
}

@end
