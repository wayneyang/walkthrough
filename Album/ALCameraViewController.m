//
//  ALCameraViewController.m
//  Album
//
//  Created by sodas on 11/21/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALCameraViewController.h"
#import "UIImage+FixOrientation.h"
#import <CoreImage/CoreImage.h>

@interface ALCameraViewController () {
    NSOperationQueue *queue;
}

@end

@implementation ALCameraViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark - IBActions

- (IBAction)openPhotoPicker:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose a source"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    NSUInteger buttonCount = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:@"Camera"];
        ++buttonCount;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [actionSheet addButtonWithTitle:@"Photo Library"];
        ++buttonCount;
    }
    
    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex = buttonCount;
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (IBAction)doMagic:(id)sender {
    [self.loadingIndicator startAnimating];
    [UIView animateWithDuration:.5f animations:^{
        self.imageView.alpha = 0.5f;
    }];
    
    [queue addOperationWithBlock:^{
        // Core Image
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *ciImage = [CIImage imageWithCGImage:self.imageView.image.CGImage];
        
        CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:@(M_PI) forKey:@"inputAngle"];
        
        CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImg = [UIImage imageWithCGImage:cgimg];
        CGImageRelease(cgimg);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = newImg;
            [UIView animateWithDuration:.5f animations:^{
                self.imageView.alpha = 1.0f;
            } completion:^(BOOL finished) {
                [self.loadingIndicator stopAnimating];
            }];
        }];
    }];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerControllerSourceType sourceType;
    if ([buttonTitle isEqualToString:@"Camera"]) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([buttonTitle isEqualToString:@"Photo Library"]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image = [image imageFixedOrientation];
    
    // Store it
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    
    // Set view
    self.imageView.image = image;
}

@end
