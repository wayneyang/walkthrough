//
//  ALCameraViewController.h
//  Album
//
//  Created by sodas on 11/21/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALCameraViewController : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (IBAction)openPhotoPicker:(id)sender;
- (IBAction)doMagic:(id)sender;

@end
