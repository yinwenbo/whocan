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
    IBOutlet UITextField * _taskTitle;
    IBOutlet UILabel * _deadline;
    IBOutlet UITextView * _remark;
    IBOutlet UILabel * _owner;
    IBOutlet UISegmentedControl * _priority;
    
    NSDate * _templateDeadline;
    AppContact * _templateOwner;
    BOOL isFinished;
}

@end

@implementation WHCTaskView

@synthesize task = _task;
@synthesize taskGroupId;

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

- (void)initView
{
    if (_task) {
        [_taskTitle setText:_task.title];
        [_remark setText:_task.remark];
        if (_task.deadline || [_task.finished boolValue] == YES) {
            [_deadline setText:[self getDeadlineLabel:_task.deadline]];
        }

    }
    if (_task.priority) {
        [_priority setSelectedSegmentIndex:[_task.priority integerValue]];
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/*
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
//    [_deadline setInputView:view];

}

- (void)onDatePickerChange:(id)sender
{
    UIDatePicker *dp = (UIDatePicker*)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
//    [[_deadlineCell detailTextLabel] setText:[df stringFromDate:[dp date]]];
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}

- (IBAction)unwindToTaskView:(UIStoryboardSegue *)unwindSegue
{
    UIViewController * vc = unwindSegue.sourceViewController;
    if ([vc isKindOfClass:[WHCTaskDeadlineView class]]) {
        _templateDeadline = ((WHCTaskDeadlineView *)vc).value;
        isFinished = (_templateDeadline == nil);
        [_deadline setText:[self getDeadlineLabel:_templateDeadline]];
    }
    for (UIView *view in [self.view subviews]){
        if ([view isKindOfClass:[CUISemiView class]]) {
            [((CUISemiView*) view) closeSemiView];
            
        }
    }
}

- (NSString *)getDeadlineLabel:(NSDate *)deadline;
{
    if (deadline == nil) {
        return @"已完成";
    }
    NSArray * DayLabels = @[@"今天", @"明天", @"后天"];
    
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:[NSDate date]];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:deadline];
    NSInteger day = [[NSCalendar currentCalendar] components:NSDayCalendarUnit
                                                    fromDate:fromDate
                                                      toDate:toDate
                                                     options:0].day;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMd'日' cccc"];
    NSString * dateLabel = [dateFormatter stringFromDate:deadline];
    
    if (day >= 0 && day < [DayLabels count]) {
        return [NSString stringWithFormat:@"%@ %@", [DayLabels objectAtIndex:day], dateLabel];
    }

    return dateLabel;
}

- (BOOL)save
{
    if (_task == nil) {
        _task = [ProjectTasks createTask];
        _task.taskId = [[[NSUUID alloc] init] UUIDString];
        _task.projectId = taskGroupId;
        _task.parentId = nil;
        _task.ownerId = nil;
        _task.createTime = [NSDate date];
//        _task.creatorId = _mine.appId;
    }

    _task.title = _taskTitle.text;
    _task.priority = [NSNumber numberWithInteger:[_priority selectedSegmentIndex]];
    _task.remark = _remark.text;
    _task.deadline = _templateDeadline;
    _task.ownerId = _templateOwner.appId;
    [ProjectTasks saveContext];

    return YES;
}

@end
