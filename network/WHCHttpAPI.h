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

#define HttpRequestCallback void(^)()

@interface WHCHttpAPI : NSObject

@property (nonatomic, readonly) id<WHCHttpAPIDelegate> delegate;

- (id)init:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCHttpAPIDelegate>)delegate;
- (void)synchronize;
- (void)asynchronize;

- (NSString *)getResponseText;

@end

