//
//  ALDataSource.m
//  walkthrough
//
//  Created by wayneyang on 13/6/2.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import "ALDataSource.h"
// Cache Keys
static NSString *ALDataSourceCacheKeyTopics = @"ALDataSource.Cache.topics";
static NSString *ALDataSourceCacheKeyWordList = @"ALDataSource.Cache.%@.words";

//Dictinary Keys
NSString * const ALDataSourceDictKeyKana=@"假名";
NSString * const ALDataSourceDictKeyChineseCharacter=@"漢字";
NSString * const ALDataSourceDictKeyType=@"詞類";
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"4thword - Sheet1" ofType:@"plist"];
    wordList = [NSArray arrayWithContentsOfFile:path];
    [self cleanCache];
    
}

-(void) cleanCache{
    [cache removeAllObjects];
}

-(NSArray *) arrayWithTopics{
    NSArray *TopicList = [cache objectForKey:ALDataSourceDictKeyTopic];
    
    if (!TopicList) {
        // Save countries into a set (remove duplicates result).
        NSMutableSet *wordSet = [NSMutableSet set];
        for (NSDictionary *continent in wordList)
            [wordSet addObject:continent[ALDataSourceDictKeyTopic]];
        
        // Convert set to array and sort the array.
        TopicList = [wordSet allObjects];
        
        // Save the result into cache
        [cache setObject:TopicList forKey:ALDataSourceDictKeyTopic];
    }
    
    return TopicList;
}
- (NSArray *) arrayWithWordsInTopics:(NSString *)topic{
    NSString *cacheKey = [NSString stringWithFormat:ALDataSourceCacheKeyWordList, topic];
    //NSLog(@"%@",cacheKey);
    NSArray *WordList = [cache objectForKey:cacheKey];
    if (!WordList) {
       /* for (NSDictionary *word in wordList){
            
            if ([word[ALDataSourceDictKeyTopic] isEqualToString:topic]   ) {
                [countriesSet addObject:word[ALDataSourceDictKeyKana]];
            }
        }
        
        
        // Convert set to array and sort the array.
        WordList = [countriesSet allObjects];
        //NSLog(@"%@",countries[1]);
        // Save the result into cache*/
        
        // Filter array
        WordList = [wordList filteredArrayUsingPredicate:
                          [NSPredicate predicateWithBlock:
                           ^BOOL(id evaluatedObject, NSDictionary *bindings) {
                               NSDictionary *airport = (NSDictionary *)evaluatedObject;
                               return [airport[ALDataSourceDictKeyTopic] isEqualToString:topic];
                           }]];
        [cache setObject:WordList forKey:cacheKey];
    }
    //NSLog(@"let's it");
    //NSLog(@"yyoyoyo%d",[WordList count]);
    //NSLog(@"yyoyoyo%@",WordList[10][ALDataSourceDictKeyKana]);
    return WordList;
}

- (NSDictionary *)dictionaryWithWordAtIndexPath:(NSIndexPath *)indexPath :(NSString *)topic
{
    NSInteger row = indexPath.row;
    NSDictionary *word = [self arrayWithWordsInTopics:topic][row];
    return word;

}

- (NSArray *)wordList {
    return wordList;
}
@end
