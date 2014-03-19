//
//  AppUser.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "AppUser.h"


@implementation AppUser

@dynamic name;
@dynamic userId;
@dynamic mobileNo;

- (instancetype)initWithValues: (NSString*)name userid:(NSString*)userId mobileNo:(NSString*)mobileNo
{
    self = [super init];
    if (self) {
        self.name = name;
        self.userId = userId;
        self.mobileNo = mobileNo;
    }
    return self;
}
@end
