//
//  NSDictionary+Getter.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-16.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "NSDictionary+JsonParser.h"

@implementation NSDictionary (JsonParser)

/*
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
 [dateFormatter setDateFormat:@"'公元前/后:'G  '年份:'u'='yyyy'='yy '季度:'q'='qqq'='qqqq '月份:'M'='MMM'='MMMM '今天是今年第几周:'w '今天是本月第几周:'W  '今天是今天第几天:'D '今天是本月第几天:'d '星期:'c'='ccc'='cccc '上午/下午:'a '小时:'h'='H '分钟:'m '秒:'s '毫秒:'SSS  '这一天已过多少毫秒:'A  '时区名称:'zzzz'='vvvv '时区编号:'Z "];
 NSLog(@"%@", [dateFormatter stringFromDate:result]);
 */

- (NSDictionary *)getDictionary:(NSString *)key
{
    NSObject * result = [self getObject:key];
    if ([result isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)result;
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:result, key, nil];
}

- (NSDate *)getDate:(NSString *)key
{
    NSString *value = [self getString:key];
    NSDate *result = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]/1000];

    return result;
}

- (NSArray *)getArray:(NSString *)key
{
    NSObject * result = [self getObject:key];
    if ([result isKindOfClass:[NSArray class]]) {
        return (NSArray *)result;
    }
    return [NSArray arrayWithObject:result];
}

- (NSString *)getString:(NSString *)key
{
    NSObject * result = [self getObject:key];
    
    if ([result isKindOfClass:[NSString class]]){
        return (NSString*)result;
    }
    return [NSString stringWithFormat:@"%@", result];

}

- (NSObject *)getObject:(NSString *)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return result;
}

@end
