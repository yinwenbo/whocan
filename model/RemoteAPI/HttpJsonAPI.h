//
//  HttpJsonAPI.h
//
//  Created by Yin Wenbo on 14-5-6.
//  Copyright (c) 2014年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpJsonAPIDelegate.h"
#import "JsonAPIResult.h"
#import "NSDictionary+JsonParser.h"

#if NS_BLOCKS_AVAILABLE
typedef void (^CallbackBlock)(HttpJsonAPI *api);
#endif




@interface HttpJsonAPI : NSObject

+ (HttpJsonAPI *)getInstance:(id<HttpJsonAPIDelegate>)delegate params:(NSDictionary *)params url:(NSString *)url;

+ (NSMutableDictionary *)paramsWithToken;

- (id)initWithDelegate:(id<HttpJsonAPIDelegate>)delegate
                params:(NSDictionary *)params
                   url:(NSString *)url;
- (id)initWithParams:(NSDictionary *)params
                 url:(NSString *)url;


- (void)startSynchronize;
- (void)startAsynchronize;

- (void)startAsynchronize:(CallbackBlock)onFinished
           showProgressOn:(UIView *)view;

- (void)startSynchronizeWithFinishedBlock:(CallbackBlock)onFinished
          showProgressOn:(UIView *)view;

- (void)cancelRequest;

- (BOOL)isMatchUrl:(NSString *)url;
- (JsonAPIResult *)getResult;
- (BOOL)isSuccess;
- (NSString *)getErrorMessage;

@end
