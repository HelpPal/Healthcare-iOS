//
//  TermsAndConditionsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/6/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TermsAndConditionsViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    NSURL * url = [NSURL URLWithString:[BASE_URL stringByAppendingString:@"terms.html"]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    self.navigationItem.title = @"Terms and Conditions";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)dismissViewController:(UIButton*)sender
{

[self dismissViewControllerAnimated:YES completion:^{
    
}];
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
