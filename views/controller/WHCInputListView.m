//
//  WHCMessageListView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCInputListView.h"

@interface WHCInputListView ()

@end

@implementation WHCInputListView

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardChangeFrame:)
                                                name:UIKeyboardWillChangeFrameNotification
                                              object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillChangeFrameNotification
                                                 object:nil];
    [_inputText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark ----键盘高度变化------
-(void)onKeyboardChangeFrame:(NSNotification *)aNotifacation
{
    NSDictionary *info = [aNotifacation userInfo];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    
    CGRect inputFieldRect = self.view.frame;
    
    if (yOffset < 0) {
        inputFieldRect.origin.y += yOffset;
    } else if (yOffset == 0) {
        inputFieldRect.origin.y =  - endKeyboardRect.size.height;
    } else {
        inputFieldRect.origin.y = 0;
    }
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];    
    [UIView animateWithDuration:duration animations:^{
        [self.view setFrame:inputFieldRect];
        [_tableView setContentInset:UIEdgeInsetsMake(_tableView.contentInset.top-yOffset, 0, 0, 0)];

    }];


    //拿frame变化之后的origin.y-变化之前的origin.y，其差值(带正负号)就是我们self.view的y方向上的增量
    NSLog(@"%@", [aNotifacation userInfo]);
    NSLog(@"input view: %@", NSStringFromCGRect(self.inputView.frame));
    NSLog(@"deltaY:%f",yOffset);
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
