//
//  AppleSubscriptionViewController.m
//  Health Care
//
//  Created by Catalin on 18/5/17.
//  Copyright © 2017 TUSK.ONE. All rights reserved.
//

#import "AppleSubscriptionViewController.h"

@interface AppleSubscriptionViewController ()
{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet NSLayoutConstraint *bottomLayout;
    
}
@end

@implementation AppleSubscriptionViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Subscribe";
    NSLog(@"Screen Height %f", [[UIScreen mainScreen] bounds].size.height);
  
    
    //float constat =  (866.0f-504.0f)*[[UIScreen mainScreen] bounds].size.height/568.0f;
    
    bottomLayout.constant = 0;
    
    [self updateViewConstraints];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
       NSLog(@"Screen Height %f", [[UIScreen mainScreen] bounds].size.height);
    
     [scrollView setContentSize:CGSizeMake(320*([[UIScreen mainScreen] bounds].size.width/320), 10000)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [scrollView setContentSize:CGSizeMake(320*([[UIScreen mainScreen] bounds].size.width/320), 10000)];

     // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Buttons
- (IBAction)btnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)buttonsSubscribe:(UIButton*)sender {
    
    [self subscribeNow:sender];
    NSLog(@"Subscribe");
}
- (IBAction)btnPrivacy:(id)sender {
    
        NSLog(@"Privacy");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://nomadroot.com/appstore/privacy/?CNA%20Healthcare%20Connectors"]];

}
- (IBAction)btnTerms:(id)sender {
        NSLog(@"Terms");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://nomadroot.com/appstore/terms/?CNA%20Healthcare%20Connectors"]];

}
- (IBAction)btnCancelSubscription:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://support.apple.com/en-us/HT202039"]];

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
