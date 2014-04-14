//
//  WHCMessageCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-11.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCMessageCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView * icon;
@property (nonatomic, retain) IBOutlet UILabel * text;
@property (nonatomic, retain) IBOutlet UIImageView * background;

- (void)setContent:(NSString *)content icon:(UIImage*)icon;
- (CGFloat)getCellHeight:(NSString *)content;

@end
