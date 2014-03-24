//
//  WHCHttpAPIDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCHttpAPI.h"

@interface WHCJsonAPI : WHCHttpAPI <WHCHttpAPIDelegate>

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * msg;
@property (nonatomic, retain) NSDictionary * data;

- (NSString *)getString:(NSString*)key;

@end
