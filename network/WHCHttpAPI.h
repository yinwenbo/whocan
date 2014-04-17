//
//  WHCHttpAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "WHCHttpAPIDelegate.h"

#import "BaiduMobStat.h"
#define HttpRequestCallback void(^)()

@interface WHCHttpAPI : NSObject


@property (nonatomic) BOOL hasError;

- (id)initWithHttpDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCHttpAPIDelegate>)delegate;

- (void)synchronize;
- (void)asynchronize;

- (BOOL)isSynchronize;
- (BOOL)isSuccess;
- (NSString *)getResponseText;
- (NSString *)getErrorMessage;

@end

