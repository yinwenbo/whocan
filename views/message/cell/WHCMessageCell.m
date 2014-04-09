//
//  WHCMessageCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageCell.h"

#define CELL_HEIGHT self.contentView.frame.size.height
#define CELL_WIDTH self.contentView.frame.size.width

#define CONTENT_HEIGHT content.frame.size.height
#define CONTENT_WIDTH content.frame.size.width

//头像大小
#define ICON_SIZE 50.0f
#define TEXT_MAX_HEIGHT 500.0f
//间距
#define INSETS 8.0f

@implementation WHCMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)initView:(UIImage *)icon iconFrame:(CGRect)iconFrame
         content:(UIView *)content contentFrame:(CGRect)contentFrame
      background:(UIImage *)background backgroundFrame:(CGRect)backgroundFrame
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *iconView = [[UIImageView alloc]initWithImage:icon];
    [iconView setFrame:iconFrame];
    [self.contentView addSubview:iconView];
    
//    _iconMask = [[UIImageView alloc]initWithFrame:CGRectZero];
//    [self.contentView addSubview:_iconMask];
    
    UIImageView *backgroundView =[[UIImageView alloc] initWithImage:background];
    [backgroundView setFrame:backgroundFrame];
    [self.contentView addSubview:backgroundView];
    
    [content setFrame:contentFrame];
    [self.contentView addSubview:content];

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)sendMessage:(UIImage *)icon content:(UIView*)content
{
    CGRect iconFrame = CGRectMake(CELL_WIDTH - INSETS - ICON_SIZE, INSETS, ICON_SIZE, ICON_SIZE);
    
    CGFloat contentX = CELL_WIDTH - (INSETS * 3) - ICON_SIZE - CONTENT_WIDTH;
    CGFloat contentY = (CELL_HEIGHT - CONTENT_HEIGHT) / 2;
    CGRect contentFrame = CGRectMake(contentX, contentY, CONTENT_WIDTH, CONTENT_HEIGHT + 8);
    
    UIImage *background = [[UIImage imageNamed:@"SenderText"] stretchableImageWithLeftCapWidth:20 topCapHeight:30];
    CGRect backgroundFrame = CGRectMake(contentX - 12, contentY - 6, CONTENT_WIDTH + 30, CONTENT_HEIGHT + 30);

    
    [self initView:icon iconFrame:iconFrame
           content:content contentFrame:contentFrame
        background:background backgroundFrame:backgroundFrame];
}

- (void)receiveMessage:(UIImage *)icon content:(UIView*)content
{
    CGRect iconFrame = CGRectMake(INSETS, INSETS, ICON_SIZE, ICON_SIZE);
    
    CGFloat contentX = (INSETS * 2) + ICON_SIZE;
    CGFloat contentY = (CELL_HEIGHT - CONTENT_HEIGHT) / 2;
    CGRect contentFrame = CGRectMake(contentX, contentY, CONTENT_WIDTH, CONTENT_HEIGHT + 8);
    
    UIImage *background = [[UIImage imageNamed:@"ReceiverText"] stretchableImageWithLeftCapWidth:20 topCapHeight:30];
    CGRect backgroundFrame = CGRectMake(contentX - 12, contentY - 6, CONTENT_WIDTH + 30, CONTENT_HEIGHT + 30);
    
    [self initView:icon iconFrame:iconFrame
           content:content contentFrame:contentFrame
        background:background backgroundFrame:backgroundFrame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
