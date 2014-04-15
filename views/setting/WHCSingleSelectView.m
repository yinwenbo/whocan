//
//  WHCSingleSelectView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSingleSelectView.h"

@interface WHCSingleSelectView () {
    NSString * _selectedValue;
    UITableViewCell * _selectedCell;
}

@end

@implementation WHCSingleSelectView

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (_selectedCell) {
        [self deSelectedCell:_selectedCell];
    }
    [self selectedCell:cell];
    _selectedCell = cell;
    _selectedValue = cell.textLabel.text;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell.textLabel.text isEqualToString:_selectedValue]){
        [self selectedCell:cell];
        _selectedCell = cell;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == _selectedCell) {
        [self deSelectedCell:cell];
        _selectedCell = nil;
    }
}

- (void)selectedCell:(UITableViewCell *)cell
{
    [cell setSelected:YES];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)deSelectedCell:(UITableViewCell *)cell
{
    [cell setSelected:NO];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
}
- (void)setTextValue:(NSString *)value
{
    _selectedValue = value;
}

-(NSString *)getTextValue
{
    return _selectedValue;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
