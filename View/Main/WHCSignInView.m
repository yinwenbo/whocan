//
//  WHCSignInController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSignInView.h"

@interface WHCSignInView () {
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [WHCAnalytics viewIn:self];
    if([ClientInfo isSignIn] && [ClientInfo needUpdateUserInfo]) {
        UIViewController *registerView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterView"];
        [self presentViewController:registerView animated:YES completion:nil];
    } else if ([ClientInfo isSignIn]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    if([self.txtMobileNo isEnabled]){
        [self.txtMobileNo becomeFirstResponder];
    }else if([self.txtVerifyCode isEnabled]){
        [self.txtVerifyCode becomeFirstResponder];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [WHCAnalytics viewOut:self];
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
    [self.btnSendVerifyCode setEnabled:NO];
    [self.txtVerifyCode becomeFirstResponder];
    NSString *mobileNo = self.txtMobileNo.text;
    HttpJsonAPI *api = [AccountDelegate sendVerifyCodeToMobile:mobileNo];
    [api startSynchronizeWithFinishedBlock:^(HttpJsonAPI *api) {
        if ([api isSuccess] && [[api getResult] isSuccess]) {
            [self onVerfyCodeSendFinished];
        } else {
            [self.btnSendVerifyCode setEnabled:YES];
        }
    } showProgressOn:self.view];
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
    HttpJsonAPI * api = [AccountDelegate signInByMobileVerifyCode:[self getMobileNo] verifyCode:[self getVerifyCode]];
    [api startSynchronizeWithFinishedBlock:^(HttpJsonAPI *api) {
        if ([api isSuccess] && [[api getResult] isSuccess]) {
            [AccountDelegate updateBySignInResult:[api getResult]];
            [SocialDelegate uploadContactsInBackground];
            if([ClientInfo needUpdateUserInfo]) {
                UIViewController *registerView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterView"];
                [self presentViewController:registerView animated:YES completion:nil];
            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            
        }
    } showProgressOn:self.view];
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
