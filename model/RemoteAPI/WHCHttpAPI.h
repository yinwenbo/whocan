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

#import "WHCAnalytics.h"


@interface WHCHttpAPI : NSObject


@property (nonatomic) BOOL hasError;

- (id)initWithHttpDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCHttpAPIDelegate>)delegate;

- (void)synchronize;
- (void)asynchronize;

- (BOOL)isSynchronize;
- (BOOL)isSuccess;
- (NSString *)getResponseText;
- (NSString *)getErrorMessage;
- (int)duration;

@end

