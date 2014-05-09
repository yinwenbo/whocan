//
//  WHCCategorySemiLeftSegue.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-7.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCCategorySemiLeftSegue.h"

@implementation WHCCategorySemiLeftSegue

- (void)perform
{
    CUISemiView * semiVC = [[CUISemiView alloc] init];
    //    [_parentVC.parentViewController.parentViewController.view setFrame:CGRectMake(width, frame.origin.y, frame.size.width, frame.size.height)];
    [semiVC setParent:[[self.sourceViewController parentViewController] parentViewController]];
    [semiVC showOnLeftSemi:self.destinationViewController];
}

@end
