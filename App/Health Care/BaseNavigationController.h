//
//  BaseNavigationController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 11/7/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface BaseNavigationController : UINavigationController
@property (nonatomic,retain)  User *user;

@end
