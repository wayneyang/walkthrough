//
//  ALDataSource.h
//  walkthrough
//
//  Created by wayneyang on 13/6/2.
//  Copyright (c) 2013年 NTU CSIE MHCI Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const ALDataSourceDictKeyKana;
extern NSString * const ALDataSourceDictKeyChineseCharacter;
extern NSString * const ALDataSourceDictKeyType;

extern NSString * const ALDataSourceDictKeyChineseExplain;
extern NSString * const ALDataSourceDictKeyTopic;


@interface ALDataSource : NSObject
{    // Main data pool
    NSArray *wordList;
    // Cache data pool
    NSCache *cache;

}
+ (ALDataSource *)sharedDataSource;

- (void) refresh;
- (void) cleanCache;
//取出主題的array (get topicList array)
- (NSArray *) arrayWithTopics;
//取出主題單字陣列(get wordList in one topic)
- (NSArray *) arrayWithWordsInTopics:(NSString *)topic;
//取出個別單字的字典(dictionary)
- (NSDictionary *)dictionaryWithWordAtIndexPath:(NSIndexPath *)indexPath :(NSString *)topic;
@property (nonatomic, strong, readonly) NSArray *wordList;
@end
