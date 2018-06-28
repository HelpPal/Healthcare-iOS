//
//  RegistrationStep3ViewController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView.h>
#import "BaseTableViewController.h"
#import "HCSStarRatingView.h"
@interface RegistrationStep3ViewController : BaseTableViewController
@property (nonatomic,assign)  BOOL isEditing;
@property (nonatomic, assign) NSString *password;
@end
