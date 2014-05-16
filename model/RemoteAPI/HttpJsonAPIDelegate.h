//
//  HttpJsonAPIDelegate.h
//
//  Created by Yin Wenbo on 14-5-6.
//  Copyright (c) 2014年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpJsonAPI;

@protocol HttpJsonAPIDelegate <NSObject>

- (void)onJsonParseFinished:(HttpJsonAPI *)api;

@optional

- (void)onRequestIsFailed:(HttpJsonAPI *)api;

@end
