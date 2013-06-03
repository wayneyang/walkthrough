//
//  ALSingleWordViewController.h
//  walkthrough
//
//  Created by wayneyang on 13/6/3.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ALSingleWordViewController : UIViewController
{
    int pageNumber;

}
@property (strong, nonatomic) IBOutlet UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;


@end
