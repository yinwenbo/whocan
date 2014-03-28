//
//  WHCMessageViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCMessageCell.h"

@interface WHCMessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView * messageTableView;
    IBOutlet UIView * inputBarView;
}

@end
