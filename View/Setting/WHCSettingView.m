//
//  WHCSettingView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSettingView.h"

@interface WHCSettingView () {
    IBOutlet UIImageView * _iconView;
    IBOutlet UILabel * _labelName;
    IBOutlet UILabel * _labelGender;
}

@end

@implementation WHCSettingView

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
    
    [self updateShowView:[AppContact findMySelf]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [WHCAnalytics viewIn:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [WHCAnalytics viewOut:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateShowView:(AppContact *)me;
{
    [_labelName setText:me.appName];
    [_labelGender setText:me.gender];
    if (me.icon) {
        [_iconView setImage:[UIImage imageNamed:me.icon]];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppContact *me = [AppContact findMySelf];
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[WHCIconSettingView class]]) {
        [((WHCIconSettingView*)vc) setIconName:me.icon];
        return;
    }
    if ([vc isKindOfClass:[WHCTextEditView class]]) {
        [((WHCTextEditView*)vc) setText:me.appName];
        return;
    }
    if ([vc isKindOfClass:[WHCSingleSelectView class]]) {
        [((WHCSingleSelectView*)vc) setTextValue:me.gender];
        return;
    }
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    AppContact *me = [AppContact findMySelf];
    if ([fromViewController isKindOfClass:[WHCIconSettingView class]]) {
        WHCIconSettingView *iconVC = (WHCIconSettingView *)fromViewController;
        NSString * value = [iconVC getIconName];
        if (value == nil || value.length == 0){
            return NO;
        }
        me.icon = value;
    }
    if ([fromViewController isKindOfClass:[WHCTextEditView class]]) {
        WHCTextEditView *editVC = (WHCTextEditView *)fromViewController;
        NSString * value = editVC.textField.text;
        if (value == nil || value.length == 0) {
            return NO;
        }
        me.appName = value;
    }
    if ([fromViewController isKindOfClass:[WHCSingleSelectView class]]) {
        WHCSingleSelectView *selectVC = (WHCSingleSelectView *)fromViewController;
        NSString * value = selectVC.getTextValue;
        if (value == nil || value.length == 0){
            return NO;
        }
        me.gender = value;
    }
    HttpJsonAPI *api = [AccountDelegate updateAccountInfo:me.appName icon:me.icon gender:me.gender];
    [api startSynchronizeWithFinishedBlock:nil showProgressOn:self.view];
    if ([api isSuccess] && [[api getResult] isSuccess]) {
        [AppContact saveContext];
        [self updateShowView:me];
        return YES;
    }
    return NO;
}

@end
