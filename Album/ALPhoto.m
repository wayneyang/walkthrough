//
//  ALPhoto.m
//  Album
//
//  Created by sodas on 11/20/12.
//  Copyright (c) 2012 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALPhoto.h"

static NSString *ALPhotoCacheLocationsKey = @"tw.edu.ntu.alphoto.locations";
static NSString *ALPhotoCachePhotoInLocationKey = @"tw.edu.ntu.alphoto.location.%@";

NSString *const ALPhotoInfoDirectionKey = @"Direction";
NSString *const ALPhotoInfoImageKey = @"Image";
NSString *const ALPhotoInfoLocationKey = @"Location";
NSString *const ALPhotoInfoThumbKey = @"Thumb";
NSString *const ALPhotoInfoTitleKey = @"Title";

@interface ALPhoto () {
    id memoryWarningNotificationObserver;
    NSCache *cache;
}

@property (nonatomic, readonly) NSArray *photos;

@end

@implementation ALPhoto

+ (ALPhoto *)sharedSource {
    static dispatch_once_t onceToken;
    static ALPhoto *sharedSource;
    dispatch_once(&onceToken, ^{
        sharedSource = [[self alloc] init];
    });
    return sharedSource;
}

- (id)init {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"plist"];
        _photos = [NSArray arrayWithContentsOfFile:path];
        
        cache = [[NSCache alloc] init];
        // Clean cache when receiving memory warning.
        memoryWarningNotificationObserver =
         [[NSNotificationCenter defaultCenter]
          addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
          object:nil
          queue:[NSOperationQueue currentQueue]
          usingBlock:^(NSNotification *note) {
              [cache removeAllObjects];
          }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:memoryWarningNotificationObserver];
}

#pragma mark - Interface

- (NSArray *)arrayOfLocations {
    NSArray *result = [cache objectForKey:ALPhotoCacheLocationsKey];
    if (!result) {
        result = [self.photos valueForKeyPath:@"@distinctUnionOfObjects.Location"];
        result = [result sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        [cache setObject:result forKey:ALPhotoCacheLocationsKey];
    }
    return result;
}

- (NSArray *)arrayWithPhotosInLocation:(NSString *)location {
    NSString *cacheKey = [NSString stringWithFormat:ALPhotoCachePhotoInLocationKey, location];
    NSArray *result = [cache objectForKey:cacheKey];
    if (!result) {
        result =
            [self.photos filteredArrayUsingPredicate:
             [NSPredicate predicateWithBlock:^BOOL(id photoInfo, NSDictionary *bindings) {
                return [photoInfo[ALPhotoInfoLocationKey] isEqualToString:location];
            }]];
    }
    return result;
}

- (NSDictionary *)photoAtIndexPath:(NSIndexPath *)indexPath {
    NSString *location = [[ALPhoto sharedSource] arrayOfLocations][indexPath.section];
    NSArray *photos = [[ALPhoto sharedSource] arrayWithPhotosInLocation:location];
    NSDictionary *photo = photos[indexPath.row];
    
    return photo;
}

@end
