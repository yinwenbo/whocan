//
//  WHCIconSettingView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCIconSettingView.h"

@interface WHCIconSettingView () {
    UICollectionViewCell * _selectedCell;
}

@end

@implementation WHCIconSettingView

@synthesize iconName;

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
    [iconsView setDataSource:self];
    [iconsView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 24;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *imageName = [self getIconName:[indexPath row]];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    UIImageView *selectedBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_light_select"]];
    [cell setSelectedBackgroundView: selectedBG];
    [image setFrame:CGRectMake(0, 0, 54, 54)];
    [cell addSubview:image];
    if ([imageName isEqualToString:iconName]){
        [cell setSelected:YES];
        _selectedCell = cell;
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedCell) {
        [_selectedCell setSelected:NO];
    }
    _selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    iconName = [self getIconName:[indexPath row]];
    return YES;
}

- (NSString *)getIconName:(NSInteger)index
{
    return [NSString stringWithFormat:@"icon_monsterinc_%li", 256 + index];
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
