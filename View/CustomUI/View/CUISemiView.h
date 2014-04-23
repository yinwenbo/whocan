//
//  CUISemiViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-23.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUISemiView : UIView


- (void)setParent:(UIViewController *)parent;

- (void)showOnRightSemi:(UIViewController *)vc;
- (void)showOnLeftSemi:(UIViewController *)vc;


- (void)closeSemiView;

- (CGFloat)getSemiWidth;
- (UIViewController *)getActiveSemiViewController;

@end
