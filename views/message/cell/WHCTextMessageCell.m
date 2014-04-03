//
//  WHCTextMessageCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCTextMessageCell.h"

@implementation WHCTextMessageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (UILabel *)getTextLabel:(NSString*)text
{
    UILabel *content = [[UILabel alloc] initWithFrame:[WHCTextMessageCell getTextRect:text]];
    [content setLineBreakMode:NSLineBreakByWordWrapping];
    [content setFont:[UIFont systemFontOfSize:14]];
    [content setNumberOfLines:0];
    [content setBackgroundColor:[UIColor clearColor]];
    [content setText:text];
    return content;
}


-(void)sendTextMessage:(UIImage *)icon content:(NSString *)content
{
    [super sendMessage:icon content:[self getTextLabel:content]];
}

- (void)receiveTextMessage:(UIImage *)icon content:(NSString *)content
{
    [super receiveMessage:icon content:[self getTextLabel:content]];
}

+ (CGRect)getTextRect:(NSString*)text
{
    return [text boundingRectWithSize:CGSizeMake(200.0f, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                              context:nil];
}

+ (CGFloat)getCellHeight:(NSString*)text
{
    CGRect rect = [self getTextRect:text];
    return rect.size.height + 30;
}

@end
