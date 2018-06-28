//
//  StartPageViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 11/17/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "StartPageViewController.h"
#import "AppDelegate.h"


@interface StartPageViewController ()

@end

@implementation StartPageViewController

-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *leftButton = [UIBarButtonItem new];
    leftButton.title = @"";
    self.navigationItem.leftBarButtonItem = leftButton;
    
    [super viewWillAppear:animated];
    
    if ([AppUtils isValidObject:[Storage getUserLogin]] && [AppUtils isValidObject:[Storage getPriority]]) {
        
        [DataLoader loginWithUserName:[Storage getUserLogin] andPassword:[Storage getPriority] success:^(User *user) {
            self.user = user;
            if (self.user.type == _individual) {
                [self performSegueWithIdentifier:segue_showCertifiedNursingAssistants sender:nil];
            }
            else if (self.user.type == _profesional) {
                [self performSegueWithIdentifier:segue_showAvailablejobs sender:nil];
            }
            
            AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate registerForRemoteNotificationsWithUserId:self.user.userId];

        } fail:^(NSError *error) {
             [self performSegueWithIdentifier: segue_showLogin sender:nil];
        }];
    }
    
    else
    {
        [self performSegueWithIdentifier: segue_showLogin sender:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
