//
//  AppUtils.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/6/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AppUtils.h"
#import "AppConstants.h"

@implementation AppUtils


+(BOOL)isUserSubscribed
{
    
    return [Storage getDidPurchase] || [Storage getIsTrial];
}


+ (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}


+(BOOL) isEmailValid:(NSString *)checkString
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}


+(void)setApplicationAppearence
{
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-button-image"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-button-image"]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [AppUtils buttonBlueColor],                                                                                                                      NSFontAttributeName: [UIFont fontWithName:_lato_font_regular size:18.0],
                                                           }];
    
    
    
}


+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+(BOOL)isValidObject:(id)object
{
    return (object != nil && [object isKindOfClass:[NSNull class]] == NO);

}

+(BOOL)isValidString:(NSString*)object
{
    
    if ([AppUtils isValidObject:object] && [object isKindOfClass:[NSString class]])
    {
        return  YES;
    }
    
    return NO;
    
}

+(NSString*)validateString:(NSString*)object
{
    
    if ([AppUtils isValidObject:object])
    {
        return  object;
    }
    
    return @"";
    
}

+(NSArray*)experienceArray
{

    return @[@"Less than 1 year",
             @"2-5 years",
             @"5-7 years",
             @"7-10 years",
             @"10-15 years",
             @"15-20 years",
             @"More than 20 years"];
}

+(UIColor*)placeholdersColor
{
    
    return [UIColor colorWithRed:149.0/255.0
                           green:195.0/255.0
                            blue:253.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)inputFieldTextColor
{
    return [UIColor colorWithRed:27.0/255.0
                           green:138.0/255.0
                            blue:250.0/255.0
                           alpha:255.0/255.0];
    
}



+(UIColor*)separatorsColor
{
    return [UIColor colorWithRed:225.0/255.0
                           green:239.0/255.0
                            blue:250.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)grayTextColor
{
    return [UIColor colorWithRed:149.0/255.0
                           green:152.0/255.0
                            blue:154.0/255.0
                           alpha:255.0/255.0];

}


+(UIColor*)lightBlueColor
{
    return [UIColor colorWithRed:248.0/255.0
                           green:251.0/255.0
                            blue:254.0/255.0
                           alpha:255.0/255.0];
    
}


+(UIColor*)priceGreenColor
{
    return [UIColor colorWithRed:37.0/255.0
                           green:177.0/255.0
                            blue:118.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)spinerColor
{
    return [UIColor colorWithRed:0.11 green:0.51 blue:0.908 alpha:1.0];
    
    
}


+(UIColor*)buttonBlueColor
{
    return [UIColor colorWithRed:27.0/255.0
                           green:130.0/255.0
                            blue:250.0/255.0
                           alpha:255.0/255.0];

    
}

+(UIColor*)buttonRedTextColor
{
    return [UIColor colorWithRed:255.0/255.0
                           green:98.0/255.0
                            blue:98.0/255.0
                           alpha:255.0/255.0];
    
    
}

+(BOOL)isIphoneVersion:(int)iPhoneVersion
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480 && iPhoneVersion == 4)
        {
            return YES;
        }
        if(result.height == 568 && iPhoneVersion == 5)
        {
            return YES;
        }
    }
    return NO;
}
@end
