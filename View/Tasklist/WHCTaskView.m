//
//  WHCProjectTaskView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCTaskView.h"

#import "WHCIconCollection.h"

@interface WHCTaskView () {
    ProjectTasks * _task;
    UITableViewCell * _deadlineCell;
    IBOutlet UITextField * _taskTitle;
    IBOutlet UITextField * _deadline;
    IBOutlet UISwitch * _finished;
    IBOutlet UITextView * _remark;
    IBOutlet UITextField * _owner;
}

@end

@implementation WHCTaskView

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
    [self initDeadlineEditor];
    [_finished setOn:[_task.finished boolValue]animated:YES];
    [_remark setText:_task.remark];
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
//    _deadline = [[UITextField alloc] init];
    [_deadline setInputView:view];

}

- (void)onDatePickerChange:(id)sender
{
    UIDatePicker *dp = (UIDatePicker*)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [[_deadlineCell detailTextLabel] setText:[df stringFromDate:[dp date]]];
}

- (IBAction)unwindToTaskView:(UIStoryboardSegue *)unwindSegue
{
}


@end
