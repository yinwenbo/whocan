//
//  WHCBarInputView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-9.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCBarInputView.h"

@interface WHCBarInputView() {
    UIToolbar * _toolbar;
    UIBarButtonItem * _leftButton;
    UIBarButtonItem * _rightButton;
    UIView * _view;
}

@end

@implementation WHCBarInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    CGFloat toolbarHeight = _toolbar.frame.size.height;
    [_toolbar setFrame:CGRectMake(0.0f, 0.0f, rect.size.width, toolbarHeight)];
    CGFloat viewHeight = rect.size.height - toolbarHeight;
    [_view setFrame:CGRectMake(0.0f, toolbarHeight, rect.size.width, viewHeight)];
}


-(void)setView:(UIView *)view leftButton:(UIBarButtonItem *)leftButton rightButton:(UIBarButtonItem *)rightButton
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 35.0f)];
    [_toolbar setTranslucent:NO];
    [_toolbar setBarTintColor:[UIColor lightGrayColor]];

    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:self
                                                                          action:nil];
    [_toolbar setItems:[NSArray arrayWithObjects:leftButton, flex, rightButton, nil]];

    _leftButton = leftButton;
    _rightButton = rightButton;
    _view = view;
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_toolbar];
    [self addSubview:_view];

}

@end
