//
//  WHCSmsSendController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-24.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSmsSendView.h"

@interface WHCSmsSendView ()

@end

@implementation WHCSmsSendView

+ (WHCSmsSendView *)initWithInvite:(NSString *)mobileNo
{
    if( [MFMessageComposeViewController canSendText] ){
        WHCSmsSendView * controller = [[WHCSmsSendView alloc]init];
        controller.recipients = [NSArray arrayWithObjects:mobileNo, nil];
        controller.body = @"我正在使用[互看]来做项目，请加入进来，以便沟通。下载：http://www.weijinrong100.com/whocan/static/download.html";
        controller.messageComposeDelegate = controller;
        return controller;
    }else{
        
        return nil;
        //        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[[self viewControllers] lastObject] navigationItem] setTitle:@"邀请短信"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
