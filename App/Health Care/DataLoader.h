//
//  DataLoader.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Skill.h"
#import "User.h"
#import "ApplicationItem.h"



#define BASE_URL @"http://104.131.152.91/health-care/ios/"
#define API_KEY @"DA8B9B217DE9E123"
#define IMAGES_URL @"http://104.131.152.91/health-care/"



typedef void (^SuccessRH) (id responseObject);
typedef void (^FailRH) (NSError *error);




@interface DataLoader : NSObject


+(NSString*)encrypt:(NSDictionary*)parameters;
+(void)alertUserForError:(NSError*)error;
+(void)getSkillsTermsUserID:(NSString *)userID succes:(SuccessRH)success fail:(FailRH)fail;
+(void)getTermsText:(SuccessRH)success
               fail:(FailRH)fail;

+(void)loginWithUserName:(NSString*)username
             andPassword:(NSString*)password
                 success:(SuccessRH)success
                    fail:(FailRH)fail;

+(void)getUserMessagesCount:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail;

+(void)recoverUserPasswordForEmail:(NSString*)email success:(SuccessRH)success fail:(FailRH)fail;
+(void)registerOrEditUser:(User*)user withPassword:(NSString*)password andUserPhoto:(UIImage*)userPhoto isEditing:(BOOL)isEditing success:(SuccessRH)success fail:(FailRH)fail;
+(void)setAvailableUser:(User*)user available:(NSNumber*)available success:(SuccessRH)success fail:(FailRH)fail;
+(void)getAvailableJobsForUser:(User*)user searchString:(NSString*)searchString forPage:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail;
+(void)getUserMessageList:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail;
+(void)getUserConversation:(NSString*)userId  withPartner:(NSString*)partnerId success:(SuccessRH)success fail:(FailRH)fail;
+(void)sendMessageFromUser:(NSString*)userId  toPartner:(NSString*)partnerId text:(NSString*)text success:(SuccessRH)success fail:(FailRH)fail;
+(void)deleteConversationUser:(NSString*)userId  withPartner:(NSString*)partnerId success:(SuccessRH)success fail:(FailRH)fail;
+(void)deleteApplication:(ApplicationItem*)applicationItem success:(SuccessRH)success fail:(FailRH)fail;
+(void)getApplicationsForUser:(NSString*)userId page:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail;
+(void)reportJobFromUser:(NSString*)userId jobId:(NSString*)jobId success:(SuccessRH)success fail:(FailRH)fail;
+(void)getApplicationsForProfesionalUser:(NSString*)userId page:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail;
+(void)reportUserFromUser:(NSString*)userId reportedUserId:(NSString*)reportedUserId success:(SuccessRH)success fail:(FailRH)fail;
+(void)getMyJobs:(NSString*)userId forPage:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail;
+(void)addJobEdit:(Job*)job withMyUserId:(NSString*)userId isEditing:(BOOL)isEditing isPrivate:(BOOL)isPrivate  success:(SuccessRH)success fail:(FailRH)fail;
+(void)sendJobTouser:(NSString*)userId byUser:(NSString*)byUser jobId:(NSString*)jobId invite:(BOOL)invite success:(SuccessRH)success fail:(FailRH)fail;
+(void)sendOfferTouser:(NSString*)userId byUser:(NSString*)byUser job:(Job*)job invite:(BOOL)invite success:(SuccessRH)success fail:(FailRH)fail;
+(void)acceptApplication:(NSString*)userId applicationId:(NSNumber*)applicationId success:(SuccessRH)success fail:(FailRH)fail;
+(void)refuseApplication:(NSString*)userId applicationId:(NSNumber*)applicationId success:(SuccessRH)success fail:(FailRH)fail;
+(void)individualUserProfile:(NSString*)userId myuserid:(NSString*)myuserid success:(SuccessRH)success fail:(FailRH)fail;
+(void)getCertifiedNursingAssistantsList:(User*)user searchString:(NSString*)searchString forPage:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail;
+(void)deleteUserJob:(NSString*)userId withJobId:(NSString*)jobId  success:(SuccessRH)success fail:(FailRH)fail;
+(void)deletePush:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail;
+(void)sendPush:(NSString*)pushString fromUser:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail;
+(void)changeUserPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword forUser:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail;
+(void)userCanApplyToJob:(NSString*)userId jobId:(NSString*)jobId  success:(SuccessRH)success fail:(FailRH)fail;
+(void)checkEmail:(NSString*)email  success:(SuccessRH)success fail:(FailRH)fail;
+(void)sendUserDidSubscribe:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail;
+(void)checIfUserIsSubscribed:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail;
+(void)rateUser:(NSString*)toUser userID:(NSString*)userID  type:(NSString*)type rating:(float)rating success:(SuccessRH)success fail:(FailRH)fail;
@end
