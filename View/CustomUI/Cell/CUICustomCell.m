//
//  CUICustomCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-23.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "CUICustomCell.h"

@implementation CUICustomCell

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

    if (selected) {
        [super setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [super setAccessoryType:UITableViewCellAccessoryNone];
    }
}

@end
