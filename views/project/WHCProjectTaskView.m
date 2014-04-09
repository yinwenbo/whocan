//
//  WHCProjectTaskView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCProjectTaskView.h"

@interface WHCProjectTaskView () {
    ProjectTasks * _task;
    UITableViewCell * _deadlineCell;
    IBOutlet UITextField * _taskTitle;
    IBOutlet UITextField * _deadline;
    IBOutlet UISwitch * _finished;
    IBOutlet UITextView * _remark;
}

@end

@implementation WHCProjectTaskView

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
    [self initView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTaskId:(NSString *)taskId
{
    _task = [ProjectTasks findTask:taskId];
}

- (void)initView
{
    [self initTaskTitleEditor];
    [self initDeadlineEditor];
    [_finished setOn:_task.finished animated:YES];
    [_remark setText:_task.remark];
}

- (void)initTaskTitleEditor
{
    _taskTitle = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [_taskTitle setText:_task.title];
}

- (void)initDeadlineEditor
{
    UIDatePicker *dp = [[UIDatePicker alloc]init];
    [dp setDatePickerMode:UIDatePickerModeDate];
    [dp addTarget:self action:@selector(onDatePickerChange:) forControlEvents:UIControlEventValueChanged];
    WHCBarInputView *view = [[WHCBarInputView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 200.0f)];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:nil];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:nil];
    [view setView:dp leftButton:cancel rightButton:done];
    _deadline = [[UITextField alloc] init];
    [_deadline setInputView:view];

}

- (void)onDatePickerChange:(id)sender
{
    UIDatePicker *dp = (UIDatePicker*)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [[_deadlineCell detailTextLabel] setText:[df stringFromDate:[dp date]]];
}


#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [_taskTitle setFrame:CGRectMake(44.0f, 10.0f, tableView.frame.size.width - 48, 24.0f)];
    [_taskTitle setBackgroundColor:[UIColor clearColor]];
    [_taskTitle setFont:[UIFont systemFontOfSize:16]];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(16.0f, 10.0f, 24.0f, 24.0f)];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_checkbox_uncheck"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_checkbox_checked"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(taskFinished:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [view addSubview:_taskTitle];
    return view;
}

- (void)taskFinished:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    [btn setSelected:!btn.selected];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath row] == 2) {
        return [tableView dequeueReusableCellWithIdentifier:@"OwnerCell" forIndexPath:indexPath];
    }
    
    if ([indexPath row] == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DeadlineCell" forIndexPath:indexPath];
        [cell addSubview:_deadline];
        _deadlineCell = cell;
        if (_task.deadline) {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            [cell.detailTextLabel setText:[df stringFromDate:_task.deadline]];
        } else {
            [cell.detailTextLabel setText:@""];
        }
        return cell;
    }

    if ([indexPath row] == 1) {
        return [tableView dequeueReusableCellWithIdentifier:@"RemarkCell" forIndexPath:indexPath];
    }
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    if ([indexPath row] == 0) {
        [_deadline becomeFirstResponder];
    }
        
    return indexPath;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    [_taskTitle setFrame:CGRectMake(40.0f, 0.0f, view.frame.size.width - 40, view.frame.size.height)];
//    UIImageView * icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_checkbox_uncheck"]
//                                           highlightedImage:[UIImage imageNamed:@"icon_checkbox_checked"]];
//    [icon setFrame:CGRectMake(4.0f, 8.0f, 32.0f, 32.0f)];
//    [view addSubview:icon];
//    [view addSubview:_taskTitle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 1) {
        return 161.0f;
    }
    return 44.0f;
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 20)];
    [view addSubview:[[UITextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200, 20)]];
    return view;
}
 */
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
