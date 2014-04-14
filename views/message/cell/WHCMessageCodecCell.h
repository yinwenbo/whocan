//
//  WHCMessageCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCMessageCodecCell : UITableViewCell 

- (void)sendMessage:(UIImage*)icon content:(UIView*)content;
- (void)receiveMessage:(UIImage*)icon content:(UIView*)content;

@end
