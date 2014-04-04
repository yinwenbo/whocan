//
//  WHCTextEditView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCTextEditView : UITableViewController

@property (nonatomic, retain) IBOutlet UITextField * textField;

- (void)setText:(NSString *)text;

@end
