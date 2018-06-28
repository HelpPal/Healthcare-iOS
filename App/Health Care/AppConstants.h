//
//  AppConstants.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppConstants:NSObject

@end

//Used Fonts

#define _lato_font_regular @"Lato-Regular"
#define _lato_font_bold @"Lato-Bold"
#define _helveticaNeue_font_regular @"HelveticaNeue"
#define itemsPerPage 10
// used segues

#define segue_showRegistrationStep_2 @"showRegistrationStep2"
#define segue_showRegistrationStep_3 @"showRegistrationStep3"
#define segue_showRegistrationStep_4 @"showRegistrationStep4"
#define segue_showRegistrationStep_5 @"showRegistrationStep5"
#define segue_showTermsAndConditions @"showTermsAndConditions"


#define segue_showProfesionalRegistrationStep_3 @"showProfesionalRegistrationStep3"
#define segue_showUserSkils @"showUserSkils"
#define segue_showExperienceTime @"showExperienceTime"

#define segue_showJobDetails @"showJobDetails"
#define segue_showMyJobDetails @"showMyJobDetails"

#define segue_showEditMyProfile @"showEditMyProfile"
#define segue_showUserMesages @"showUserMesages"

#define segue_showEditMyProfileProfesional @"showEditMyProfileProfesional"

#define segue_showApplications @"showApplications"
#define segue_showExpiredSubscribtion @"showExpiredSubscribtion"
#define segue_showCertifiedNursingAssistantProfile @"showCertifiedNursingAssistantProfile"
#define segue_showHireAssistant @"showHireAssistant"
#define segue_showAddNewJob @"showAddNewJob"
#define segue_showEditJob @"showEditJob"
#define segue_showLocationMap @"showLocationMap"
#define segue_showCreateOffer @"showCreateOffer"
#define segue_showJobSummary @"showJobSummary"

#define segue_showCertifiedNursingAssistants @"showCertifiedNursingAssistants"
#define segue_showAvailablejobs @"showAvailablejobs"
#define segue_showLogin @"showLogin"
#define segue_showLostPasswordInstructions @"showLostPasswordInstructions"

#define appErrorDomain @"Health Care"
#define SUBSCRIPTION_ID @"com.tusk.healthcare.autorenewableSubscription2"


#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
typedef enum   {
    _experience_time,
    _price_range,
} SliderType;

typedef enum   {
    _top,
    _bottom,
} Position;


typedef enum   {
    _individual,
    _profesional,
    _unknown_type
} ClientType;

typedef enum   {
    _fullTime,
    _partTime,
} AvailableTime;

typedef enum   {
    _female,
    _male,
} Gender;

typedef enum   {
    _NearMe,
    _Everywhere
} LocationSearch;

typedef enum   {
    _waiting,
    _acccepted,
    _declined,
    _accept_decline,
} ApplicationsState;



