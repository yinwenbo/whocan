//
//  WHCContactsTableViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCContactCell.h"
#import "WHCContactShowView.h"

#import "AppContact.h"

@interface ContactBaseViewController : UITableViewController<UINavigationControllerDelegate>

- (NSArray *)getAppContacts;
- (UITableViewCell *)getContactCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath;
- (UITableViewCell *)getTotalCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath;

- (BOOL)hasRefesh;
- (BOOL)hasTotalCell;

- (NSString *)getCellIdentifier:(NSIndexPath *)indexPath;
- (NSInteger)topFixCellCount;
- (UITableViewCell *)getTopFixCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath;

@end
