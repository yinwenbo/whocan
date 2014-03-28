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
//头像大小
#define HEAD_SIZE 50.0f
#define TEXT_MAX_HEIGHT 500.0f
//间距
#define INSETS 8.0f

@implementation WHCMessageCell

@synthesize message = _message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self setupView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupView
{
    _bubbleBg =[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_bubbleBg];
    
    _messageConent=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_messageConent];
    
    [_messageConent setLineBreakMode:NSLineBreakByWordWrapping];
    [_messageConent setFont:[UIFont systemFontOfSize:14]];
    [_messageConent setNumberOfLines:0];
    [_messageConent setBackgroundColor:[UIColor clearColor]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setBackgroundColor:[UIColor clearColor]];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_messageConent setHidden:NO];
    CGRect msgReact = [WHCMessageCell getTextRect:_messageConent.text];

    CGSize textSize = msgReact.size;
    [_messageConent setFrame:CGRectMake(CELL_WIDTH - INSETS * 2 - HEAD_SIZE - textSize.width - 15,
                                        (CELL_HEIGHT - textSize.height) / 2,
                                        textSize.width,
                                        textSize.height + 8)];
    [_bubbleBg setImage:[[UIImage imageNamed:@"SenderTextNodeBkg"] stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
    _bubbleBg.frame=CGRectMake(_messageConent.frame.origin.x - 12, _messageConent.frame.origin.y-6, textSize.width+30, textSize.height+30);
    [_bubbleBg setHidden:NO];

}
- (void)setMessage:(NSString *)message
{
    _message = message;
    [_messageConent setText:message];
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
    CGRect rect = [WHCMessageCell getTextRect:text];
    return rect.size.height + 30;
}
@end
