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
    AppContact * contact = [[self getAppContacts] objectAtIndex:[indexPath row]];
    [selectedContacts removeObject:contact];
}
@end
