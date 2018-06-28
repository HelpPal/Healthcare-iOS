//
//  Job.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Job.h"
#import "Skill.h"
#import "Location.h"
#import "Day.h"

@implementation Job
- (instancetype)init
{
    self = [super init];
    if (self) {
        _jobId = @"";
        _title = @"";
        _lat = @(-1);
        _longitude = @(-1);
        _hours = @(1);
        _min_price = @"";
        _max_price = @"";
        
        _information = @"";
        _date = @"";
        _userRating = 0;
        _byUser = @"";
        _days = [NSMutableArray new];
        _time_desc = @"";
        _distance = @(-1);
        _location = [Location new];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _jobId = dict[@"id"];
        _title = dict[@"title"];
        _lat = dict[@"lat"];
        _longitude = dict[@"longitude"];
        _hours = dict[@"hours"];
        _min_price = dict[@"min_price"];
        _max_price = dict[@"max_price"];
        _repate = [dict[@"repate"] boolValue];
        _avalable = [dict[@"avalable"] intValue];
        _information = dict[@"information"];
        _date = dict[@"date"];
        _hidden = [dict[@"hidden"] boolValue];
        _byUser = dict[@"byUser"];
        _myRating = [dict[@"myRating"] floatValue];
        _userRating = [dict[@"userRating"] floatValue];
        NSArray * daysArray =  dict[@"days"];;
        
        for (NSDictionary *dict in daysArray) {
            Day *day = [[Day new] initWithDictionary:dict];
            [_days addObject:day];
        }
        _time_desc = dict[@"time_desc"];
        _distance = dict[@"distance"];
        _location = [[Location new] initWithDictionary:dict[@"location"]];
    }
    return self;
}




@end
