//
//  ALWordViewController.m
//  walkthrough
//
//  Created by wayneyang on 13/6/2.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//
//#import "ALSingleWordViewController.h"
#import "ALWordViewController.h"
#import "ALlesson.h"
#import "ALDataSource.h"
#import "ALSingleWordViewController.h"
static NSUInteger kNumberOfPages = 13;

@interface ALWordViewController ()

@end
@implementation ALWordViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	// view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    //set kNumberPages as word in topic pages
    kNumberOfPages =[[[ALDataSource sharedDataSource] arrayWithWordsInTopics:self.topic]count];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    viewControllers = controllers;
    //[controllers release];
	
    // a page is the width of the scroll view
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * kNumberOfPages, self.scrollView.frame.size.height-self.navigationController.navigationBar.frame.size.height
);
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
	
    self.pageControl.numberOfPages = kNumberOfPages;
    self.pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0:self.topic];
    //[self loadScrollViewWithPage:1:_topic];
}

- (void)loadScrollViewWithPage:(int)page  :(NSString*)topic {
    
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    // replace the placeholder if necessary
    ALSingleWordViewController *controller = [viewControllers objectAtIndex:page];
    //ALlesson *controller= [viewControllers objectAtIndex:page];
    
    
    if ((NSNull *)controller == [NSNull null]) {
        //controller = [[ALlesson alloc] initWithPageNumber:page];
        //[viewControllers replaceObjectAtIndex:page withObject:controller];
        controller = [[ALSingleWordViewController alloc] initWithPageNumber:page:topic];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    //if (_pageControl) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
      //  return;
   // }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1:_topic];
    [self loadScrollViewWithPage:page:_topic];
    [self loadScrollViewWithPage:page + 1:_topic];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}
/*
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = self.pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    //pageControlUsed = YES;
}







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
}*/

@end
