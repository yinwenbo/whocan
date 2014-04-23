//
//  WHCIconSettingView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCIconSettingView.h"

@interface WHCIconSettingView() {
    IBOutlet WHCIconCollection * _iconView;
    NSString * _iconName;
}

@end
@implementation WHCIconSettingView

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
    [_iconView setIconName:_iconName];
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
- (NSString *) getIconName
{
    return _iconView.iconName;
}

-(void)setIconName:(NSString *)iconName
{
    _iconName = iconName;
    [_iconView setIconName:iconName];
}
@end
