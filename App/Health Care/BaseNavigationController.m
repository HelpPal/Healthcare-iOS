//
//  BaseNavigationController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 11/7/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "DataLoader.h"


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue sender:sender];
    BaseViewController *viewController = segue.destinationViewController;
    viewController.user = self.user;
    
    
}


@end
