//
//  WHCNewFriendsController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCFriendsView.h"

@interface WHCFriendsView (){
    NSArray * _appContacts;
}

@end

@implementation WHCFriendsView

- (NSArray *)getAppContacts
{
    if(_appContacts == nil){
        _appContacts = [AppContact getAppUsers];
    }
    return _appContacts;
}

- (BOOL)hasTotalCell{
    return YES;
}

- (NSInteger)topFixCellCount
{
    return 0;
}

@end
