//
//  WHCTextEditView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCTextEditView.h"

@interface WHCTextEditView () {
    NSString * _text;
}

@end

@implementation WHCTextEditView

@synthesize textField;

-(void)viewDidLoad
{
    [textField setText:_text];
    [textField setPlaceholder:_text];
}

- (void)setText:(NSString *)text
{
    _text = text;
}
@end
