//
//  MessageListItem.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Message.h"

@interface MessageListItem : NSObject


@property (nonatomic , strong) NSString *itemId;
@property (nonatomic , strong) NSString *user;
@property (nonatomic , strong) NSString *partner;
@property (nonatomic , strong) NSString *partnerName;
@property (nonatomic , strong) Message *lastMessage;
@property (nonatomic , assign) BOOL isSelected;


-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
