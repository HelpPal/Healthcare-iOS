//
//  ApplicationItem.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Job.h"
#import "Application.h"
#import "User.h"

@interface ApplicationItem :  NSObject

@property (nonatomic , assign) ApplicationsState type;
@property (nonatomic , strong) Job *job;
@property (nonatomic , strong) Application *application;
@property (nonatomic , strong) User* user;

@property (nonatomic , assign) NSInteger fromPage;
@property (nonatomic , retain) NSString *offerType;
@property (nonatomic, assign) BOOL deleted;
-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
