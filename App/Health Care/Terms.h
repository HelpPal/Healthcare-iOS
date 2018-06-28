//
//  Terms.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Terms : NSObject
@property (nonatomic , retain) NSString * infoText;
-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
