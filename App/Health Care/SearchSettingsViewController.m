//
//  SearchSettingsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "SearchSettingsViewController.h"
#import "MultiLineStringCell.h"
#import "DoubleRadioButtonCell.h"
#import "SpaceCell.h"
#import "SliderCell.h"
#import "Storage.h"





@interface SearchSettingsViewController ()
@property (weak, nonatomic) IBOutlet CustomInputView *searchView;
@property (nonatomic, assign) NSInteger previousSearchSettingsMinPriceRange;
@property (nonatomic, assign) NSInteger previousSearchSettingsMaxPriceRange;
@property (nonatomic, assign) NSInteger previousSearchSettingsMinExperience;
@property (nonatomic, assign) NSInteger previousSearchSettingsMaxExperience;
@property (nonatomic, assign) NSInteger previousSearchSettingsAvalability;
@property (nonatomic, assign) NSInteger previousSearchSettingsLocation;
@end

@implementation SearchSettingsViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Search";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        
    } completion:^(BOOL finished) {
        [self buildInterface];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    
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
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    _previousSearchSettingsMinPriceRange = [Storage getSearchSettingsMinPriceRange];
    _previousSearchSettingsMaxPriceRange = [Storage getSearchSettingsMaxPriceRange];
    _previousSearchSettingsMinExperience = [Storage getSearchSettingsMinExperience];
    _previousSearchSettingsMaxExperience = [Storage getSearchSettingsMaxExperience];
    _previousSearchSettingsAvalability = [Storage getSearchSettingsAvalability];
    _previousSearchSettingsLocation = [Storage getSearchSettingsLocation];
    // Do any additional setup after loading the view.
}

- (void)performBackNavigation:(id)sender
{
     [Storage setSearchSettingsMinPriceRange:_previousSearchSettingsMinPriceRange];
     [Storage setSearchSettingsMaxPriceRange:_previousSearchSettingsMaxPriceRange];
     [Storage setSearchSettingsMinExperience:_previousSearchSettingsMinExperience];
     [Storage setSearchSettingsMaxExperience:_previousSearchSettingsMaxExperience];
     [Storage setSearchSettingsAvalability:_previousSearchSettingsAvalability];
     [Storage setSearchSettingsLocation:_previousSearchSettingsLocation];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)buildInterface
{
    _searchView.textField.text = [Storage getSearchSettingsSearchString];
    NSMutableArray *section = [NSMutableArray new];
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Location";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    {
        DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
        cellSource.selectedItem = ![Storage getSearchSettingsLocation];
        cellSource.selector = @selector(setLocationSearchOption:);
        cellSource.leftItemName = @"Near me";
        cellSource.rightItemName = @"Everywhere";
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
    
   
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Price range";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    {
        SliderCellSource *cellSource = [SliderCellSource new];
        cellSource.minimumValue = 15;
        cellSource.maximumValue = 120;
        cellSource.sliderType = _price_range;
        cellSource.leftValue = [Storage getSearchSettingsMinPriceRange];
        cellSource.rightValue = [Storage getSearchSettingsMaxPriceRange];
        cellSource.currencyString = @"$";
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Availability";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 8;
        [section addObject:cellSource];
    }
    
    
    {
        DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
        cellSource.selectedItem = [Storage getSearchSettingsAvalability];
        cellSource.selector = @selector(selectAvailability:);
        cellSource.leftItemName = @"Full time";
        cellSource.rightItemName = @"Part time";
        cellSource.target = self;
        [section addObject:cellSource];
    }
  
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Years of experience";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    {
        SliderCellSource *cellSource = [SliderCellSource new];
        cellSource.minimumValue = 0;
        cellSource.maximumValue = 20;
        cellSource.sliderType = _experience_time;
        cellSource.leftValue = [Storage getSearchSettingsMinExperience];
        cellSource.rightValue = [Storage getSearchSettingsMaxExperience];
        cellSource.currencyString = @"";
        [section addObject:cellSource];
    }
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
}

-(IBAction)selectAvailability:(UIButton*)sender
{
    [Storage setSearchSettingsAvalability:sender.tag];
    [self buildInterface];
    
}

-(IBAction)setLocationSearchOption:(UIButton*)sender
{
    [Storage setSearchSettingsLocation:!sender.tag];
    [self buildInterface];
    
}

-(IBAction)pressDoneButton:(id)sender
{
    [Storage setSearchSettingsSearchString:_searchView.textField.text];
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetAllSettings:(id)sender
{
    [Storage setDefaultSearchSettings];
    [self buildInterface];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     [self.navigationController setNavigationBarHidden:NO animated:NO];
 }


@end
