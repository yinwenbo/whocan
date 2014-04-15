//
//  WHCContactViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCSmsSendView.h"
#import "WHCContactEditView.h"
#import "WHCMessageView.h"
#import "WHCBarButtonSave.h"

#import "WHCAddFriendAPI.h"
#import "AppContact.h"

@interface WHCContactShowView : UITableViewController<WHCJsonAPIDelegate>

@property (nonatomic, retain) IBOutlet UIButton * btnMainAction;
@property (nonatomic, retain) IBOutlet UILabel * lblName;
@property (nonatomic, retain) IBOutlet UILabel * lblId;
@property (nonatomic, retain) IBOutlet UILabel * lblNickname;
@property (nonatomic, retain) IBOutlet UIImageView * iconView;

@property (nonatomic, retain) IBOutlet UILabel * lblMobileNo;

@property (nonatomic, retain) AppContact * appContact;

- (IBAction)onMainAction:(id)sender;

@end
