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
    NSArray *words;
}
@property (strong, nonatomic) IBOutlet UILabel *pageNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *JapVoc;
@property (strong, nonatomic) IBOutlet UILabel *ChineseCharacter;
@property (strong, nonatomic) IBOutlet UILabel *WordType;
@property (strong, nonatomic) IBOutlet UILabel *ChineseExplain;
@property (nonatomic, strong) NSString *topic;
- (id)initWithPageNumber:(int)page :(NSString*)topic;


@end
