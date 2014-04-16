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
    IBOutlet WHCIconView * _iconView;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    AppContact *mine = [AppContact findMySelf];
    mine.appName = _name.text;
    mine.icon = _iconView.iconName;
    mine.gender = @"男";
    WHCUpdateAccountAPI *updateApi = [WHCUpdateAccountAPI getInstance:self appContact:mine];
    [updateApi synchronize];
    if ([updateApi isSuccess]) {
        [AppContact saveContext];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    
}

@end
