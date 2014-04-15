//
//  WHCViewUtils.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCViewUtils.h"

@implementation WHCViewUtils

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
