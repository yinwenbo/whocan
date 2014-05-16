//
//  whocanTests.m
//  whocanTests
//
//  Created by Yin Wenbo on 14-2-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface whocanTests : XCTestCase

@end

@implementation whocanTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:@"1" forKey:@"groupId"];
    HttpJsonAPI * api = [[HttpJsonAPI alloc] initWithParams:params url:api_tasklist_find_by_group_id];
    [api startSynchronize];

//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
