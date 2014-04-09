//
//  WHCProjectTaskCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCProjectTaskCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView * icon;
@property (nonatomic, retain) IBOutlet UILabel * title;
@property (nonatomic, retain) IBOutlet UILabel * detail;
@property (nonatomic, retain) IBOutlet UIButton * checked;

@end
