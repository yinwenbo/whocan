//
//  CUISemiViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-23.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "CUISemiView.h"

@interface CUISemiView () {
    UIViewController * _parentVC;
    UIViewController * _semiVC;
    CGRect _semiBeginRect;
    CGRect _semiEndRect;
    CGRect _maskRect;
    UIView * _mask;
}

@end

@implementation CUISemiView

- (void)showMaskView
{
    if (_mask == nil) {
        _mask = self;
        [_mask setBackgroundColor:[UIColor grayColor]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSemiView)];
        [_mask addGestureRecognizer:tap];
    }
    [_mask setFrame:_parentVC.view.frame];
    [_mask setAlpha:0.0f];
    [_parentVC.view addSubview:_mask];
}

- (void)closeMaskView
{
    if (_mask) {
        [_mask removeFromSuperview];
    }
}

- (CGFloat)getSemiWidth
{
    return _parentVC.view.frame.size.width - 112;
}

- (UIViewController *)getActiveSemiViewController
{
    return _semiVC;
}

- (void)setParent:(UIViewController *)parent
{
    _parentVC = parent;
}

- (void)showOnLeftSemi:(UIViewController *)vc
{
    [self closeSemiView];
    
    CGRect navBarFrame = _parentVC.navigationController.navigationBar.frame;
    CGFloat navHeight =  navBarFrame.origin.y + navBarFrame.size.height;
    CGRect frame = _parentVC.view.frame;
    CGFloat width = [self getSemiWidth];
    _semiBeginRect = CGRectMake(-width, frame.origin.y, width, frame.size.height - navHeight);
    _semiEndRect = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height - navHeight);
    _maskRect = CGRectMake(width, frame.origin.y, frame.size.width - width, frame.size.height - navHeight);
    _semiVC = vc;

//    [_parentVC.parentViewController.parentViewController.view setFrame:CGRectMake(width, frame.origin.y, frame.size.width, frame.size.height)];
    [self showSemiView];
    
}

- (void)showOnRightSemi:(UIViewController *)vc
{
    [self closeSemiView];
    CGRect navBarFrame = _parentVC.navigationController.navigationBar.frame;
    CGFloat navHeight =  navBarFrame.origin.y + navBarFrame.size.height;
    CGRect frame = _parentVC.view.frame;
    CGFloat width = [self getSemiWidth];
    _semiBeginRect = CGRectMake(frame.size.width, frame.origin.y, width, frame.size.height - navHeight);
    _semiEndRect = CGRectMake(frame.size.width - width, frame.origin.y, width, frame.size.height - navHeight);
    _maskRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width - width, frame.size.height - navHeight);
    _semiVC = vc;
    [self showSemiView];
}

- (void)showSemiView
{
    [_semiVC willMoveToParentViewController:_parentVC];
    [_semiVC.view removeFromSuperview];
    [_semiVC removeFromParentViewController];
    [self showMaskView];
    [_parentVC addChildViewController:_semiVC];
    [_parentVC.view addSubview:_semiVC.view];
    [_semiVC.view setFrame:_semiBeginRect];
    
    [UIView animateWithDuration:0.3f animations:^{
        [_semiVC.view setFrame:_semiEndRect];
        [_mask setAlpha:0.8f];
        [_mask setFrame:_maskRect];
    } completion:^(BOOL finished) {
        [_semiVC didMoveToParentViewController:_parentVC];
    }];
}

- (void)closeSemiView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_semiVC) {
        [UIView animateWithDuration:0.3f animations:^{
            [_semiVC.view setFrame:_semiBeginRect];
            [_mask setFrame:_parentVC.view.frame];
            [_mask setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [_semiVC.view removeFromSuperview];
            [_semiVC removeFromParentViewController];
            [_mask removeFromSuperview];
            _semiVC = nil;
            _mask = nil;
        }];
        
    }
}
@end
