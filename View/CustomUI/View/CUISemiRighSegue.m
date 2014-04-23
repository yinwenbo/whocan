//
//  CUISemiViewSegue.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-23.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "CUISemiRighSegue.h"

@implementation CUISemiRighSegue

- (void)perform
{
    CUISemiView * semiVC = [[CUISemiView alloc] init];
    [semiVC setParent:self.sourceViewController];
    [semiVC showOnRightSemi:self.destinationViewController];
}

@end
