//
//  ALlesson.m
//  walkthrough
//
//  Created by wayneyang on 13/6/5.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALlesson.h"
#import "ALDataSource.h"
@implementation ALlesson
/*- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    UIImage *image = [UIImage imageNamed:@"lesson.jpg"];
    self.Image.image = image;
}
- (void)viewDidLoad {    UIImage *image = [UIImage imageNamed:@"lesson.jpg"];
    self.Image.image = image;

}*/
// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    // if (self = [super initWithNibName:@"MyViewController" bundle:nil]) {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle:[NSBundle mainBundle]];
    ALlesson *myViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    self = myViewController;
    pageNumber = page;
    
    //}
    return self;
}



// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    
    NSArray *topics= [[ALDataSource sharedDataSource] arrayWithTopics];
    words = [[ALDataSource sharedDataSource] arrayWithWordsInTopics:@"人體"];
    //NSLog(@"yyoyoyo%@", [wordList[1] class]);
    //NSDictionary *word =wordList[pageNumber];
    
    //NSLog(@"%@",word[ALDataSourceDictKeyType] );
    UIImage *image = [UIImage imageNamed:@"lesson.jpg"];
    self.Image.image = image;

    
    
}

@end
