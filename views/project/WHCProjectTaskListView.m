//
//  WHCProjectTaskListView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCProjectTaskListView.h"

@interface WHCProjectTaskListView () {
    IBOutlet UIBarButtonItem * _moreAction;
    NSString * _projectId;
    ProjectTasks * _selectedTask;
    NSArray * _tasks;
    AppContact * _mine;
}

@end

@implementation WHCProjectTaskListView

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

    // Do any additional setup after loading the view.
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
    if ([view isKindOfClass:[WHCProjectTaskView class]]) {
        [((WHCProjectTaskView*)view) setTaskId: _selectedTask.taskId];
    }
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
    WHCProjectTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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

- (IBAction)createTask:(id)sender
{
    UITextField *text = (UITextField *)sender;
    if (text.text.length == 0){
        return;
    }
    
    ProjectTasks *task = [ProjectTasks createTask];
    task.taskId = [[[NSUUID alloc] init] UUIDString];
    task.projectId = _projectId;
    task.parentId = _projectId;
    task.ownerId = _mine.appId;
    task.creatorId = _mine.appId;
    task.title = text.text;
    task.createTime = [[NSDate alloc] init];
    [ProjectTasks saveContext];
    [self initTasks];
    text.text = @"";
}

- (IBAction)moreActions:(id)sender
{
    UIActionSheet *myActionSheet=[[UIActionSheet alloc]initWithTitle:@"标题"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消键"
                                              destructiveButtonTitle:@"毁灭键"
                                                   otherButtonTitles:@"额外加键", nil];
        //这样就创建了一个UIActionSheet对象，如果要多加按钮的话在nil前面直接加就行，记得用逗号隔开。
        //下面是显示，注意ActioinSheet是出现在底部的，是附加在当前的View上的，所以我们用showInView方法
//    [myActionSheet showInView:self.view];
    [myActionSheet showFromBarButtonItem:_moreAction animated:YES];
//    [myActionSheet showFromToolbar:[[self navigationController] toolbar]];
}

@end
