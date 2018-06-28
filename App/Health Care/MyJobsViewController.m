//
//  MyJobsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MyJobsViewController.h"
#import "AvailableJobsCell.h"
#import "JobDetailsViewController.h"
#import "AddNewJobViewController.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface MyJobsViewController ()
@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) UIRefreshControl *topRefreshControl;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;
@end

@implementation MyJobsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"My jobs";
    
        [self loadItemsForPage:0 position:_top];
   
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _items = [NSMutableArray new];
    }
    return self;
}
-(void)loadItemsForPage:(NSUInteger)page position:(Position)position
{
    [DataLoader getMyJobs:self.user.userId forPage:page success:^(NSArray *items) {
        
        [self buildInterface:items forPage:page onPosition:position];

        
    } fail:^(NSError *error) {
        [self endRefreshing];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 75, 38);
    editButton.backgroundColor = [AppUtils buttonBlueColor];
    editButton.titleLabel.font = [UIFont fontWithName:_lato_font_regular size:14];
    editButton.layer.cornerRadius = 12.0f;
    [editButton addTarget:self action:@selector(addNewJobB:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"New job" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    _topRefreshControl = [[UIRefreshControl alloc] init];
    _topRefreshControl.tintColor = [AppUtils spinerColor];
    _topRefreshControl.tag = 0;
    [_topRefreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:_topRefreshControl atIndex:0];
    
    _bottomRefreshControl = [UIRefreshControl new];
    _bottomRefreshControl.triggerVerticalOffset = 100.;
    _bottomRefreshControl.tintColor = [AppUtils spinerColor];
    _bottomRefreshControl.tag = 0;
    [_bottomRefreshControl addTarget:self action:@selector(refreshBottom:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.bottomRefreshControl = _bottomRefreshControl;
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    
    NSInteger fromPage  = 0;
    if (_items.count != 0) {
        Job * job = _items[0];
        if (job.fromPage - 1 == -1) {
            [self loadItemsForPage:0 position:_top];
            return;
        }
        fromPage = job.fromPage - 1;
    }
    [self loadItemsForPage:fromPage position:_top];
}

- (void)refreshBottom:(UIRefreshControl *)refreshControl {
    
    if (_items.count != 0) {
        Job * job = _items[_items.count - 1];
        NSInteger fromPage = job.fromPage + 1;
        [self loadItemsForPage:fromPage position:_bottom];
    };
    
}

-(void)buildInterface:(NSArray*)items forPage:(NSInteger)page onPosition:(Position)position
{
    [self.tableView.source removeAllObjects];
    
    if (page == 0) {
        [_items removeAllObjects];
    }
    
    if (items.count == itemsPerPage) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.fromPage == %d",position == _top ? page + 2 : page - 2];
        NSArray * pageArray = [_items filteredArrayUsingPredicate:predicate];
        [self.items removeObjectsInArray:pageArray];
    }
    
    
    
    switch (position) {
        case _top:
        {
            [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
        }
            break;
            
        case _bottom:
        {
            [_items addObjectsFromArray:items];
        }
            break;
            
        default:
            break;
    }

    
    for (Job *job in _items) {
         NSMutableArray *section = [NSMutableArray new];
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [section addObject:cellSource];
        }
        {
            AvailableJobsCellSource *cellSource = [AvailableJobsCellSource new];
            cellSource.job = job;
            cellSource.selector = @selector(showJobDetails:);
            cellSource.target = self;
            [section addObject:cellSource];
        }
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 20;
            [section addObject:cellSource];
        }
        [self.tableView.source addObject:section];
    }
    
    if (_items.count == 0) {
        NSMutableArray *section = [NSMutableArray new];
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            cellSource.backgroundColor = [UIColor whiteColor];
            cellSource.staticHeightForCell = 60;
            [section addObject:cellSource];
        }
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"No jobs";
            [section addObject:cellSource];
        }
        [self.tableView.source removeAllObjects];
        [self.tableView.source addObject:section];
    }

    
    NSLog(@"%lu",(unsigned long)self.tableView.source.count);
    
    [self.tableView reloadData];
    
    if ( page >= 0 && items.count < _items.count && position == _top)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:items.count];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    [self endRefreshing];
    
}

-(void)endRefreshing
{
    [_topRefreshControl endRefreshing];
    [_bottomRefreshControl endRefreshing];
}

-(IBAction)addNewJobB:(id)sender
{
    [self performSegueWithIdentifier:segue_showAddNewJob sender:nil];
}


-(IBAction)showJobDetails:(UIGestureRecognizer*)sender
{
    [self performSegueWithIdentifier: segue_showMyJobDetails sender:sender.infoObject];
}


-(IBAction)pressDoneButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:segue_showAddNewJob]) {
        AddNewJobViewController * newJob = segue.destinationViewController;
        newJob.isEditing = NO;
    }
    
    if ([segue.identifier isEqualToString:segue_showMyJobDetails]) {
        JobDetailsViewController * details = segue.destinationViewController;
        details.job = sender;
    }
    
    
}


@end
