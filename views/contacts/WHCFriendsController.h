//
//  WHCContactsTableViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCGetFriendsAPI.h"
#import "AppContact.h"

@interface WHCFriendsController : UITableViewController<WHCHttpAPIDelegate>

@property (nonatomic, retain) NSArray * appContacts;

@end
