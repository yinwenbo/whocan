//
//  WHCIconView.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-10.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCIconCollection.h"

@implementation WHCIconCollection

@synthesize iconName;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDataSource:self];
        [self setDelegate:self];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *imageName = [self getIconName:[indexPath row]];
    UIImageView * image = (UIImageView*)[cell viewWithTag:1];
    [image setImage:[UIImage imageNamed:imageName]];
    UIImageView *selectedBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_light_select"]];
    [cell setSelectedBackgroundView: selectedBG];
    if ([iconName isEqualToString:imageName]) {
        [cell setSelected:YES];
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isSelected]) {
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    iconName = [self getIconName:[indexPath row]];
}

- (NSString *)getIconName:(NSInteger)index
{
    return [NSString stringWithFormat:@"icon_monsterinc_%li", 256l + index];
}

@end
