//
//  WHCContactPickerViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCAddressBookController.h"

@interface WHCContactPickerViewController : WHCAddressBookController

@property (nonatomic, retain) NSMutableArray * selectedContacts;

@end
