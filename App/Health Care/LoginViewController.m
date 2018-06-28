//
//  LoginViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"



@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet CustomInputView *loginInputView;
@property (weak, nonatomic) IBOutlet CustomInputView *passwordInputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botomLostPasswordSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopSpace;

@end

@implementation LoginViewController






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    UIBarButtonItem *leftButton = [UIBarButtonItem new];
    leftButton.title = @"";
    self.navigationItem.leftBarButtonItem = leftButton;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The callback for frame-changing of keyboard

- (IBAction)onFreePlace:(id)sender {
    [self.view endEditing:YES];
}



-(void)loginWithUsername:(NSString*)username andPassword:(NSString*)password
{
    self.view.userInteractionEnabled = NO;
    [DataLoader loginWithUserName:username andPassword:password success:^(User *responseObject) {
        self.user = responseObject;
        self.view.userInteractionEnabled = YES;
        if (self.user.type == _individual) {
            [self performSegueWithIdentifier:segue_showCertifiedNursingAssistants sender:nil];
        }
        else
        {
            [self performSegueWithIdentifier:segue_showAvailablejobs sender:nil];
        }
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate registerForRemoteNotificationsWithUserId:self.user.userId];
        
        
        _passwordInputView.textField.text = @"";
        
    } fail:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
    }];
}



- (IBAction)login:(id)sender {
    
    
    [self loginWithUsername:_loginInputView.textField.text andPassword:_passwordInputView.textField.text];
    

}


- (void)keyboardWillShow:(NSNotification *)notification {
    [super keyboardWillShow:notification];
    _titleTopSpace.constant = [AppUtils isIphoneVersion:4] ?  -90 : 20;
      self.botomLostPasswordSpace.constant = self.keyboardHeight;
     [self.navigationController setNavigationBarHidden:[AppUtils isIphoneVersion:4] || [AppUtils isIphoneVersion:5]  animated:YES];

}

- (void)keyboardWillHide:(NSNotification *)notification {
    [super keyboardWillHide:notification];
      self.botomLostPasswordSpace.constant = 0;
    _titleTopSpace.constant = 20;
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [super prepareForSegue:segue sender:sender];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


@end
