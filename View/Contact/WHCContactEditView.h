//
//  WHCContactEditController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-26.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppContact.h"
#import "WHCAnalytics.h"

@interface WHCContactEditView : UITableViewController

@property (nonatomic, retain) IBOutlet UITextField * txtName;

@property (nonatomic, retain) AppContact *appContact;

@end
