//
//  WHCSignInController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSignInView.h"
#import "WHCSignInAPI.h"
#import "WHCSendVerifyCodeAPI.h"

@interface WHCSignInView () {
    WHCSendVerifyCodeAPI * _sendVerifyCode;
    NSTimer * _timer;
    NSInteger _counter;
}

@end

@implementation WHCSignInView

@synthesize btnSignIn, btnSendVerifyCode, txtMobileNo, txtVerifyCode;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WHCViewUtils setButton:self.btnSignIn];
    [WHCViewUtils setButton:self.btnSendVerifyCode];
}

- (void)viewDidAppear:(BOOL)animated
{
    if([self.txtMobileNo isEnabled]){
        [self.txtMobileNo becomeFirstResponder];
    }else if([self.txtVerifyCode isEnabled]){
        [self.txtVerifyCode becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString*)getMobileNo
{
    return self.txtMobileNo.text;
}

- (NSString*)getVerifyCode
{
    return self.txtVerifyCode.text;
}

- (IBAction)onMobileNoChange:(id)sender
{
    if(self.txtMobileNo.text.length == 11){
        [self.btnSendVerifyCode setEnabled:YES];
    }else{
        [self.btnSendVerifyCode setEnabled:NO];
    }
}

- (IBAction)onSendVrifyPush:(id)sender
{
//    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self.btnSendVerifyCode setEnabled:NO];
    [self.txtVerifyCode becomeFirstResponder];
    NSString *mobileNo = self.txtMobileNo.text;
    _sendVerifyCode = [WHCSendVerifyCodeAPI getInstance:self
                                               mobileNo:mobileNo];
    [_sendVerifyCode synchronize];
    [self.btnSendVerifyCode setEnabled:YES];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)onVerifyCodeChange:(id)sender
{
    if(self.txtVerifyCode.text.length == 6){
        [self.btnSignIn setEnabled:YES];
    }else{
        [self.btnSignIn setEnabled:NO];
    }
}

- (IBAction)onSignInPush:(id)sender
{
    WHCSignInAPI *signInApi = [WHCSignInAPI getInstance:self
                                               mobileNo:[self getMobileNo]
                                             verifyCode:[self getVerifyCode]];
    [signInApi synchronize];
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if ([api isKindOfClass: [WHCSignInAPI class]]){
        if ([ClientInfo isSignIn]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        return;
    }
    if([api isKindOfClass:[WHCSendVerifyCodeAPI class]]){
        if ([api isSuccess]) {
            [self onVerfyCodeSendFinished];
        }
    }
}

- (void)onVerfyCodeSendFinished
{
    _counter = 60;
    [self sendVerifyCodeCountDown];
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                              target: self
                                            selector: @selector(sendVerifyCodeCountDown)
                                            userInfo: nil
                                             repeats: YES];
}

- (void)sendVerifyCodeCountDown
{
    NSString *title;
    if(--_counter <= 0){
        title = @"获取";
        [_timer invalidate];
        _timer = nil;
        [self.btnSendVerifyCode setEnabled:YES];
    } else {
        title = [NSString stringWithFormat:@"%li", (long)_counter];
        [self.btnSendVerifyCode setEnabled:NO];
    }
    self.btnSendVerifyCode.titleLabel.text = title;
    self.btnSendVerifyCode.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
