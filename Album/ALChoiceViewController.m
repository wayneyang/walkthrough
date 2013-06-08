//
//  ALChoiceViewController.m
//  walkthrough
//
//  Created by wayneyang on 13/6/8.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALChoiceViewController.h"
#import "ALWordViewController.h"
@implementation ALChoiceViewController

- (IBAction)done:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)VacLesson:(id)sender {

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle:[NSBundle mainBundle]];
    ALWordViewController *myViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"wordView"];
    myViewController.topic =self.topic;
    [self.navigationController pushViewController:myViewController animated:YES];
}
@end
