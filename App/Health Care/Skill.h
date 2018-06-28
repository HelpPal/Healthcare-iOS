//
//  Skill.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Skill :  NSObject

@property (nonatomic , strong) NSNumber * skillId;
@property (nonatomic , strong) NSString * name;
@property (assign, nonatomic) BOOL isOtherSkill;

-(instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
