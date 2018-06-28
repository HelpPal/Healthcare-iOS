//
//  Location.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Location.h"
#import "AppUtils.h"
#import <objc/runtime.h>

@implementation Location


- (instancetype)init
{
    self = [super init];
    if (self) {
        _state = @"";
        _country = @"";
        _address = @"";
        _city = @"";
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    if ([AppUtils isValidObject:dict] == NO) {
        self = [self init];
        return self;
    }
    self = [super init];
    if (self) {
        _state = [AppUtils validateString:dict[@"state"]];
        _country = [AppUtils validateString:dict[@"country"]];
        _address = [AppUtils validateString:dict[@"address"]];
        _city = [AppUtils validateString:dict[@"city"]];
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
        if (value)
            [dictionary setObject:value forKey:key];
    }
    
    free(properties);
    
    return dictionary;
}
@end
