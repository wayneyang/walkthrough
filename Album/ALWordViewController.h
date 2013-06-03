//
//  ALWordViewController.h
//  walkthrough
//
//  Created by wayneyang on 13/6/2.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//
#import<UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ALWordViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *viewControllers;


}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@end
