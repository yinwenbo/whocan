//
//  WHCPhoneABTableViewCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppContact.h"

@interface WHCContactCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView * icon;
@property (nonatomic, retain) IBOutlet UILabel * title;
@property (nonatomic, retain) IBOutlet UIButton * button;

@property (nonatomic, retain) AppContact * appContact;


@end
