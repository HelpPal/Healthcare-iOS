//
//  BaseViewController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInputView.h"
#import "AppConstants.h"
#import "AppUtils.h"
#import "MenuButtonWithImageView.h"

#import "DataLoader.h"
#import "UIButton+InfoObject.h"
#import "UIGestureRecognizer+InfoObject.h"
#import "BBBadgeBarButtonItem.h"
#import "MultiLineStringCell.h"



@interface BaseViewController : UIViewController

@property (nonatomic,assign) CGFloat keyboardHeight;
@property (nonatomic,assign) NSTimeInterval keyboardAnimationDuration;
@property (nonatomic,retain)  User *user;

@property (nonatomic, assign) BOOL statusBarHidden;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
-(void)addRightButton;
-(IBAction)subscribeNow:(UIButton*)sender;
-(IBAction)goToTermsSubscribe:(UIButton*)sender;

@end
