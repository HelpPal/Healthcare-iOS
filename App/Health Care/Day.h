//
//  Day.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Day :  NSObject

@property (nonatomic , strong) NSNumber * dayId;
@property (nonatomic , strong) NSNumber * day;
@property (nonatomic , strong) NSNumber * jobId;


-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
