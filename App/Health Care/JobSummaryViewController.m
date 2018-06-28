//
//  JobSummaryViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "JobSummaryViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "MultiLineStringCell.h"
#import "AddNewJobViewController.h"
#import "LightBlueButtonRoundedCell.h"
#import "AvailableJobsCell.h"
#import "LoginViewController.h"


#import "CertifiedNursingAssistantsViewController.h"


@interface JobSummaryViewController ()



@end

@implementation JobSummaryViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Summary";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
 
    if ([AppUtils validateString:_offerJob.jobId].length == 0)  {
        [DataLoader addJobEdit:_offerJob withMyUserId:self.user.userId isEditing:NO isPrivate:YES success:^(id addedJob) {
            
            _offerJob = addedJob;
             [self buildInterface];
            
        } fail:^(NSError *error) {
            
        }];
    }
    
    else
    {
     [self buildInterface];
    }
    
    // Do any additional setup after loading the view.
}


-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 15;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"This is a summary of your offer, are you sure you want to send it?";
        cellSource.fontSize = 16;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 15;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        AvailableJobsCellSource *cellSource = [AvailableJobsCellSource new];
        cellSource.job = _offerJob;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 30;
        [section addObject:cellSource];
    }
    
    // next button
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.selector =  @selector(sendOffer:);
        cellSource.buttonTitle = @"Send";
        cellSource.padding = 20;
        cellSource.staticHeightForCell = 60;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    // next button
    {
        LightBlueButtonRoundedCellSource *cellSource = [LightBlueButtonRoundedCellSource new];
        cellSource.selector =  @selector(cancelOffer:);
        cellSource.buttonTitle = @"Cancel";
        cellSource.buttonBackColor = [AppUtils separatorsColor];
        cellSource.buttonTitleColor = [AppUtils buttonRedTextColor];
        cellSource.staticHeightForCell = 60;
        cellSource.padding = 20;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
}



-(IBAction)sendOffer:(id)sender
{
    
    if ([AppUtils validateString:_offerJob.jobId].length) {
        
        [DataLoader sendJobTouser:_assistantUser.userId byUser:self.user.userId jobId:_offerJob.jobId invite:YES success:^(id responseObject) {
            [Storage setDidHireUser:_assistantUser.fullName];
            
            CertifiedNursingAssistantsViewController * certifiedNursingAssistantsViewController = self.navigationController.viewControllers[1];
            
            if ([certifiedNursingAssistantsViewController isKindOfClass:[LoginViewController class]]) {
                certifiedNursingAssistantsViewController = self.navigationController.viewControllers[2];
            }
            
            
            [self.navigationController popToViewController:certifiedNursingAssistantsViewController animated:NO];
            [certifiedNursingAssistantsViewController userButtonPressed:nil];
        } fail:^(NSError *error) {
            
        }];
    }
    
    else
    {
        [DataLoader sendOfferTouser:_assistantUser.userId byUser:self.user.userId job:_offerJob invite:YES success:^(id responseObject) {
            [Storage setDidHireUser:_assistantUser.fullName];
            CertifiedNursingAssistantsViewController * certifiedNursingAssistantsViewController = self.navigationController.viewControllers[1];
            if ([certifiedNursingAssistantsViewController isKindOfClass:[LoginViewController class]]) {
                certifiedNursingAssistantsViewController = self.navigationController.viewControllers[2];
            }
            [self.navigationController popToViewController:certifiedNursingAssistantsViewController animated:NO];
            [certifiedNursingAssistantsViewController userButtonPressed:nil];
        } fail:^(NSError *error) {
            
        }];
    }
    
}


-(IBAction)cancelOffer:(id)sender
{
    [DataLoader deleteUserJob:self.user.userId withJobId:_offerJob.jobId success:^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
    }];
    
  
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    [super prepareForSegue:segue sender:sender];
//  
//}



@end
