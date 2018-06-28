//
//  DataLoader.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "DataLoader.h"
#import <AFHTTPSessionManager.h>
#import "StringEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import "HTTPClient.h"
#import "AppUtils.h"
#import "MessageListItem.h"
#import "Message.h"
#import "CheckInternetConnectionViewController.h"


@implementation DataLoader





+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


+(void)alertUserForError:(NSError*)error
{
    
    UIApplication * application = [UIApplication sharedApplication];
    if ( application.applicationState == UIApplicationStateInactive
        || application.applicationState == UIApplicationStateBackground  ) {
        
        return;
        
    }
    
    NSLog(@"\n\n\n%@\n\n\n",error);
    
    if ([error.domain isEqualToString:appErrorDomain]) {
        NSString *messageString = error.userInfo[@"message"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:messageString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
        
        [alert addAction:okButton];
        [[AppUtils topViewController] presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *messageString = error.localizedDescription;
        if ([[HTTPClient sharedHTTPClient] connected] == NO || [messageString isEqualToString:@"The network connection was lost."]) {
            
            if ([AppUtils topViewController] == [HTTPClient sharedHTTPClient].requestViewController) {
                [[AppUtils topViewController] presentViewController:[CheckInternetConnectionViewController new] animated:YES completion:^{
                    
                }];
            }
            
            
            return;
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Server error!" message:messageString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
        
        [alert addAction:okButton];
        [[AppUtils topViewController] presentViewController:alert animated:YES completion:nil];
    }
    
}

+(NSString*)encrypt:(NSDictionary*)parameters{
    NSString*key = API_KEY;
    NSMutableDictionary*dictionary = [parameters mutableCopy];
    
    [dictionary setObject:@"kasld1>!<123kml1" forKey:@"api_key"];
    
    NSString*responseString  = @"";
    for (NSString* key in dictionary) {
        id value = [dictionary objectForKey:key];
        
        if(responseString.length == 0)
        {
            
            responseString = [NSString stringWithFormat:@"%@|12:12|%@", key,value];
            
        } else {
            responseString = [NSString stringWithFormat:@"%@|,',|%@|12:12|%@",responseString, key,value];
            
        }
        
        
    }
    
    NSString*encryptString = [StringEncrypt encryptString:responseString withKey:key];
    return encryptString;
    
}


+(void)getSkillsTermsUserID:(NSString *)userID succes:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userID}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"skills.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            NSMutableArray * responseArray = [NSMutableArray new];
            for (NSDictionary* dict in responseObject[@"response"])
            {
                Skill *mapedObject = [[Skill new] initWithDictionary:dict];
                [responseArray addObject:mapedObject];
            }
            success(responseArray);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)getTermsText:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"terms.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else
        {
            success(responseObject[@"response"]);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)loginWithUserName:(NSString*)username andPassword:(NSString*)password success:(SuccessRH)success fail:(FailRH)fail
{
    
    NSString *encryptString = [self encrypt:@{@"username":username, @"password":[DataLoader md5:password]}];
    
    NSDictionary *dict = @{@"data":encryptString};
    
    [[HTTPClient sharedHTTPClient] POST:@"login.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            fail(error);
            [DataLoader alertUserForError:error];
        }
        else
        {
            [Storage setUserLogin:username];
            [Storage setPriority:password];
            User * user = [[User new] initWithDictionary:responseObject[@"response"]];
            success(user);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)getUserMessagesCount:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"newMess.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            success(responseObject[@"response"]);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}



+(void)rateUser:(NSString*)toUser userID:(NSString*)userID  type:(NSString*)type rating:(float)rating success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"toUser":toUser, @"rating":[NSString stringWithFormat:@"%.01f",rating], @"userid":userID, @"type":type}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"addRating.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            success(responseObject[@"response"]);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}



+(void)recoverUserPasswordForEmail:(NSString*)email success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"email":email}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"recover.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            success(responseObject[@"response"]);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}



