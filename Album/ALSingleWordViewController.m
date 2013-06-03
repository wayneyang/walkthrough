//
//  ALSingleWordViewController.m
//  walkthrough
//
//  Created by wayneyang on 13/6/3.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALSingleWordViewController.h"
static NSArray *__pageControlColorList = nil;

@implementation ALSingleWordViewController
// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
	
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
   // if (self = [super initWithNibName:@"MyViewController" bundle:nil]) {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle:[NSBundle mainBundle]];
    ALSingleWordViewController *myViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    self = myViewController;
    pageNumber = page;
    
    //}
    return self;
}



// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    //self.pageNumberLabel.text=@"abc";
    self.pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    self.view.backgroundColor = [ALSingleWordViewController pageControlColorWithIndex:pageNumber];

    }


@end
