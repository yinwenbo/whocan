//
//  WHCHttpAPIDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHCHttpAPI.h"
#import "WHCJsonAPIDelegate.h"

#import "ClientInfo.h"

#import "MBProgressHUD.h"
#import "NSDictionary+Getter.h"

@interface WHCJsonAPI : WHCHttpAPI <WHCHttpAPIDelegate>

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * msg;
@property (nonatomic, retain) NSObject * data;
@property (nonatomic) BOOL hasException;

+ (NSMutableDictionary *)createParameter;

- (id)initWithJsonDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCJsonAPIDelegate>)delegate;

- (NSArray *)getArrayData;
- (NSDictionary *)getDictionaryData;

- (BOOL)isAccessRefuse;

- (void)successJsonResult;
- (void)showAlert:(NSString*)message;

- (void)processAccessRefuse;
- (void)showSignInView:(UIViewController*)view;

@end
