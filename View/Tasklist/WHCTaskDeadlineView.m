//
//  WHCTaskDeadlineView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-22.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCTaskDeadlineView.h"

@interface WHCTaskDeadlineView () {
    NSMutableArray * _titles;
    NSMutableArray * _values;
    NSDateFormatter * _dateFormatter;
}

@end


@implementation WHCTaskDeadlineView

@synthesize value;

static NSDateFormatter *dateFormatter;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titles = [NSMutableArray arrayWithObjects:@"今天", @"明天", @"后天", @"3天", @"4天", @"5天", nil];
    _values = [NSMutableArray arrayWithCapacity:[_titles count]];
    
    NSDate * now = [NSDate date];
    NSDateComponents * dc = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    for (int i = 0; i < [_titles count]; i++){
        dc.day = i;
        [_values addObject:[calendar dateByAddingComponents:dc toDate:now options:0]];
    }
    
    [_titles addObject:@"已完成"];
    
    _dateFormatter = [[NSDateFormatter alloc]init];
    [_dateFormatter setDateFormat:@"MMMd'日' cccc"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_titles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    [cell.textLabel setText:[_titles objectAtIndex:row]];

    if ([_values count] > row) {
        [cell.detailTextLabel setText:[_dateFormatter stringFromDate:[_values objectAtIndex:row]]];
    } else {
        [cell.detailTextLabel setText:nil];
    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if ([_values count] > row) {
        value = [_values objectAtIndex:row];
    } else {
        value = nil;
    }
    return indexPath;
}

@end
