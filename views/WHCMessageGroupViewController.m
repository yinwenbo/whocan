//
//  WHCMessageGroupViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageGroupViewController.h"
#import "WHCProjectViewController.h"

#import "MessageGroup.h"

#import "WHCModelStore.h"

@interface WHCMessageGroupViewController ()

@end

@implementation WHCMessageGroupViewController

WHCProjectViewController *projectView;

NSArray * groups;

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

- (void)viewWillAppear:(BOOL)animated
{
    
    NSError *error;
    if(!(groups = [self getMessageGroups])){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    [self.tableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [(MessageGroup*)[groups objectAtIndex:indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
//    Project *project = (Project *)[groups objectAtIndex:indexPath.row];
//    [projectView setProject:project];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = [segue destinationViewController];
    if([viewController isKindOfClass:[WHCProjectViewController class]]){
        projectView = (WHCProjectViewController *) viewController;
    }
}


-(NSArray *) getMessageGroups{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSManagedObjectContext * context = [WHCModelStore getInstance].managedObjectContext;
    NSEntityDescription *myEntityQuery = [NSEntityDescription
                                          entityForName:@"MessageGroup"
                                          inManagedObjectContext:context];
    [request setEntity:myEntityQuery];
    
    NSError *error = nil;
    NSArray * result = [context executeFetchRequest:request error:&error];

    return result;
}



@end
