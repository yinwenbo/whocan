//
//  WHCSystemMessageCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-2.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCSystemMessageCell : UITableViewCell

@property (nonatomic, retain) NSString *message;

+ (CGFloat)getCellHeight:(NSString*)text;

@end
