//
//  Storage.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/26/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Storage.h"
#import "AppUtils.h"
#import "DataLoader.h"
#import "CertifiedNursingAssistantsViewController.h"
#import "AvailableJobsViewController.h"
#import "StringEncrypt.h"

@implementation Storage

+(void)setDefaultSearchSettings
{
    [Storage setSearchSettingsMinExperience:0];
    [Storage setSearchSettingsMaxExperience:20];
    [Storage setSearchSettingsMinPriceRange:15];
    [Storage setSearchSettingsMaxPriceRange:120];
    [Storage setSearchSettingsLocation:0];
    [Storage setSearchSettingsAvalability:0];
    [Storage setSearchSettingsSearchString:@""];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:YES forKey:@"defaultsWereSet"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+(void)setDidHireUser:(NSString*)username
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:username forKey:@"didHireUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString*)getHiredUser
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults stringForKey:@"didHireUser"];
}


+(BOOL)defaultsWereSet
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"defaultsWereSet"];
}


+(void)setSearchSettingsSearchString:(NSString*)searchString
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:searchString forKey:@"searchSettingsSearchString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getSearchSettingsSearchString
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults stringForKey:@"searchSettingsSearchString"];
}


+(void)setSearchSettingsMinExperience:(NSInteger)experience
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:experience forKey:@"searchSettingsMinExperience"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)getSearchSettingsMinExperience
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"searchSettingsMinExperience"];
}

+(void)setSearchSettingsMaxExperience:(NSInteger)experience
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:experience forKey:@"searchSettingsMaxExperience"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+(NSInteger)getSearchSettingsMaxExperience
{
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"searchSettingsMaxExperience"];
}


+(void)setSearchSettingsMinPriceRange:(NSInteger)minPriceRange
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:minPriceRange forKey:@"searchSettingsMinPriceRange"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)getSearchSettingsMinPriceRange
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"searchSettingsMinPriceRange"];
}


+(void)setSearchSettingsMaxPriceRange:(NSInteger)maxPriceRange
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:maxPriceRange forKey:@"searchSettingsMaxPriceRange"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(NSInteger)getSearchSettingsMaxPriceRange
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"searchSettingsMaxPriceRange"];
}


+(void)setSearchSettingsLocation:(NSInteger)type
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:type forKey:@"searchSettingsLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)getSearchSettingsLocation
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"searchSettingsLocation"];
}

+(void)setSearchSettingsAvalability:(NSInteger)type
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:type forKey:@"searchSettingsAvalability"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)getSearchSettingsAvalability
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"searchSettingsAvalability"];
}

+(void)setNewMessagesCount:(NSInteger)count
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:count forKey:@"newMessagesCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UIApplication sharedApplication].applicationIconBadgeNumber = [Storage getApplicationsPushesCount] + [Storage getNewMessagesCount];

}

+(NSInteger)getNewMessagesCount;
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"newMessagesCount"];
}



+(void)setUserLogin:(NSString*)isActive
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:isActive forKey:@"userLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getUserLogin
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults stringForKey:@"userLogin"];
}

+(void)setPriority:(NSString*)priority
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:[StringEncrypt encryptString:priority withKey:API_KEY] forKey:@"priority"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getPriority
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    if ([AppUtils isValidObject:[userdefaults stringForKey:@"priority"]]) {
        return [StringEncrypt decryptString:[userdefaults stringForKey:@"priority"] withKey:API_KEY];
    }
    
    return nil;
}

+(void)setWasErrorOnSubscription:(BOOL)priority
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:priority forKey:@"wasErrorOnSubscription"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)wasErrorOnSubscription
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults boolForKey:@"wasErrorOnSubscription"];
}

+(void)setApplicationsPushesCount:(NSInteger)count
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:count forKey:@"applicationsPushesCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [Storage getApplicationsPushesCount] + [Storage getNewMessagesCount];
    BaseViewController * controller = (BaseViewController*)[AppUtils topViewController];
    if ([controller isKindOfClass:[CertifiedNursingAssistantsViewController class]] ||
        [controller isKindOfClass:[AvailableJobsViewController class]]
        )
    {
        [controller addRightButton];
    }

}

+(NSInteger)getApplicationsPushesCount
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults integerForKey:@"applicationsPushesCount"];
}



+(void)setDidPurchase:(BOOL)didPurchase
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:didPurchase forKey:@"DidPurchase"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)getDidPurchase
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults boolForKey:@"DidPurchase"];
}

+(void)setIsTrial:(BOOL)isTrial
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:isTrial forKey:@"IsTrial"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)getIsTrial
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults boolForKey:@"IsTrial"];
}


@end