+(void)registerOrEditUser:(User*)user withPassword:(NSString*)password andUserPhoto:(UIImage*)userPhoto isEditing:(BOOL)isEditing success:(SuccessRH)success fail:(FailRH)fail
{
    
    NSMutableArray * skillsIds = [NSMutableArray new];
    NSMutableArray * otherSkillsIds = [NSMutableArray new];
    
    
    [user.skills enumerateObjectsUsingBlock:^(Skill *skill, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(skill.isOtherSkill || skill.skillId.integerValue ==35) {
                [otherSkillsIds addObject:skill.name];
        } else {
        [skillsIds addObject:skill.skillId];
        }
    }];
    
    
    NSString * skills = [skillsIds componentsJoinedByString:@","];
    skills = skills.length ? skills : @"";
    NSLog(@"Skills strint %@", skills);
    //update
   
    
    
    NSString * otherSkills = [otherSkillsIds componentsJoinedByString:@","];
    otherSkills = otherSkills.length ? otherSkills : @"";
    //
    
    NSLog(@"Other skills strint %@", otherSkills);
    
    
    NSString*state = user.location.state;
    if(state.length == 0)
    {
        
        state = user.location.country;
    }
    NSMutableDictionary * dataDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"email":user.email,
                                                                                     @"type":@(user.type),
                                                                                     @"password":[DataLoader md5:[AppUtils validateString:password]],
                                                                                     @"first_name":user.first_name,
                                                                                     @"last_name":user.last_name,
                                                                                     @"lat":user.address_lat,
                                                                                     @"long":user.address_long,
                                                                               @"adress":user.location.address,
                                                                                       @"state":state,
                                                                                       @"city":user.location.city,
                                                                                         
                                                                                       @"zip":user.zipCode,
                                                                                     @"skills":skills,
                                                                                     @"other_skills":otherSkills,
                                                                                     @"experience":user.experience,
                                                                                     @"avalable":@(user.available),
                                                                                     @"price_min":user.price_min,
                                                                                     @"price_max":user.price_max,
                                                                                     @"phone":user.phone,
                                                                                     @"gender":@(user.gender),
                                                                                     @"description":user.userDescriptionDetails,
                                                                                     @"birthday":user.birthday,
                                                                                     @"profile_img":[AppUtils validateString:[UIImagePNGRepresentation(userPhoto) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]]}];
    
    
    
 
    
    
   
    
    if (isEditing) {
        dataDict[@"userid"] = [AppUtils validateString:user.userId];
    }
    
    NSString*encryptString = [DataLoader encrypt:dataDict];
    NSDictionary*dict = @{@"data":encryptString};
    
     NSString * urlString = isEditing ? @"editprofile.php" : @"register.php";
    
    [[HTTPClient sharedHTTPClient] POST:urlString parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length && ![errorString isEqualToString:@"Please fill 'birthday' field"]) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            User * user = [[User new] initWithDictionary:responseObject[@"response"]];
            [Storage setUserLogin:user.email];
            [Storage setPriority:password];
            success(user);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)setAvailableUser:(User*)user available:(NSNumber*)available success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"mess":available,@"userid":user.userId}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"setAvalable.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            success(responseObject[@"response"]);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}



