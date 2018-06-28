//
//  Application.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Application :  NSObject

@property (nonatomic , strong) NSNumber * appId;
@property (nonatomic , strong) NSString * userId;
@property (nonatomic , strong) NSString * fromUser;
@property (nonatomic , strong) NSNumber * jobId;
@property (nonatomic , strong) NSNumber * type;
@property (nonatomic , assign) int  result;
@property (nonatomic , strong) NSString * date;
@property (nonatomic, assign)  BOOL hidden;

-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
