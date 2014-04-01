//
//  WHCMessageGroupViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MessageSession.h"

#import "WHCAllMessageSessionAPI.h"
#import "WHCAddUserToSessionAPI.h"

@interface WHCMessageSessionListView : UITableViewController<WHCJsonAPIDelegate>

@end
