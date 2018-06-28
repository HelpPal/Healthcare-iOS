//
//  Message.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Message.h"
#import "AppUtils.h"
@implementation Message

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
        _messageId = dict[@"id"];
        _user = dict[@"user"];
        _toUser = dict[@"toUser"];
        _text = dict[@"text"];
        _time = dict[@"time"];
        _unreadMessagesCount = [[AppUtils validateString:dict[@"new"]] integerValue];
    }
    return self;
}


@end
