//
//  WHCProjectTaskListView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCTaskListView.h"

@interface WHCTaskListView () {
    IBOutlet UIBarButtonItem * _moreAction;
    NSString * _projectId;
    ProjectTasks * _selectedTask;
    NSArray * _tasks;
    AppContact * _mine;
    HttpJsonAPI * _findTasklistApi;
}

@end

@implementation WHCTaskListView

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
    _mine = [AppContact findMySelf];
    [self initTasks];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    _findTasklistApi = [TasklistDelegate findTasklistByGroupId:_projectId];
    [_findTasklistApi startAsynchronize:^(HttpJsonAPI *api) {
        [TasklistDelegate updateTasklistByAPIResult:[api getResult]];
        [self initTasks];
        _findTasklistApi = nil;
    } showProgressOn:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *view = [segue destinationViewController];
    if ([view isKindOfClass:[UINavigationController class]]) {
        view = ((UINavigationController*)view).topViewController;
    }
    if ([view isKindOfClass:[WHCTaskView class]]) {
        WHCTaskView * taskView = (WHCTaskView*)view;
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            taskView.task = _selectedTask;
        }else {
            taskView.taskGroupId = _projectId;
            taskView.task = nil;
        }
        
    }
}

- (IBAction)unwindToTaskListView:(UIStoryboardSegue *)unwindSegue
{
    [self initTasks];
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    if ([fromViewController isKindOfClass:[WHCTaskView class]] && [sender tag] == 1) {
        return [((WHCTaskView *)fromViewController) save];
    }
    return YES;
}

#pragma mark - Table Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WHCTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ProjectTasks * task = [_tasks objectAtIndex:[indexPath row]];
    [cell setTask:task];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedTask = [_tasks objectAtIndex:[indexPath row]];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)initTasks
{
    _tasks = [ProjectTasks findTasksByProjectId:_projectId];
    [_tableView reloadData];
}

- (void)setProjectId:(NSString *)projectId
{
    _projectId = projectId;
    [self initTasks];
}

- (IBAction)moreActions:(id)sender
{
    UIActionSheet *myActionSheet=[[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:@"全部"
                                                   otherButtonTitles:@"已完成任务", @"未分配任务", @"进行中的任务", nil];
        //这样就创建了一个UIActionSheet对象，如果要多加按钮的话在nil前面直接加就行，记得用逗号隔开。
        //下面是显示，注意ActioinSheet是出现在底部的，是附加在当前的View上的，所以我们用showInView方法
//    [myActionSheet showInView:self.view];
    [myActionSheet showFromBarButtonItem:_moreAction animated:YES];
//    [myActionSheet showFromToolbar:[[self navigationController] toolbar]];
}

@end
