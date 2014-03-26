//
//  WHCProjectViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-10.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCProjectViewController.h"
#import "WHCIconLabelViewCell.h"

@interface WHCProjectViewController (){
    NSMutableArray * contacts;
}

@end

@implementation WHCProjectViewController

@synthesize projectName, btnRemind, barBtnNext, viewState, sectionView, contactsView, worksView;

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
    
    btnRemind.layer.cornerRadius = 10;
    btnRemind.layer.borderWidth = 1.0;
    btnRemind.layer.borderColor = btnRemind.currentTitleColor.CGColor;

//    if(project == nil){
        viewState = CreateView;
        contacts = [[NSMutableArray alloc] init];
//    }else{
//        viewState = ShowView;
//        projectName.text = project.name;
//        self.title = project.name;
//        contacts = [[NSMutableArray alloc] init];
//    }
    [self initViewState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == contactsView){
        return contacts.count;
    }
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    if(collectionView == contactsView){
//        WHCIconLabelViewCell * iconCell = (WHCIconLabelViewCell *)cell;
//        iconCell.label.text = [WHCPhoneContactsController getPersonName: CFBridgingRetain([contacts objectAtIndex:indexPath.row])];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = [segue destinationViewController];
    if([viewController isKindOfClass:[WHCAddressBookController class]]){
        WHCContactPickerViewController * pickerView = (WHCContactPickerViewController *) viewController;
        pickerView.selectedContacts = contacts;
    }
}

- (IBAction)contactPicked:(UIStoryboardSegue *)unwindSegue
{
    UIViewController *viewController = [unwindSegue sourceViewController];
    if([viewController isKindOfClass:[WHCContactPickerViewController class]]){
        WHCContactPickerViewController * pickerView = (WHCContactPickerViewController *) viewController;
        contacts = pickerView.selectedContacts;
        [contactsView reloadData];
    }
}
- (void)createProject
{
    /*
    NSManagedObjectContext * context = [WHCModelStore getInstance].managedObjectContext;
    
    MessageGroup *group = (MessageGroup *)[NSEntityDescription insertNewObjectForEntityForName:@"MessageGroup" inManagedObjectContext:context];
    group.name = projectName.text;
    
    Project *p = (Project *)[NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
    p.name = projectName.text;
    p.projectId = [[[NSUUID alloc] init] UUIDString];
    
    NSError *error;
    if(![context save:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    */
}


- (void)onContactsPicked
{
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"test"
//                                                    message:@"test"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"取消"
//                                          otherButtonTitles:@"btn1", @"btn2", nil];
//    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];    
}

#pragma UI init
- (void)initViewState
{
    switch (viewState) {
        case CreateView:
            barBtnNext.title = @"创建";
            break;
        case EditView:
            barBtnNext.title = @"保存";
            break;
        default:
            barBtnNext.title = @"修改";
            break;
    }
    NSLog(@"%@", barBtnNext.title);
}

#pragma Button Function

- (IBAction)onNextButtonClick:(id)sender
{
    NSLog(@"start next button: %u", viewState);
    switch (viewState) {
        case CreateView:
            break;
        case EditView:
            viewState = ShowView;
            break;
        case ShowView:
            viewState = EditView;
            break;
        default:
            break;
    }
    NSLog(@"end next button: %u", viewState);
    [self initViewState];

}
@end
