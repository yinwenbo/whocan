//
//  WHCPhoneABTableViewCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactCell.h"
#import "WHCViewUtils.h"

@implementation WHCContactCell

@synthesize appContact = _appContact;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAppContact:(AppContact *)appContact
{
    _appContact = appContact;
    [self initView];
}

- (void)initView
{
    AppContact *appContact = _appContact;

    NSString * name = appContact.appName;
    if (name == nil) {
        name = appContact.phoneABName;
    }
    if (name == nil) {
        name = appContact.mobileNo;
    }
    if (appContact.appName != nil
        && appContact.phoneABName != nil
        && ![appContact.appName isEqualToString:appContact.phoneABName]) {
        name = [NSString stringWithFormat:@"%@(%@)", appContact.appName, appContact.phoneABName];
    }
    self.textLabel.text = name;
    if (self.accessoryType == UITableViewCellAccessoryDetailButton ||
        self.accessoryType == UITableViewCellAccessoryDetailDisclosureButton) {

        NSString *buttonTitle = nil;
        if (appContact.isMyFriend) {
            buttonTitle = @"发消息";
        } else if (appContact.isInviteMe) {
            buttonTitle = @"同意";
        } else if (appContact.isAppUser) {
            buttonTitle = @"加好友";
        } else {
            buttonTitle = @"发邀请";
        }

        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget: self
                   action: @selector(accessoryButtonTapped:withEvent:)
         forControlEvents: UIControlEventTouchUpInside];
        button.frame = CGRectMake(0.0f, 0.0f, 50.0f, 24.0f);
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button.titleLabel setFont: [button.titleLabel.font fontWithSize:12]];
        [WHCViewUtils setButton:button];
        self.accessoryView = button;
    }
}

- (void)accessoryButtonTapped:(UIControl *)button withEvent:(UIEvent *)event
{
    UITableView *tableView = (UITableView*)[WHCViewUtils findSuperView:[self superview] type:[UITableView class]];
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    [tableView.delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

@end
