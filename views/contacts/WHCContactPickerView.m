//
//  WHCContactPickerViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactPickerView.h"


@implementation WHCContactPickerView

@synthesize selectedContacts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedContacts = [NSMutableArray array];
    [self.tableView registerClass:[WHCContactCell class] forCellReuseIdentifier:@"ContactCell"];
}

- (NSInteger)topFixCellCount
{
    return 0;
}

- (BOOL)hasTotalCell
{
    return NO;
}

- (BOOL)hasRefesh
{
    return NO;
}

- (BOOL)showAccessoryButton
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if(cell.isSelected){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    AppContact * contact = [[self getAppContacts] objectAtIndex:[indexPath row]];
    [selectedContacts addObject:contact];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self unSelectContact:indexPath.row];
    AppContact * contact = [[self getAppContacts] objectAtIndex:[indexPath row]];
    [selectedContacts removeObject:contact];
}

- (void)selectContact:(NSInteger)index
{
//    ABRecordRef contact = (ABRecordRef)CFBridgingRetain([self.phoneContacts objectAtIndex:index]);
//    if(![self inSelectContacts:contact]){
//        [self.selectedContacts addObject:CFBridgingRelease(contact)];
//    }
//    NSLog(@"selected count %lu", (unsigned long)[self.selectedContacts count]);
}

- (void)unSelectContact:(NSInteger)index
{
//    [self.selectedContacts removeObject:[self.phoneContacts objectAtIndex:index]];
//    NSLog(@"selected count %lu", (unsigned long)[self.selectedContacts count]);
}

- (Boolean)inSelectContacts:(ABRecordRef)record
{
//    for(int i = 0; i <self.selectedContacts.count; i++){
//        ABRecordRef selected =  (ABRecordRef)CFBridgingRetain([self.selectedContacts objectAtIndex:i]);
//        if([WHCPhoneContactsController isSamePerson:record record2:selected]){
//            return true;
//        }
//    }
    return false;
}

@end
