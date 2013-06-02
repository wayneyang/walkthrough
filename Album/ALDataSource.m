//
//  ALDataSource.m
//  walkthrough
//
//  Created by wayneyang on 13/6/2.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALDataSource.h"
// Cache Keys
static NSString *ALDataSourceCacheKeyTopics = @"ALDataSource.Cache.分類";
static NSString *ALDataSourceCacheKeyWords = @"ALDataSource.Cache.%@.假名";

//Dictinary Keys
NSString * const ALDataSourceDictKeyKana=@"假名";
NSString * const ALDataSourceDictKeyChineseCharacter=@"漢字";
NSString * const ALDataSourceDictKeyType=@"詞性";
NSString * const ALDataSourceDictKeyChineseExplain=@"中文";
NSString * const ALDataSourceDictKeyTopic=@"分類";

@interface ALDataSource ()

@end

@implementation ALDataSource
#pragma mark -
#pragma mark Object Lifecycle
+ (ALDataSource *)sharedDataSource{
    static dispatch_once_t once;
    static ALDataSource *sharedDataSource;
    dispatch_once(&once, ^{
        sharedDataSource=[[self alloc]init];
    });
    return sharedDataSource;
    
}
- (id) init{
    if (self=[super init]){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"4thword - Sheet1" ofType:@"plist"];
        wordList = [NSArray arrayWithContentsOfFile:path];
        cache = [[NSCache alloc]init];
    }
    return self;
}

#pragma mark -
#pragma mark Interfaces
- (void)refresh{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"4thword" ofType:@"plist"];
    wordList = [NSArray arrayWithContentsOfFile:path];
    [self cleanCache];
    
}

-(void) cleanCache{
    [cache removeAllObjects];
}

-(NSArray *) arrayWithTopics{
    NSArray *continents = [cache objectForKey:ALDataSourceDictKeyTopic];
    
    if (!continents) {
        // Save countries into a set (remove duplicates result).
        NSMutableSet *continentsSet = [NSMutableSet set];
        for (NSDictionary *continent in wordList)
            [continentsSet addObject:continent[ALDataSourceDictKeyTopic]];
        
        // Convert set to array and sort the array.
        continents = [[continentsSet allObjects] sortedArrayUsingComparator:
                      ^NSComparisonResult(id obj1, id obj2) {
                          return [obj1 compare:obj2];
                      }];
        
        // Save the result into cache
        [cache setObject:continents forKey:ALDataSourceDictKeyTopic];
    }
    
    return continents;
}
- (NSArray *) arrayWithWordsInTopics:(NSString *)topic{
    NSString *cacheKey = [NSString stringWithFormat:ALDataSourceCacheKeyTopics, topic];
    //NSLog(@"%@",cacheKey);
    NSArray *countries = [cache objectForKey:cacheKey];
    NSMutableSet *countriesSet = [NSMutableSet set];
    if (!countries) {
        for (NSDictionary *country in wordList)
            if (country[ALDataSourceDictKeyTopic]==topic ) {
                [countriesSet addObject:country[ALDataSourceDictKeyKana]];
            }
        
        
        // Convert set to array and sort the array.
        countries = [[countriesSet allObjects] sortedArrayUsingComparator:
                     ^NSComparisonResult(id obj1, id obj2) {
                         return [obj1 compare:obj2];
                     }];
        //NSLog(@"%@",countries[1]);
        // Save the result into cache
        [cache setObject:countries forKey:cacheKey];
    }
    //NSLog(@"let's it");
    
    //NSLog(@"%d", [countries count]);
    return countries;
}

- (NSDictionary *)dictionaryWithWordAtIndexPath:(NSIndexPath *)indexPath :(NSString *)topic
{
    NSUInteger row = indexPath.row;
    NSDictionary *word = [self arrayWithWordsInTopics:topic][row];
    return word;

}

- (NSArray *)wordList {
    return wordList;
}
@end
