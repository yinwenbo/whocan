//
//  WHCSideSegue.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-22.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSideSegue.h"

@interface WHCSideSegue(){
    UIView * mask;
}

@end

@implementation WHCSideSegue

- (void)perform
{
//    [self.sourceViewController addSubview:[self.destinationViewController contentView]];
    UIViewController * svc = self.sourceViewController;
    UIViewController * dvc = self.destinationViewController;
    [dvc willMoveToParentViewController:nil];
    [dvc.view removeFromSuperview];
    [dvc removeFromParentViewController];
    

    mask = [[UIView alloc] init];
    [mask setBackgroundColor:[UIColor grayColor]];
    [mask setAlpha:0.3f];
    [mask setFrame:CGRectMake(0, 0, svc.view.frame.size.width, svc.view.frame.size.height)];
    [svc.view addSubview:mask];
/*
    CALayer *_maskingLayer = [CALayer layer];
    [_maskingLayer setFrame:CGRectMake(0, 0, 112, svc.view.frame.size.height)];
    [_maskingLayer setBackgroundColor:CGColorCreateCopyWithAlpha([_maskingLayer backgroundColor], 0.3)];
//    [_maskingLayer setBackgroundColor:[UIColor grayColor]];
//    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [svc.view.layer setMask:_maskingLayer];
*/    

    dvc.view.frame = CGRectMake(svc.view.frame.size.width, 0, 0, svc.view.frame.size.height);
    [svc addChildViewController:dvc];
    [svc.view addSubview:dvc.view];
    /*
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(unWind:)];
     */
//    [mask addGestureRecognizer:tapRecog];
    
    [UIView animateWithDuration:0.3f animations:^{
        [dvc.view setFrame:CGRectMake(112, 0, svc.view.frame.size.width - 112, svc.view.frame.size.height)];
        [mask setFrame:CGRectMake(0, 0, 112, svc.view.frame.size.height)];
    } completion:^(BOOL finished) {
        [dvc didMoveToParentViewController:svc];
    }];
    

//    [self.sourceViewController addChildViewController:self.destinationViewController];
//    [self.destinationViewController willMoveToParentViewController:self.sourceViewController];
//    [[self.destinationViewController contentView] setFrame:CGRectMake(100.f, 0, 200, 200)];
}
-(void) unWind: (UIGestureRecognizer *) recognizer {
    UIViewController * dvc = self.destinationViewController;
    [dvc.view removeFromSuperview];
    [dvc removeFromParentViewController];
    [mask removeFromSuperview];
}

@end
