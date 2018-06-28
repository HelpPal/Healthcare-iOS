//
//  User.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "Location.h"

@interface User : NSObject

@property (nonatomic , retain) NSString *userId;
@property (nonatomic , retain) NSString *email;
@property (nonatomic , assign) ClientType type;
@property (nonatomic , retain) NSString *last_name;
@property (nonatomic , retain) NSString *first_name;
@property (nonatomic , retain) NSString *fullName;
@property (nonatomic , retain) NSNumber *address_lat;
@property (nonatomic , retain) NSNumber *address_long;
@property (nonatomic , retain) NSNumber *experience;
@property (nonatomic , assign) AvailableTime available_time;
@property (nonatomic , retain) NSString *price_min;
@property (nonatomic , retain) NSString *price_max;
@property (nonatomic , retain) NSString *phone;
@property (nonatomic , retain) NSString *birthday;
@property (nonatomic , retain) NSString *userDescriptionDetails;
@property (nonatomic , retain) NSString *profile_img;
@property (nonatomic , assign) Gender gender;
@property (nonatomic , assign) BOOL available;
@property (nonatomic , retain) NSString *android_push;
@property (nonatomic , retain) NSString *ios_push;
@property (nonatomic , strong) NSMutableArray *skills;
@property (nonatomic , strong) NSMutableArray *otherSkills;
@property (nonatomic , retain) Location *location;
@property (nonatomic , retain) NSNumber *years;
@property (nonatomic , retain) NSNumber *distance;
@property float userRating;
@property float myRating;
//update
@property (nonatomic , retain) NSString *zipCode;
//

@property (nonatomic , assign) NSInteger fromPage;


-(instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary *)dictionaryRepresentation ;
@end
