//
//  AppUtils.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/6/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Storage.h"

@interface AppUtils : NSObject
+(BOOL) isEmailValid:(NSString *)checkString;
+(UIColor*)placeholdersColor;
+(UIColor*)inputFieldTextColor;
+(UIColor*)separatorsColor;
+(UIColor*)grayTextColor;
+(UIColor*)lightBlueColor;
+(UIColor*)priceGreenColor;
+(UIColor*)spinerColor;
+(UIColor*)buttonBlueColor;
+(UIColor*)buttonRedTextColor;
+(void)setApplicationAppearence;
+ (UIViewController*)topViewController;
+(NSArray*)experienceArray;

+(BOOL)isValidObject:(id)object;
+(BOOL)isValidString:(NSString*)object;
+(NSString*)validateString:(NSString*)object;
+(BOOL)isIphoneVersion:(int)iPhoneVersion;
+(BOOL)validatePhone:(NSString *)phoneNumber;

+(BOOL)isUserSubscribed;
@end
