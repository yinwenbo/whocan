//
//  WHCContactPickerViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactPickerViewController.h"

@interface WHCContactPickerViewController ()

@end

@implementation WHCContactPickerViewController

@synthesize selectedContacts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

//    ABRecordRef person = (ABRecordRef)CFBridgingRetain([self.phoneContacts objectAtIndex:indexPath.row]);
//    if([self inSelectContacts:person]){
//        [cell setSelected:YES];
//    }
    if(cell.isSelected){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
//    NSString * phoneNo = [AddressBookUtil getMobilePhoneNo:[indexPath row]];
//    NSString * mail = [AddressBookUtil getEmail:indexPath.row];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", phoneNo, mail];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self selectContact:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self unSelectContact:indexPath.row];
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
