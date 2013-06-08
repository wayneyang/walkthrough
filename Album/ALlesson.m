//
//  ALlesson.m
//  walkthrough
//
//  Created by wayneyang on 13/6/5.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALlesson.h"
#import "ALSingleWordViewController.h"
#import "ALDataSource.h"
@implementation ALlesson
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
    ALlesson *myViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LessonView"];
    self = myViewController;
    pageNumber = page;
    self.Image.userInteractionEnabled = YES;
    //}
    return self;
}

- (IBAction)TapPresssed:(id)sender {
    [[self LessonLabel]setText:@"sucess"];
    [self performSegueWithIdentifier:@"showChoice" sender:self];

    /*UIStoryboard *mStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle:[NSBundle mainBundle]];
    ALSingleWordViewController *SecondViewController = [mStoryBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    SecondViewController.JapVoc.text=@"yoyoyo";
    SecondViewController.view.backgroundColor = [UIColor blackColor];
    [self.navigationController pushViewController:SecondViewController animated:YES];
    //self.LessonLabel.text=@"not working";*/
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
    NSString *label = [NSString stringWithFormat:@"第%d日",pageNumber] ;
    self.LessonLabel.text=label;
    
    
    
}
#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   // UITableViewCell *cell = (UITableViewCell *)sender;
    
    if ([segue.identifier isEqualToString:@"showChoice]"]) {
        NSArray *topics= [[ALDataSource sharedDataSource] arrayWithTopics];
        words = [[ALDataSource sharedDataSource] arrayWithWordsInTopics:@"人體"];
        
        /* // Fetch data by index path from data source
        NSIndexPath *continentIndex = [self.tableView indexPathForCell:cell];
        NSString *continent=[[CTDataSource sharedDataSource] arrayWithContinents][continentIndex.row];
        
        // Feed data to the destination of the segue
        CTCityListViewController *cityPage = segue.destinationViewController;
        cityPage.continent = continent;
        */
    }
}


@end
