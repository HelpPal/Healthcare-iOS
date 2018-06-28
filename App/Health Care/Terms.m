//
//  Terms.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Terms.h"

@implementation Terms


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
        _infoText = dict[@"response"];
    }
    return self;
}



@end
