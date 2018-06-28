//
//  Storage.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/26/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Storage : NSObject
+(void)setDefaultSearchSettings;
+(BOOL)defaultsWereSet;
+(void)setSearchSettingsSearchString:(NSString*)searchString;
+(NSString*)getSearchSettingsSearchString;
+(void)setDidHireUser:(NSString*)didHire;
+(NSString*)getHiredUser;
+(void)setSearchSettingsMinExperience:(NSInteger)experience;
+(NSInteger)getSearchSettingsMinExperience;
+(void)setSearchSettingsMaxExperience:(NSInteger)experience;
+(NSInteger)getSearchSettingsMaxExperience;
+(void)setSearchSettingsMinPriceRange:(NSInteger)minPriceRange;
+(NSInteger)getSearchSettingsMinPriceRange;
+(void)setSearchSettingsMaxPriceRange:(NSInteger)maxPriceRange;
+(NSInteger)getSearchSettingsMaxPriceRange;
+(void)setSearchSettingsLocation:(NSInteger)type;
+(NSInteger)getSearchSettingsLocation;
+(void)setSearchSettingsAvalability:(NSInteger)type;
+(NSInteger)getSearchSettingsAvalability;
+(void)setNewMessagesCount:(NSInteger)type;
+(NSInteger)getNewMessagesCount;

+(void)setUserLogin:(NSString*)isActive;
+(NSString*)getUserLogin;
+(void)setPriority:(NSString*)isActive;
+(NSString*)getPriority;
+(void)setWasErrorOnSubscription:(BOOL)priority;
+(BOOL)wasErrorOnSubscription;
+(void)setApplicationsPushesCount:(NSInteger)count;
+(NSInteger)getApplicationsPushesCount;


+(void)setDidPurchase:(BOOL)didPurchase;
+(BOOL)getDidPurchase;
+(void)setIsTrial:(BOOL)isTrial;
+(BOOL)getIsTrial;



@end
