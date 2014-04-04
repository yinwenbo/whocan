//
//  WHCIconSettingView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCIconSettingView : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource> {
    IBOutlet UICollectionView *iconsView;
}

@property (nonatomic, retain) NSString * iconName;

@end
