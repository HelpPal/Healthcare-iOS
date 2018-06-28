//
//  Location.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location :  NSObject

@property (nonatomic , retain) NSString *state;
@property (nonatomic , retain) NSString *country;
@property (nonatomic , retain) NSString *address;
@property (nonatomic , retain) NSString *city;

-(instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary *)dictionaryRepresentation;
@end
