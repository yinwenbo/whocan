//
//  WHCViewUtils.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCSmsSendController.h"
#import "WHCBarButtonSave.h"

@interface WHCViewUtils : NSObject

+ (WHCSmsSendController *)getInviteSMSView:(NSString*)mobileNo;

@end
