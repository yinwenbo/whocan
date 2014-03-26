//
//  WHCMainViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMainController.h"

@interface WHCMainController ()

@end

@implementation WHCMainController

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
    // Do any additional setup after loading the view.
    if([self hasToken]){
        [[WHCUploadContactsAPI getInstance:self] asynchronize];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
//    UIViewController * view = [[[self storyboard] instantiateViewControllerWithIdentifier:@"SignInVC"];
//    [self.navigationController pushViewController:view animated:YES];
    if(![self hasToken]){
        UIViewController *signInVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
        [self presentViewController:signInVc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)hasToken
{
    NSString *token = [ClientInfo getToken];
    return token != nil;
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
