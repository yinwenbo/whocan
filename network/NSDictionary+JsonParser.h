//
//  NSDictionary+Getter.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-16.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonParser)

- (NSDictionary *)getDictionary:(NSString *)key;
- (NSString *)getString:(NSString *)key;
- (NSDate *)getDate:(NSString *)key;
- (NSArray *)getArray:(NSString *)key;

@end
