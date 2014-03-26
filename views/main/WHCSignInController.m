//
//  WHCSignInController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSignInController.h"
#import "WHCSignInAPI.h"
#import "WHCSendVerifyCodeAPI.h"

@interface WHCSignInController () {
    WHCSendVerifyCodeAPI * _sendVerifyCode;
    NSTimer * _timer;
    NSInteger _counter;
}

@end

@implementation WHCSignInController

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
    // Dispose of any resources that can be recreated.
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
    [self.btnSendVerifyCode setEnabled:NO];
    [self.txtVerifyCode becomeFirstResponder];
    NSString *mobileNo = self.txtMobileNo.text;
    _sendVerifyCode = [WHCSendVerifyCodeAPI getInstance:self
                                               mobileNo:mobileNo];
    [_sendVerifyCode asynchronize];
    [self.btnSendVerifyCode setEnabled:YES];
}

- (void)handleTimer
{
    NSString *title;
    if(--_counter <= 0){
        title = @"获取";
        [_timer invalidate];
        _timer = nil;
        [self.btnSendVerifyCode setEnabled:YES];
    }else{
        title = [NSString stringWithFormat:@"%li", (long)_counter];
    }
    self.btnSendVerifyCode.titleLabel.text = title;
    self.btnSendVerifyCode.titleLabel.textAlignment = NSTextAlignmentCenter;
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
        [self onSignInFinished:(WHCSignInAPI*)api];
    } else if([api isKindOfClass:[WHCSendVerifyCodeAPI class]]){
        [self onVerfyCodeSendFinished];
    }
}

- (void)onVerfyCodeSendFinished
{
    _counter = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                              target: self
                                            selector: @selector(handleTimer)
                                            userInfo: nil
                                             repeats: YES];
    [self.btnSendVerifyCode setEnabled:NO];
}

- (void)onSignInFinished:(WHCSignInAPI*)signInApi
{
    if([signInApi getToken]){
        [ClientInfo setToken:[signInApi getToken]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
