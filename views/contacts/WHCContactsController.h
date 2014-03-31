//
//  WHCContactsTableViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCContactCell.h"
#import "WHCContactViewController.h"
#import "WHCMessageSessionView.h"

#import "WHCGetFriendsAPI.h"
#import "WHCAddFriendAPI.h"
#import "AppContact.h"

@interface WHCContactsController : UITableViewController<WHCJsonAPIDelegate, UINavigationControllerDelegate>

- (NSArray *)getAppContacts;
- (UITableViewCell*)getContactCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath;

@end
