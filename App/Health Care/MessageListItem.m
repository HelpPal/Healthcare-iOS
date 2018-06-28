//
//  MessageListItem.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MessageListItem.h"

@implementation MessageListItem


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
        _itemId = dict[@"id"];
        _user = dict[@"user"];
        _partner = dict[@"partner"];
        _partnerName = dict[@"parner-name"];
        _lastMessage = [[Message new] initWithDictionary:dict[@"last_message"]];
    }
    return self;
}



@end
