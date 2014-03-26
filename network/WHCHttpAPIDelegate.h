//
//  WHCAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-21.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WHCHttpAPI;

@protocol WHCHttpAPIDelegate <NSObject>

- (void) onHttpRequestFinished:(WHCHttpAPI *)api;

@end

