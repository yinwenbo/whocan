//
//  WHCRegisterView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-10.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCRegisterView.h"

@interface WHCRegisterView () {
    IBOutlet UITextField * _name;
    IBOutlet WHCIconCollection * _iconView;
}


@end

@implementation WHCRegisterView

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

- (IBAction)save:(id)sender
{
    NSString *name = _name.text;
    NSString *icon = _iconView.iconName;
    if (name == nil || name.length == 0) {
        return;
    }
    if (icon == nil || icon.length == 0){
        return;
    }
    HttpJsonAPI * api = [AccountDelegate updateAccountInfo:name icon:icon gender:@"男"];
    [api startSynchronizeWithFinishedBlock:^(HttpJsonAPI *api) {
        if ([api isSuccess] && [[api getResult] isSuccess]) {
            AppContact *mine = [AppContact findMySelf];
            mine.appName = name;
            mine.icon = icon;
            mine.gender = @"男";
            [AppContact saveContext];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } showProgressOn:self.view];
}

@end
