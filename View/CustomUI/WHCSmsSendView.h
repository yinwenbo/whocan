//
//  WHCSmsSendController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-24.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@interface WHCSmsSendView : MFMessageComposeViewController<MFMessageComposeViewControllerDelegate>

+ (WHCSmsSendView *)initWithInvite:(NSString *)mobileNo;

@end
