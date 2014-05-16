//
//  JsonAPIResult.h
//  whocan
//
//  Created by Yin Wenbo on 14-5-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonAPIResult : NSObject

+ (JsonAPIResult *)resultWithJsonData:(NSData *)jsonData;

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) id data;

- (BOOL)isSuccess;
- (BOOL)needSignIn;

@end
