//
//  WHCMessageCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCMessageCell : UITableViewCell {
    UIImageView *_userHead;
    UIImageView *_bubbleBg;
    UIImageView *_headMask;
    UIImageView *_chatImage;
    UILabel *_messageConent;

}

@property (nonatomic, retain) NSString * message;

+ (CGRect)getTextRect:(NSString*)text;
+ (CGFloat)getCellHeight:(NSString*)text;
@end
