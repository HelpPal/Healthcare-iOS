//
//  ApplicationItem.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ApplicationItem.h"

@implementation ApplicationItem



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
        _type = [dict[@"type"] intValue];
        _job = [[Job new] initWithDictionary:dict[@"job"]];
        _application = [[Application new] initWithDictionary:dict[@"application"]];
        _user = [[User new] initWithDictionary:dict[@"user"]];
        _offerType = dict[@"offerType"];
    }
    return self;
}


@end
