//
//  ALlesson.h
//  walkthrough
//
//  Created by wayneyang on 13/6/5.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ALlesson : UIViewController<UIScrollViewDelegate>
{
    int pageNumber;
    NSArray *words;
}
@property (strong, nonatomic) IBOutlet UIImageView *Image;
- (id)initWithPageNumber:(int)page;
@property (strong, nonatomic) IBOutlet UILabel *LessonLabel;
- (IBAction)TapPresssed:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@end
