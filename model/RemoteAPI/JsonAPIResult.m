//
//  JsonAPIResult.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "JsonAPIResult.h"

@implementation JsonAPIResult

@synthesize code, message, data;

+ (JsonAPIResult *)resultWithJsonData:(NSData *)jsonData
{
    JsonAPIResult *result = [[JsonAPIResult alloc] init];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    debugLog(@"json parsed %@", dict);
    if (error) {
        debugLog(@"json parsed error %@", error);
    } else {
        result.code = [dict objectForKey:@"code"];
        result.message = [dict objectForKey:@"msg"];
        result.data = [dict objectForKey:@"data"];
    }
    return result;
}

- (BOOL)isSuccess
{
    return [@"0000" isEqualToString:code];
}

- (BOOL)needSignIn
{
    return [@"TokenDisableException" isEqualToString:code] || [@"TokenErrorException" isEqualToString:code];
}


@end