+(void)getAvailableJobsForUser:(User*)user searchString:(NSString*)searchString forPage:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail
{
    
    NSDictionary * dictionary = @{@"skills":searchString,
                            @"min_price":@([Storage getSearchSettingsMinPriceRange]),
                            @"max_price":@([Storage getSearchSettingsMaxPriceRange]),
                            @"lat":user.address_lat,
                            @"long":user.address_long,
                            @"type":@([Storage getSearchSettingsLocation]),
                            @"avalable":@([Storage getSearchSettingsAvalability]),
                            @"nearMe":@([Storage getSearchSettingsLocation]),
                            @"page" : @(page),
                                  @"userid": user.userId
                          
                            };
    
    NSString*encryptString = [DataLoader encrypt:dictionary];
    
    
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"jobsfeed.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else {
            
            NSMutableArray * responseItems = [NSMutableArray new];
            
            for (NSDictionary *dict in responseObject[@"response"]) {
                Job * job = [[Job new] initWithDictionary:dict];
                job.fromPage = page;
                [responseItems addObject:job];
                
            }
            
            success(responseItems);
            
        }
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)getUserMessageList:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString *encryptString = [DataLoader encrypt:@{@"userid":userId}];
    NSDictionary *dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"messages.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            NSMutableArray * responseArray = [NSMutableArray new];
            if ([AppUtils isValidObject:responseObject[@"response"]]) {
                for (NSDictionary* dict in responseObject[@"response"])
                {
                    MessageListItem *mapedObject = [[MessageListItem new] initWithDictionary:dict];
                    [responseArray addObject:mapedObject];
                }
            }
            
            
            success(responseArray);
            
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)getUserConversation:(NSString*)userId  withPartner:(NSNumber*)partnerId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString *encryptString = [DataLoader encrypt:@{
                                                    @"userid":userId,
                                                    @"partnerid":partnerId
                                                    }];
    NSDictionary *dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"conversation.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            NSMutableArray * responseArray = [NSMutableArray new];
            if ([AppUtils isValidObject:responseObject[@"response"]]) {
                for (NSDictionary* dict in responseObject[@"response"])
                {
                    Message *mapedObject = [[Message new] initWithDictionary:dict];
                    [responseArray addObject:mapedObject];
                }
            }
            
            
            success(responseArray);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)sendMessageFromUser:(NSString*)userId  toPartner:(NSNumber*)partnerId text:(NSString*)text success:(SuccessRH)success fail:(FailRH)fail
{
    NSString *encryptString = [DataLoader encrypt:@{
                                                    @"user":userId,
                                                    @"toUser":partnerId,
                                                    @"text" : text
                                                    }];
    NSDictionary *dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"sendmessage.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            User * user = [[User new] initWithDictionary:responseObject[@"response"]];
            success(user);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
        
    }];
}


+(void)deleteConversationUser:(NSString*)userId  withPartner:(NSString*)partnerId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString *encryptString = [DataLoader encrypt:@{
                                                    @"userid":userId,
                                                    @"conversation_id":partnerId
                                                    
                                                    }];
    NSDictionary *dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"deleteconversation.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            success(responseObject[@"response"]);
            
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)deleteApplication:(ApplicationItem*)applicationItem success:(SuccessRH)success fail:(FailRH)fail
{
    NSString *encryptString = [DataLoader encrypt:@{
                                                    @"application_id":applicationItem.application.appId,
                                                    }];
    NSDictionary *dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"applicationRemove.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            applicationItem.deleted = YES;
            success(responseObject[@"response"]);
            
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)getApplicationsForUser:(NSString*)userId page:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,
                                                   @"page" : @(page)}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"applications.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            NSMutableArray * responseArray = [NSMutableArray new];
            if ([AppUtils isValidObject:responseObject[@"response"]]) {
                for (NSDictionary* dict in responseObject[@"response"])
                {
                    ApplicationItem *mapedObject = [[ApplicationItem new] initWithDictionary:dict];
                    mapedObject.fromPage = page;
                    [responseArray addObject:mapedObject];
                }
            }
            
            
            success(responseArray);
            
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)reportJobFromUser:(NSString*)userId jobId:(NSNumber*)jobId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"jobid":jobId,@"userid":userId}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"report.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else
        {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : @"Report sent"}];
            [DataLoader alertUserForError:error];
            success(responseObject[@"response"]);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)getApplicationsForProfesionalUser:(NSString*)userId page:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,
                                                   @"page" : @(page)}];
    
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"myapplications.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            NSMutableArray * responseArray = [NSMutableArray new];
            if ([AppUtils isValidObject:responseObject[@"response"]]) {
                for (NSDictionary* dict in responseObject[@"response"])
                {
                    ApplicationItem *mapedObject = [[ApplicationItem new] initWithDictionary:dict];
                    mapedObject.fromPage = page;
                    [responseArray addObject:mapedObject];
                }
            }
            
            
            success(responseArray);
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)reportUserFromUser:(NSString*)userId reportedUserId:(NSString*)reportedUserId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"reported":reportedUserId,@"userid":userId}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"reportUser.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : @"reportSent"}];
            [DataLoader alertUserForError:error];
            success(responseObject);
        }
        
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
        
    }];
}


