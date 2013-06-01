//
//  ALPhotoViewController.h
//  Album
//
//  Created by sodas on 11/20/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALPhotoViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *singleTapRecognizer;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSDictionary *photoData;

- (IBAction)done:(id)sender;
- (IBAction)singleTap:(UITapGestureRecognizer *)recognizer;
- (IBAction)doubleTap:(UITapGestureRecognizer *)recognizer;

@end
