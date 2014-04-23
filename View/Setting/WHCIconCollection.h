//
//  WHCIconView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-10.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCIconCollection : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSString * iconName;

@end