+(void)getMyJobs:(NSString*)userId forPage:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,
                                                   @"page":@(page)
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"myjobs.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            NSMutableArray * responseArray = [NSMutableArray new];
            for (NSDictionary* dict in responseObject[@"response"])
            {
                Job *mapedObject = [[Job new] initWithDictionary:dict];
                mapedObject.fromPage= page;
                [responseArray addObject:mapedObject];
            }
            success(responseArray);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)addJobEdit:(Job*)job withMyUserId:(NSString*)userId isEditing:(BOOL)isEditing isPrivate:(BOOL)isPrivate  success:(SuccessRH)success fail:(FailRH)fail
{
    NSMutableArray * daysIds = [NSMutableArray new];
    
    [job.days enumerateObjectsUsingBlock:^(Day *day, NSUInteger idx, BOOL * _Nonnull stop) {
        [daysIds addObject:day.day];
    }];
    
    NSMutableArray * allDaysIds = [NSMutableArray new];
    for (int i = 0; i < 7; i++) {
        [allDaysIds addObject: [daysIds containsObject:@(i)] ? @(1) : @(0)] ;
    }
    
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid": [AppUtils isValidObject:userId] ? userId : [NSNull null],
                                                                                   @"title":job.title,
                                                                                   @"lat":job.lat,
                                                                                   @"long":job.longitude,
                                                                                   @"min_price":job.min_price,
                                                                                   @"max_price":job.max_price,
                                                                                   @"days":[allDaysIds componentsJoinedByString:@","],
                                                                                   @"repeate":@(job.repate),
                                                                                   @"hours":job.hours,
                                                                                   @"avalabil":@(job.avalable),
                                                                                   @"informations":job.information,
                                                                                   @"private": @(isPrivate)
                                                                                   }];
    
    if (isEditing)
    {
        params[@"id"] = job.jobId;
    }
    
     
    NSString*encryptString = [DataLoader encrypt:params];
    NSDictionary * dict = @{@"data":encryptString};
    
    NSString * linkString = isEditing ? @"editjob.php" : @"addjob.php";
    
    [[HTTPClient sharedHTTPClient] POST:linkString parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else
        {
            Job * newJob = [[Job new] initWithDictionary:responseObject];
            success(newJob);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)sendJobTouser:(NSString*)userId byUser:(NSString*)byUser jobId:(NSString*)jobId invite:(BOOL)invite success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,
                                                   @"byUser":byUser,
                                                   @"jobid":jobId,
                                                   @"invite":@(invite)
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"sendJobTouser.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else {
            
            success(responseObject[@"response"]);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)sendOfferTouser:(NSString*)userId byUser:(NSString*)byUser job:(Job*)job invite:(BOOL)invite success:(SuccessRH)success fail:(FailRH)fail
{
    Job * newJob = job;
    [DataLoader sendJobTouser:userId byUser:newJob.byUser jobId:newJob.jobId invite:YES success:^(id responseObject) {
        success(responseObject);
    } fail:^(NSError *error) {
        
    }];
}


