//
//  WHCProjectViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-10.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCContactPickerViewController.h"

#import "MessageGroup.h"

#import "WHCModelStore.h"

@interface WHCProjectViewController : UITableViewController<UICollectionViewDelegate, UICollectionViewDataSource>

enum ProjectViewState
{
    CreateView, EditView, ShowView
};


@property (nonatomic, weak) IBOutlet UITextField * projectName;
@property (nonatomic, weak) IBOutlet UIButton * btnRemind;
@property (nonatomic, weak) IBOutlet UIBarButtonItem * barBtnNext;

@property (nonatomic, weak) IBOutlet UIView * sectionView;
@property (nonatomic, weak) IBOutlet UICollectionView * contactsView;
@property (nonatomic, weak) IBOutlet UICollectionView * worksView;

@property (nonatomic) enum ProjectViewState viewState;
//@property (nonatomic, retain) Project *project;

@end


