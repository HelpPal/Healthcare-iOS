//
//  Job.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "Location.h"
#import "Day.h"

@interface Job :  NSObject

@property (nonatomic , retain) NSString *jobId;
@property (nonatomic , retain) NSString *title;
@property (nonatomic , retain) NSNumber *lat;
@property (nonatomic , retain) NSNumber *longitude;
@property (nonatomic , retain) NSNumber *hours;
@property (nonatomic , retain) NSString *min_price;
@property (nonatomic , retain) NSString *max_price;
@property (nonatomic , assign) BOOL repate;
@property (nonatomic , assign) AvailableTime avalable;
@property (nonatomic , retain) NSString *information;
@property (nonatomic , retain) NSString *date;
@property (nonatomic , assign) BOOL hidden;
@property (nonatomic , retain) NSString *byUser;
@property (nonatomic , retain) NSMutableArray  *days;
@property (nonatomic , retain) NSString *time_desc;
@property (nonatomic , retain) NSNumber *distance;
@property (nonatomic , retain) Location *location;
@property  float userRating;
@property  float myRating;
@property (nonatomic , assign) NSInteger fromPage;

-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
