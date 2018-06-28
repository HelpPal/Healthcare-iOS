//
//  RegistrationStep5ViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RegistrationStep5ViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "LoginViewController.h"


@interface RegistrationStep5ViewController ()

@end

@implementation RegistrationStep5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [UIView animateWithDuration:0.5 animations:^{
        
    } completion:^(BOOL finished) {
        [self buildInterface];
    }];
    
    
    
    // Do any additional setup after loading the view.
}


-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    //Title and subtitle Cell
    {
        BlueTitleAndSubtitleCellSource *cellSource = [BlueTitleAndSubtitleCellSource new];
        cellSource.title = @"Done!";
        cellSource.subtitle = @"Your account is activated\nand ready to use.";
        [section addObject:cellSource];
    }
    
    
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    float height = self.view.frame.size.height - self.tableView.contentSize.height;
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        
        
        cellSource.staticHeightForCell = height/2.0 - 56;
        [section addObject:cellSource];
    }
    
    
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.buttonTitle = @"OK";
        cellSource.padding = 130;
        cellSource.selector = @selector(okButtonPressed:);
        [section addObject:cellSource];
    }
    
    
    
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}




-(IBAction)okButtonPressed:(id)sender
{

    [self.navigationController popToRootViewControllerAnimated:NO];
    
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
