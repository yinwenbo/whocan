//
//  WHCSignInController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientInfo.h"
#import "WHCSignInAPI.h"


@interface WHCSignInView : UITableViewController<WHCJsonAPIDelegate>

@property IBOutlet UIButton * btnSignIn;
@property IBOutlet UIButton * btnSendVerifyCode;
@property IBOutlet UITextField * txtVerifyCode;
@property IBOutlet UITextField * txtMobileNo;

-(IBAction)onMobileNoChange:(id)sender;
-(IBAction)onVerifyCodeChange:(id)sender;

-(IBAction)onSignInPush:(id)sender;
-(IBAction)onSendVrifyPush:(id)sender;

-(NSString*)getMobileNo;
-(NSString*)getVerifyCode;

@end
