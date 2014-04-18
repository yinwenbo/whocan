//
//  WHCMessageCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-11.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageCell.h"

@interface WHCMessageCell() {
    UILabel * _lblText;
    UIImageView * _viewTextBkg;
        
}

@end

@implementation WHCMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self initView];
}

- (void)initView
{
    if (self.background) {
        UIImageView * imgView = self.background;
        _viewTextBkg = [[UIImageView alloc] initWithImage:[imgView.image stretchableImageWithLeftCapWidth:30 topCapHeight:30]];
        [_viewTextBkg setFrame:imgView.frame];
    
        [self addSubview:_viewTextBkg];
        [_viewTextBkg setHidden:NO];
        [imgView setHidden:YES];
    }
    
    UILabel * label = self.text;
    _lblText = [[UILabel alloc] initWithFrame:label.frame];
    [_lblText setNumberOfLines:0];
    [_lblText setFont:label.font];
//    [_lblText setTextAlignment:label.textAlignment];
    
    [self addSubview:_lblText];
    [_lblText setHidden:NO];
    [label setHidden:YES];
    
}

- (void)layoutView
{
    UILabel * lable = self.text;
    NSString * content = _lblText.text;
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(lable.frame.size.width, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:lable.font}
                                               context:nil];
    
    
    CGFloat widthDiff = lable.frame.size.width - contentRect.size.width;
    contentRect.origin.x = lable.frame.origin.x;
    if (lable.textAlignment == NSTextAlignmentRight) {
        contentRect.origin.x += widthDiff;
    }
    contentRect.origin.y = lable.frame.origin.y;
    contentRect.size.height += 4;
    [_lblText setFrame:contentRect];
    
    if (self.background) {
        UIImageView * imgView = self.background;
        CGRect bkgRect = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
        bkgRect.origin.x = imgView.frame.origin.x;
        if (lable.textAlignment == NSTextAlignmentRight) {
            bkgRect.origin.x += widthDiff;
        }
        bkgRect.origin.y = imgView.frame.origin.y;
        bkgRect.size.width += imgView.frame.size.width - lable.frame.size.width;
        bkgRect.size.height += imgView.frame.size.height - lable.frame.size.height;
        [_viewTextBkg setFrame:bkgRect];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutView];
}

- (void)setViewFrame:(UIView *)view frame:(CGRect)frame
{
    [view setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
}

- (void)setContent:(NSString *)content icon:(UIImage *)icon
{
    [_lblText setText:content];
    [self.icon setImage:icon];
}

- (CGFloat)getCellHeight:(NSString *)content
{
    if (self.background) {
        return self.background.frame.origin.y + self.background.frame.size.height + [self getDiffRect:content].size.height;
    }
    return 20;
}

- (CGRect)getDiffRect:(NSString *)content
{
    UILabel * lable = self.text;

    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(lable.frame.size.width, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:lable.font}
                                               context:nil];
    CGFloat widthDiff = lable.frame.size.width - contentRect.size.width;
    contentRect.origin.x = lable.frame.origin.x;
    if (lable.textAlignment == NSTextAlignmentRight) {
        contentRect.origin.x += widthDiff;
    }

    CGFloat heightDiff = contentRect.size.height - lable.frame.size.height;

    return CGRectMake(contentRect.origin.x, 0, widthDiff, heightDiff);
}



@end
