//
//  WHCSmsSendController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-24.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSmsSendController.h"

@interface WHCSmsSendController ()

@end

@implementation WHCSmsSendController

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
