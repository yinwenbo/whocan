//
//  WHCHttpAPIDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCHttpAPI.h"
#import "WHCJsonAPIDelegate.h"
#import "ClientInfo.h"

@interface WHCJsonAPI : WHCHttpAPI <WHCHttpAPIDelegate>

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * msg;
@property (nonatomic, retain) NSDictionary * data;
@property (nonatomic) BOOL hasException;

- (id)initWithJsonDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCJsonAPIDelegate>)delegate;

- (NSData *)getDate:(NSString *)key;
- (NSDate *)getDate:(NSDictionary*)dict key:(NSString*)key;

- (NSString *)getString:(NSString*)key;
- (NSString *)getString:(NSDictionary*)dict key:(NSString *)key;


- (void)parseResponseJson;
- (void)successJsonResult;
@end
