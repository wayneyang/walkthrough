//
//  ALPhoto.h
//  Album
//
//  Created by sodas on 11/20/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ALPhotoInfoDirectionKey;
extern NSString *const ALPhotoInfoImageKey;
extern NSString *const ALPhotoInfoLocationKey;
extern NSString *const ALPhotoInfoThumbKey;
extern NSString *const ALPhotoInfoTitleKey;

@interface ALPhoto : NSObject

+ (ALPhoto *)sharedSource;

- (NSArray *)arrayOfLocations;
- (NSArray *)arrayWithPhotosInLocation:(NSString *)location;
- (NSDictionary *)photoAtIndexPath:(NSIndexPath *)indexPath;

@end
