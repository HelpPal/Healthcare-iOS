//
//  BaseTableViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/5/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<ImoDynamicTableViewDelegate>

@end

@implementation BaseTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    [_tableView setAllowsSelection:NO];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.tableView.dynamicTableViewDelegate = self;
    self.tableView.canCancelContentTouches = YES;
   self.tableView.delaysContentTouches = NO;
    
    for (id obj in self.tableView.subviews) {
        if ([obj respondsToSelector:@selector(setDelaysContentTouches:)]) {
            [obj setDelaysContentTouches:NO];
        }
    }
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];

}
-(void)hideKeyboard
{
    [self.view endEditing:YES];
}


- (void)keyboardWillShow:(NSNotification *)notification
{

    
    [super keyboardWillShow:notification];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, (self.keyboardHeight), 0.0);
    [self animateKeyboardApearenceForcontentInsets:contentInsets];
    
    
    
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [super keyboardWillHide:notification];
    [self animateKeyboardApearenceForcontentInsets:UIEdgeInsetsZero];
}

-(void)animateKeyboardApearenceForcontentInsets:(UIEdgeInsets)contentInsets
{
    [UIView animateWithDuration:self.keyboardAnimationDuration animations:^{
        self.tableView.contentInset = contentInsets;
        
    }];
    
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
