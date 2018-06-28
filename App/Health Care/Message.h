//
//  Message.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message :  NSObject


@property (nonatomic , strong) NSNumber *messageId;
@property (nonatomic , strong) NSString *user;
@property (nonatomic , strong) NSNumber *toUser;
@property (nonatomic , strong) NSString *text;
@property (nonatomic , strong) NSString *time;
@property (nonatomic , assign) NSInteger unreadMessagesCount;
-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
