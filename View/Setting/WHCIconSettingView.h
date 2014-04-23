//
//  WHCIconSettingView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCAnalytics.h"
#import "WHCIconCollection.h"

@interface WHCIconSettingView : UIViewController

- (void)setIconName:(NSString *)iconName;
- (NSString *)getIconName;

@end
