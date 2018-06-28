//
//  User.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "User.h"
#import "Skill.h"
#import "Location.h"
#import "AppUtils.h"
#import <objc/runtime.h>

@implementation User

- (instancetype)init
{
    self = [super init];
    if (self) {
        _skills = [NSMutableArray new];
        _otherSkills = [NSMutableArray new];
        _location = [Location new];
        _userId = @"";
        _address_lat = @(-1);
        _address_long = @(-1);
        _android_push = @"";
        _available = NO;
        _available_time = _fullTime;
        _birthday = @"";
        _distance = @(-1);
        _email = @"";
        _experience = @(0);
        _first_name = @"";
        _gender = _female;
        _ios_push = @"";
        _last_name = @"";
        _phone = @"";
        _price_max = @"";
        _price_min = @"";
        _profile_img = @"";
        _type = _individual;
        _userDescriptionDetails = @"";
        _years = @(-1);
        _zipCode = @"";
        _userRating = 0.0f;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _userId = dict[@"id"];
        _email = dict[@"email"];
        _type = [dict[@"type"] intValue];
        _last_name = dict[@"last_name"];
        _first_name = dict[@"first_name"];
        _address_lat = dict[@"address_lat"];
        _address_long = dict[@"address_long"];
        _experience = dict[@"experience"];
        _available_time = [dict[@"available_time"] intValue];
        _price_min = dict[@"price_min"];
        _price_max = dict[@"price_max"];
        _phone = dict[@"phone"];
        _birthday =[AppUtils validateString:dict[@"birthday"]];
        _userDescriptionDetails =[AppUtils validateString:dict[@"description"]];
        _profile_img = [AppUtils validateString:dict[@"profile_img"]];
        _gender = [dict[@"gender"] intValue];
        _available = [dict[@"available"] boolValue];
        _android_push = [AppUtils validateString:dict[@"android_push"]];
        _ios_push = [AppUtils validateString:dict[@"ios_push"]];
        _userRating =  [dict[@"userRating"] floatValue];
      _myRating =  [dict[@"myRating"] floatValue];
        if([[dict allKeys] containsObject:@"zipCode"]){
        _zipCode = dict[@"zipCode"];
        } else {
             _zipCode = dict[@"zip"];
        }
        NSArray * skillsArray = dict[@"skills"];
        
        for (NSDictionary *dict in skillsArray) {
            Skill *skill = [[Skill new] initWithDictionary:dict];
            [_skills addObject:skill];
        }
        _location = [[Location new] initWithDictionary:dict[@"location"]];
        _years = dict[@"years"];
        _distance = dict[@"distance"];
        
        _fullName = [_first_name stringByAppendingFormat:@" %@",_last_name];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    unsigned int count = 0;
    // Get a list of all properties in the class.
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *value = [self valueForKey:key];
        
        // Only add to the NSDictionary if it's not nil.
        if ([value isKindOfClass:[Location class]])
        {
            Location * location = (Location*)value;
            [dictionary setObject:[location dictionaryRepresentation] forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSMutableArray * array = [NSMutableArray new];
            NSArray * valuesArray = (NSArray*)value;
            
            for (Skill * skill in valuesArray) {
                [array addObject:[skill dictionaryRepresentation]];
            }
            
            [dictionary setObject:array forKey:key];
        }
        else if (value)
            [dictionary setObject:value forKey:key];
    }
    
    free(properties);
    dictionary[@"id"] = dictionary[@"userId"];
    [dictionary removeObjectForKey:@"userId"];
    dictionary[@"description"] = dictionary[@"userDescriptionDetails"];
    [dictionary removeObjectForKey:@"userDescriptionDetails"];
    return dictionary;
}
@end
