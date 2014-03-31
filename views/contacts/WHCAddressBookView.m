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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getAppContacts] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super getContactCell:tableView cellForRowAtIndexPath:indexPath];
}

@end
