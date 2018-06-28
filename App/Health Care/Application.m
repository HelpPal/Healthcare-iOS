//
//  Application.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Application.h"

@implementation Application



- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _appId = dict[@"id"];
        _userId = dict[@"userid"];
        _fromUser = dict[@"fromUser"];
        _jobId = dict[@"job_id"];
        _type = dict[@"type"];
        _result = [dict[@"result"] intValue];
        _date = dict[@"date"];
        _hidden = [dict[@"hidden"] boolValue];
    }
    return self;
}


@end
