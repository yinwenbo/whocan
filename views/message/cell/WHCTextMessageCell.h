//
//  WHCTextMessageCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageCodecCell.h"

@interface WHCTextMessageCell : WHCMessageCodecCell

+ (CGFloat)getCellHeight:(NSString *)text;

- (void)sendTextMessage:(UIImage *)icon content:(NSString *)content;
- (void)receiveTextMessage:(UIImage *)icon content:(NSString *)content;
@end