+(void)acceptApplication:(NSString*)userId applicationId:(NSNumber*)applicationId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,
                                                   @"application_id":applicationId
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"applicationAccept.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            success(responseObject[@"response"]);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)refuseApplication:(NSString*)userId applicationId:(NSNumber*)applicationId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,
                                                   @"application_id":applicationId
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"applicationRefuse.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else
        {
            success(responseObject[@"response"]);
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)individualUserProfile:(NSString*)userId myuserid:(NSString*)myuserid success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId, @"myserid":myuserid}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"profile.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else
        {
            success([[User new] initWithDictionary:responseObject[@"response"]]);
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)getCertifiedNursingAssistantsList:(User*)user searchString:(NSString*)searchString forPage:(NSInteger)page success:(SuccessRH)success fail:(FailRH)fail
{
    
    
    
    NSString*encryptString = [DataLoader encrypt:@{@"skills":searchString,
                                                   @"min_price":@([Storage getSearchSettingsMinPriceRange]),
                                                   @"max_price":@([Storage getSearchSettingsMaxPriceRange]),
                                                   @"lat":user.address_lat,
                                                   @"long":user.address_long,
                                                   @"range":@([Storage getSearchSettingsLocation]),
                                                   @"avalability":@([Storage getSearchSettingsAvalability]),
                                                   @"min_age":@([Storage getSearchSettingsMinExperience]),
                                                   @"max_age":@([Storage getSearchSettingsMaxExperience]),
                                                   @"page" : @(page),
                                                   @"userid" : user.userId
                                                   }];
    
    
    
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"nurse.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            NSMutableArray * responseArray = [NSMutableArray new];
            if ([AppUtils isValidObject:responseObject[@"response"]]) {
                for (NSDictionary* dict in responseObject[@"response"])
                {
                    User *mapedObject = [[User new] initWithDictionary:dict];
                    mapedObject.fromPage = page;
                    [responseArray addObject:mapedObject];
                }
            }
            success(responseArray);
            
        }
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)deleteUserJob:(NSString*)userId withJobId:(NSNumber*)jobId  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId,@"jobid":jobId  }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"deletejob.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            success(responseObject);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)deletePush:(NSString*)userId success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId }];
    NSDictionary*dict = @{@"data":encryptString};
    
    [Storage setUserLogin:nil];
    [Storage setPriority:nil];
    
    [[HTTPClient sharedHTTPClient] POST:@"deletepush.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            success(nil);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)sendPush:(NSString*)pushString fromUser:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"push":pushString,
                                                   @"userid":userId
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"push.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            
            success(responseObject[@"response"]);
            
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}




+(void)changeUserPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword forUser:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"oldpass":[DataLoader md5:oldPassword],
                                                   @"newpass":[DataLoader md5:newPassword],
                                                   @"id":userId
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"changepassword.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else
        {
            if (newPassword.length != 0) {
                [Storage setPriority:newPassword];
            }
            
            success(responseObject[@"response"]);
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}

+(void)userCanApplyToJob:(NSString*)userId jobId:(NSNumber*)jobId  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"jobid":jobId,
                                                   @"user":userId
                                                   }];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"checkCanApplyToJob.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        int cases = [responseObject[@"response"] intValue];
        
        switch (cases) {
            case 0:
            {
                NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : @"You already aplied for this job. It is waiting for response."}];
                fail(error);
            }
                break;
            case 1:
            {
                NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : @"You already aplied for this job. It was accepted."}];
                fail(error);
            }
                
                break;
            case 2:
            {
                NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : @"You already aplied for this job. It was Rejected."}];
                fail(error);
            }
                break;
            case 5:
                success(responseObject[@"response"]);
                break;
                
                
            default:
                break;
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)checkEmail:(NSString*)email  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"email":email}];
    NSDictionary*dict = @{@"data":encryptString};
    
    
    [[HTTPClient sharedHTTPClient] POST:@"checkEmail.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
            if ([responseObject[@"response"] integerValue] == 1) {
                NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : @"User with this email address alredy exists"}];
                [DataLoader alertUserForError:error];
                fail(error);
            }
            
            success([User new]);
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)sendUserDidSubscribe:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId}];
    NSDictionary*dict = @{@"data":encryptString};
    
    [[HTTPClient sharedHTTPClient] POST:@"subscribed.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
          //  [DataLoader alertUserForError:error];
            fail(error);
            [Storage setWasErrorOnSubscription:YES];
        }
        
        else {
            success(nil);
            [Storage setWasErrorOnSubscription:NO];
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}


+(void)checIfUserIsSubscribed:(NSString*)userId  success:(SuccessRH)success fail:(FailRH)fail
{
    NSString*encryptString = [DataLoader encrypt:@{@"userid":userId}];
    NSDictionary*dict = @{@"data":encryptString};
    
    [[HTTPClient sharedHTTPClient] POST:@"checksubscribed.php" parameters:dict progress:nil success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            
            if ([errorString isEqualToString:@"Your account was blocked"]) {
                [[[AppUtils topViewController] navigationController] popToRootViewControllerAnimated:YES];
                [Storage setPriority:nil];
                [Storage setUserLogin:nil];
                [DataLoader alertUserForError:error];
            }
            //[DataLoader alertUserForError:error];
            fail(error);
        }
        
        else {
           
            success(responseObject[@"response"]);
      
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];

}



@end
