//
//  WHCContactViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactShowView.h"

@interface WHCContactShowView ()

@end

@implementation WHCContactShowView

@synthesize appContact, btnMainAction, lblName, lblId, lblMobileNo, lblNickname, iconView;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initView];
}

- (void)initView
{
    if (self.appContact.isMyFriend) {
        btnMainAction.titleLabel.text = @"发送消息";
    } else if ([self.appContact isMyInvite]) {
        [btnMainAction setTitle:@"等待对方同意" forState:UIControlStateDisabled];
        [btnMainAction setEnabled:NO];
    } else if (self.appContact.isAppUser) {
        btnMainAction.titleLabel.text = @"加为好友";
    } else {
        btnMainAction.titleLabel.text = @"发送邀请";
    }
    [iconView setImage:[appContact getIcon]];

    lblName.text = self.appContact.phoneABName;
    if (self.appContact.appId == nil) {
        lblId.text = @"";
    }else{
        lblId.text = [NSString stringWithFormat:@"互看id: %@", self.appContact.appId];
    }
    lblMobileNo.text = self.appContact.mobileNo;
    if (self.appContact.appName == nil){
        lblNickname.text = @"";
    }else{
        lblNickname.text = [NSString stringWithFormat:@"昵称: %@", self.appContact.appName];
    }
    [self.tableView setSectionHeaderHeight:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMainAction:(id)sender
{
    if (appContact.isMyFriend) {
        WHCMessageView * view = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageSession"];
        [view setAppContact:appContact];
        [self.navigationController pushViewController:view animated:YES];
    } else if (appContact.isAppUser) {
        btnMainAction.titleLabel.text = @"加为好友";
        [[WHCAddFriendAPI getInstance:self userId:appContact.appId] synchronize];
    } else {
        WHCSmsSendView * smsView = [WHCSmsSendView initWithInvite:self.appContact.mobileNo];
        [self presentViewController:smsView animated:YES completion:nil];

    }
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController * nc = (UINavigationController*)[segue destinationViewController];
    for (UIViewController * vc in [nc childViewControllers]){
        if ([vc isKindOfClass:[WHCContactEditView class]]){
            WHCContactEditView *editView = (WHCContactEditView*)vc;
            editView.appContact = appContact;
        }
    }
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    if ( [fromViewController isKindOfClass:[WHCContactEditView class]]
        && [sender isKindOfClass:[WHCBarButtonSave class]]){
        WHCContactEditView *editView = (WHCContactEditView*)fromViewController;
        appContact.phoneABName = editView.txtName.text;
        [AppContact saveContext];
        [self initView];
    }
    return YES;
}
@end
