//
//  WHCContactsViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-6.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "AddressBookUtil.h"
#import "AppContact.h"

@interface WHCPhoneContactsController : UITableViewController<UINavigationControllerDelegate, UINavigationBarDelegate>{

}

@property (nonatomic, weak) IBOutlet UIBarButtonItem * barBtnRight;

@property (nonatomic, retain) NSArray * appContacts;

- (IBAction)addToFriend:(id)sender;
- (IBAction)sendInvite:(id)sender;
@end
