//
//  WHCJsonAPIDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WHCJsonAPI;

@protocol WHCJsonAPIDelegate <NSObject>

-(void) onJsonParseFinished:(WHCJsonAPI*)api;

@end
