//
//  ALChoiceViewController.h
//  walkthrough
//
//  Created by wayneyang on 13/6/8.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ALChoiceViewController :  UIViewController
- (IBAction)done:(id)sender;
- (IBAction)VacLesson:(id)sender;
@property (nonatomic, strong) NSString *topic;

@end
