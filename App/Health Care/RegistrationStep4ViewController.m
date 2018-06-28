//
//  RegistrationStep4ViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RegistrationStep4ViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "PriceItemCell.h"
#import "BlueButtonRoundedCell.h"
#import "CustomButtonCell.h"
#import "MultiLineStringCell.h"



 
@interface RegistrationStep4ViewController ()

@end

@implementation RegistrationStep4ViewController

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
        cellSource.title = @"Registration: Step 4";
        cellSource.subtitle = @"Subscription";
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
    
    //Price Cell
    {
        PriceItemCellSource *cellSource = [PriceItemCellSource new];
        cellSource.price = @"$9.99/month";
        cellSource.staticHeightForCell = 40;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }

    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"\r\r\r\r\rFirst month Free!!!";

        cellSource.fontSize = 28.f;
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
        cellSource.buttonTitle = @"Subscribe now";
        cellSource.padding = 95;
        cellSource.selector = @selector(goToTermsSubscribe:);
        [section addObject:cellSource];
    }
    
//    {
//        SpaceCellSource *cellSource = [SpaceCellSource new];
//        [section addObject:cellSource];
//    }
//    
//    
//    {
//        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
//        cellSource.buttonTitle = @"Subscribe Demo";
//        cellSource.padding = 95;
//        cellSource.selector = @selector(demoSubscribe:);
//        [section addObject:cellSource];
//    }

    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
         cellSource.staticHeightForCell = height/2.3 - 56;
        [section addObject:cellSource];
    }
    
    {
        CustomButtonCellSource *cellSource = [CustomButtonCellSource new];
        cellSource.buttonTitle = @"Restore purchases";
        cellSource.buttonSelector = @selector(restorePurchases:);
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}



-(IBAction)demoSubscribe:(UIButton *)sender
{
    [DataLoader sendUserDidSubscribe:self.userId success:^(id responseObject) {
        
        [self performSegueWithIdentifier:segue_showRegistrationStep_5 sender:nil];
    } fail:^(NSError *error) {
        
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
