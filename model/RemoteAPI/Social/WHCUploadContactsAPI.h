//
//  WHCUploadContactsAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

@interface WHCUploadContactsAPI : WHCJsonAPI

+ (WHCUploadContactsAPI*) getInstance:(id<WHCJsonAPIDelegate>)delegate;

@end
