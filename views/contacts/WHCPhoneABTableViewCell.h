//
//  WHCPhoneABTableViewCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCPhoneABTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UIButton * actionButton;

-(void)setCellText:(NSString*)titleText actionText:(NSString*)actionText;
@end
