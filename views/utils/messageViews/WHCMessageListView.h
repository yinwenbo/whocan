//
//  WHCMessageListView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCMessageListView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITextField * _inputText;
    IBOutlet UITableView * _tableView;
    IBOutlet UIView * _inputBarView;
}

@end
