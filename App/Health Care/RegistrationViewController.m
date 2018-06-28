//
//  RegistrationViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RegistrationViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "PriceItemCell.h"
#import "RegistrationOptionCell.h"
#import "BlueButtonRoundedCell.h"
#import "MultiLineStringCell.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [UIView animateWithDuration:0.5 animations:^{
        
    } completion:^(BOOL finished) {
        [self buildInterface];
    }];
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.user = [User new];
    self.user.type = _unknown_type;
    
    self.tableView.scrollEnabled = [AppUtils isIphoneVersion:4];
   
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
//        cellSource.preTitle = @"First Month Free!!!";
        cellSource.title = @"First Month Free!!!\rRegistration: Step 1";
        cellSource.subtitle = @"Choose your account type";
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
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
    
    {
        RegistrationOptionCellSource *cellSource = [RegistrationOptionCellSource new];
        cellSource.individualHiringSelector = @selector(choseIndividualHiring:);
        cellSource.professionalCNASelector = @selector(choseProfessionalCNA:);
        cellSource.clientType = self.user.type;
        [section addObject:cellSource];
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    float height = self.view.frame.size.height - self.tableView.contentSize.height;
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = height/1.5 - 56;
        [section addObject:cellSource];
    }
    
    
    if (self.user.type != _unknown_type)
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.buttonTitle = @"Next step";
        cellSource.padding = 100;
        cellSource.selector = @selector(nextStep:);
        [section addObject:cellSource];
    }
    
    else
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Tap on the type of account\nyou want to create";
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

-(IBAction)nextStep:(id)sender
{
    [self performSegueWithIdentifier:segue_showRegistrationStep_2 sender:nil];
}



-(void)choseIndividualHiring:(UIButton*)sender
{
    self.user.type = _individual;
    [self buildInterface];
}

-(void)choseProfessionalCNA:(UIButton*)sender
{
    self.user.type = _profesional;
    [self buildInterface];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//     [super prepareForSegue:segue sender:sender];
//
//     
// }


@end
