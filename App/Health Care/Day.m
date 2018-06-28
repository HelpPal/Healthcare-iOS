//
//  Day.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Day.h"

@implementation Day
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dayId = @(-1);
        _jobId = @(-1);
        _day = @(-1);
    }
    return self;
}


-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _jobId = dict[@"job_id"];
        _dayId = dict[@"id"];
        _day = dict[@"day"];
    }
    return self;
}


@end
