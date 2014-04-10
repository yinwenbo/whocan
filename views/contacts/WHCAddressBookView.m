//
//  WHCContactsViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-6.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAddressBookView.h"

@interface WHCAddressBookView () {
    NSArray * _appContacts;
}

@end

@implementation WHCAddressBookView

- (NSArray *)getAppContacts
{
    if(_appContacts == nil){
        _appContacts = [AppContact getAppContactsInPhone];
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

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (NSString *)getCellIdentifier:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [_appContacts count]) {
        return @"SumCell";
    }
    AppContact *appContact = [_appContacts objectAtIndex:[indexPath row]];
    if (![appContact isAppUser]) {
        return @"ContactCell";
    }
    if ([appContact isMyFriend]) {
        return @"FriendCell";
    }
    if ([appContact isMyInvite]) {
        return @"MyInviteCell";
    }
    if ([appContact isInviteMe]) {
        return @"InviteMeCell";
    }
    return @"NotFriendCell";
}

@end
