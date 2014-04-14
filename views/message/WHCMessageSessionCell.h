//
//  WHCMessageSessionCell.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-14.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "TDBadgedCell.h"

@interface WHCMessageSessionCell : TDBadgedCell

@property (nonatomic, retain) IBOutlet UILabel * title;
@property (nonatomic, retain) IBOutlet UILabel * detail;
@property (nonatomic, retain) IBOutlet UIImageView * icon;

@end
