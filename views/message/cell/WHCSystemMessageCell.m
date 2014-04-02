//
//  WHCSystemMessageCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-2.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSystemMessageCell.h"

@implementation WHCSystemMessageCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    CGRect rect = [WHCSystemMessageCell getTextRect:text];
    return rect.size.height + 30;
}

@end
