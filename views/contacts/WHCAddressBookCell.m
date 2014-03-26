//
//  WHCPhoneABTableViewCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAddressBookCell.h"
#import "WHCViewUtils.h"

@implementation WHCAddressBookCell

@synthesize titleLabel, actionButton, mobileNo;

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

-(void)setCellText:(NSString*)titleText actionText:(NSString*)actionText
{
    titleLabel.text = titleText;
    actionButton.titleLabel.text = actionText;
}
@end
