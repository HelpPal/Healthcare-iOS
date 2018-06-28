//
//  ExperienceTimeViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ExperienceTimeViewController.h"
#import "RadioButtonCell.h"
#import "SpaceCell.h"



@interface ExperienceTimeViewController ()
@property (nonatomic, assign) NSInteger previousSelectedItem;
@end

@implementation ExperienceTimeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Experience";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 75, 38);
    editButton.backgroundColor = [AppUtils buttonBlueColor];
    editButton.titleLabel.font = [UIFont fontWithName:_lato_font_regular size:14];
    editButton.layer.cornerRadius = 12.0f;
    [editButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"Done" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    
    self.navigationItem.rightBarButtonItem = rightButton;

    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-button-image"] style:UIBarButtonItemStyleDone target:self action:@selector(performBackNavigation:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    
    
   
    
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [UIView animateWithDuration:0.5 animations:^{
        
    } completion:^(BOOL finished) {
        [self buildInterface];
    }];
    
    _previousSelectedItem = [self.user.experience integerValue];
    // Do any additional setup after loading the view.
}


-(void)buildInterface
{
    
    NSArray *experienceArray = [AppUtils experienceArray];
    
    NSMutableArray *section = [NSMutableArray new];
    
    for (int i = 0; i < experienceArray.count; i++)
    {
        
        {
            RadioButtonCellSource *cellSource = [RadioButtonCellSource new];
            cellSource.title = experienceArray[i];
            cellSource.isSelected = [self.user.experience integerValue] == i;
            cellSource.selector = @selector(itemSelected:);
            cellSource.target = self;
            cellSource.itemTag = i;
            [section addObject:cellSource];
        }
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 0.5;
            cellSource.backgroundColor = [AppUtils placeholdersColor];
            [section addObject:cellSource];
        }
    }
    
    
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}

-(void)itemSelected:(UIGestureRecognizer*)sender
{
    self.user.experience = sender.infoObject;
    [self buildInterface];
}


- (void)performBackNavigation:(id)sender
{
    
    self.user.experience = @(_previousSelectedItem);
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)pressDoneButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    

     
 }


@end
