//
//  WHCContactEditController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-26.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppContact.h"

@interface WHCContactEditController : UITableViewController

@property (nonatomic, retain) IBOutlet UITextField * txtName;

@property (nonatomic, retain) AppContact *appContact;
@end
