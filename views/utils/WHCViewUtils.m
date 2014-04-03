//
//  WHCViewUtils.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCViewUtils.h"

@implementation WHCViewUtils

+ (UIView *)findSuperView:(UIView *)view type:(Class)type
{
    UIView * superview = [view superview];
    if (superview == nil) {
        return nil;
    }
    if ([superview isKindOfClass:type]){
        return superview;
    }
    return [self findSuperView:superview type:type];
}

+ (UIView *)findSubView:(UIView *)view type:(Class)type
{
    NSArray * subviews = [view subviews];
    for (UIView * view in subviews) {
        if ([view isKindOfClass:type]){
            return view;
        }
    }
    for (UIView * view in subviews){
        UIView * result = [self findSubView:view type:type];
        if (result != nil) {
            return result;
        }
    }
    return nil;
}

+ (void)setButton:(UIButton* )button
{
    [button.layer setBorderWidth:1];
    [button.layer setCornerRadius:4];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.83f, 0.83f, 0.83f, 0.8f});
    [button.layer setBorderColor:beginColor];
}

+ (WHCSmsSendController *)getInviteSMSView:(NSString*)mobileNo;
{
    if( [MFMessageComposeViewController canSendText] ){
        
        WHCSmsSendController * controller = [[WHCSmsSendController alloc]init];
        controller.recipients = [NSArray arrayWithObjects:mobileNo, nil];
        controller.body = @"我正在使用[互看]来做项目，请加入进来，以便沟通。下载：http://www.weijinrong100.com/whocan/static/download.html";
        controller.messageComposeDelegate = controller;
        return controller;
    }else{
        
        return nil;
        //        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
    
}


@end
