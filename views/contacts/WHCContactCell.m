//
//  WHCPhoneABTableViewCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactCell.h"
#import "WHCViewUtils.h"

@implementation WHCContactCell

@synthesize appContact = _appContact;

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


- (void)setAppContact:(AppContact *)appContact
{
    _appContact = appContact;
    [self initView];
}

- (void)initView
{
    if (self.title) {
        [self.title setText:[_appContact getName]];
    }
    if (self.icon) {
        [self.icon setImage:[_appContact getIcon]];
    }
}

@end
