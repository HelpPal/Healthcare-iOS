//
//  AppDelegate.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstants.h"
#import "AppUtils.h"
#import "Storage.h"
#import "DataLoader.h"

#include "TargetConditionals.h"
#import <UserNotifications/UserNotifications.h>
#import "UserMessagesViewController.h"
#import "MessagesViewController.h"
#import "AGPushNoteView.h"
#import "ApplicationsViewController.h"
#import "CertifiedNursingAssistantsViewController.h"
#import "AvailableJobsViewController.h"


@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([Storage defaultsWereSet] == NO)
    {
        [Storage setDefaultSearchSettings];
    }
    
    
    if (launchOptions) { //launchOptions is not nil
        NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
        
        if (apsInfo) { //apsInfo is not nil
            
            [apsInfo enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSDictionary* pushBody, BOOL * _Nonnull stop) {
                int notificationType = [pushBody[@"info"][@"type"] intValue];
                int applicationsPushesCount = 0;
                if (notificationType == 2) {
                    applicationsPushesCount ++;
                }
                
                if (stop) {
                    [Storage setApplicationsPushesCount:applicationsPushesCount];
                }
            }];
        }
    }
    
    
    [AppUtils setApplicationAppearence];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)registerForRemoteNotificationsWithUserId:(NSString *)userId {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            
        }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}


//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    int notificationType = [userInfo[@"aps"][@"info"][@"type"] intValue];
    switch (notificationType) {
            
        case 0:
        {
            completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
             NSInteger applicationsPushesCount = [Storage getApplicationsPushesCount];
            [Storage setApplicationsPushesCount:applicationsPushesCount];
        }
            break;
            
        case 1:
        {
            if ([[AppUtils topViewController] isKindOfClass:[UserMessagesViewController class]] )
            {
                UserMessagesViewController *messages = (UserMessagesViewController*)[AppUtils topViewController];
                [messages loadItems];
                
            }
            
            else if ([[AppUtils topViewController] isKindOfClass:[MessagesViewController class]] )
            {
                MessagesViewController *messages = (MessagesViewController*)[AppUtils topViewController];
                [messages loadItems];
                
            }
            else
            {
                completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
            }
        }
            break;
            
        case 2:
        {
            
            NSInteger applicationsPushesCount = [Storage getApplicationsPushesCount];
            [Storage setApplicationsPushesCount:applicationsPushesCount + 1];
            completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
        }
            
        
            break;
            
    }
    
    
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    [self openViewControllerForNotificationDictionary:response.notification.request.content.userInfo];
    completionHandler();
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    if ( application.applicationState == UIApplicationStateInactive
        || application.applicationState == UIApplicationStateBackground  ) {
        
        [self openViewControllerForNotificationDictionary:userInfo];
        
    }
    
    else
    {
        
        int notificationType = [userInfo[@"aps"][@"info"][@"type"] intValue];
        if (notificationType == 2) {
            NSInteger applicationsPushesCount = [Storage getApplicationsPushesCount];
            [Storage setApplicationsPushesCount:applicationsPushesCount + 1];
            
        }
        
        
        switch (notificationType) {
            case 0:
            {
                // daca oferta ta e aceptata
                [AGPushNoteView showWithNotificationMessage:userInfo[@"aps"][@"info"][@"push"]];
            }
                break;
            case 1:
            {
                if ([[AppUtils topViewController] isKindOfClass:[MessagesViewController class]] )
                {
                    MessagesViewController *messages = (MessagesViewController*)[AppUtils topViewController];
                    [messages loadItems];
                    
                }
                else if ([[AppUtils topViewController] isKindOfClass:[UserMessagesViewController class]] == NO)
                {
                    User * fromUser = [[User new] initWithDictionary:userInfo[@"aps"][@"info"][@"fromUser"]];
                    [AGPushNoteView showWithNotificationMessage:[NSString stringWithFormat:@"%@ : %@",fromUser.fullName, userInfo[@"aps"][@"info"][@"message"]]];
                    
                    [AGPushNoteView setMessageAction:^(NSString *message) {
                        [self openMessages:userInfo];
                    }];
                }
                
                
                
                else
                {
                    
                }
                
                
            }
                break;
                
            case 2:
            {
                // daca oferta ta e aceptata
                
                User * fromUser = [[User new] initWithDictionary:userInfo[@"aps"][@"info"][@"fromUser"]];
                [AGPushNoteView showWithNotificationMessage:[NSString stringWithFormat:@"%@ : %@",fromUser.fullName, userInfo[@"aps"][@"info"][@"message"]]];
                
                [AGPushNoteView setMessageAction:^(NSString *message) {
                    [self openApplications:userInfo];
                }];
            }
                break;
                
            
        }
    }
}


-(void)openMessages:(NSDictionary*)notification
{
    
    if ([[AppUtils topViewController] isKindOfClass:[UserMessagesViewController class]] == NO)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:[NSBundle mainBundle]];
        UserMessagesViewController *conversation = [storyboard instantiateViewControllerWithIdentifier:@"UserMessagesViewController"];
        User * fromUser = [[User new] initWithDictionary:notification[@"aps"][@"info"][@"fromUser"]];
        MessageListItem * item = [MessageListItem new];
        item.user = self.currentViewController.user.userId;
        item.partner = fromUser.userId;
        item.partnerName = [fromUser fullName];
        conversation.listItem = item;
        conversation.user = self.currentViewController.user;
        [self.currentViewController.navigationController pushViewController:conversation animated:YES];
    }
    
    else
    {
        UserMessagesViewController * messages = (UserMessagesViewController*)[AppUtils topViewController];
        [messages loadItems];
        
    }
}


-(void)openApplications:(NSDictionary*)notification
{
    
    
    if ([[AppUtils topViewController] isKindOfClass:[ApplicationsViewController class]] == NO)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:[NSBundle mainBundle]];
        UserMessagesViewController *applications = [storyboard instantiateViewControllerWithIdentifier:@"ApplicationsViewController"];
        applications.user = self.currentViewController.user;
        [self.currentViewController.navigationController pushViewController:applications animated:YES];
    }
    
    else
    {
        [[AppUtils topViewController] viewWillAppear:YES];
    }
    
}

-(void)openViewControllerForNotificationDictionary:(NSDictionary*)notification
{
    int notificationType = [notification[@"aps"][@"info"][@"type"] intValue];
    
    switch (notificationType) {
        case 1:
        {
            [self openMessages:notification];
        }
            
            break;
            
            
        case 2:
        {
            [self openApplications:notification];
        }
            
            break;
    }
    
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSString *tokenString = [[[deviceToken description]
                              stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                             stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([AppUtils isValidString:tokenString] )
    {
        [DataLoader sendPush:tokenString fromUser:self.currentViewController.user.userId success:^(id responseObject) {
            
        } fail:^(NSError *error) {
            
        }];
    }
    
}



@end
