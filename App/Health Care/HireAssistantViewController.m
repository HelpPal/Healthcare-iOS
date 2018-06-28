//
//  HireAssistantViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "HireAssistantViewController.h"
#import "SpaceCell.h"
#import "AvailableJobsCell.h"
#import "MultiLineStringCell.h"
#import "CreateOfferCell.h"
#import "CreateOfferViewController.h"
#import "JobSummaryViewController.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface HireAssistantViewController ()

@property (weak, nonatomic) IBOutlet MenuButtonWithImageView *messagesMenuButton;
@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) UIRefreshControl *topRefreshControl;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;

@end

@implementation HireAssistantViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _items = [NSMutableArray new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [@"Hire " stringByAppendingString:_profiledUser.fullName];
    
    [self loadItemsForPage:0 position:_top];
    
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


-(void)loadItemsForPage:(NSUInteger)page position:(Position)position
{
    
    [DataLoader getMyJobs:self.user.userId forPage:page success:^(NSArray * items) {
        
        [self buildInterface:items forPage:page onPosition:position];
        
        
    } fail:^(NSError *error) {
        [self buildInterface:[NSArray new] forPage:page onPosition:position];
        [self endRefreshing];
    }];
}

-(void)buildInterface:(NSArray*)items forPage:(NSInteger)page onPosition:(Position)position
{
    [self.tableView.source removeAllObjects];
    if (page == 0) {
        [_items removeAllObjects];
    }
    NSMutableArray *section = [NSMutableArray new];
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 43;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        if (_profiledUser.gender == _female)
        {
            cellSource.infoText = [NSString stringWithFormat:@"To hire %@ you need to send her an offer. If she accepts your offer - you hired her.",_profiledUser.fullName];
        }
        else
        {
            cellSource.infoText = [NSString stringWithFormat:@"To hire %@ you need to send him an offer. If he accepts your offer - you hired him.",_profiledUser.fullName];
        }
        cellSource.fontSize = 16;
        cellSource.textColor = [AppUtils placeholdersColor];
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 50;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        CreateOfferCellSource *cellSource = [CreateOfferCellSource new];
        cellSource.selector = @selector(createOffer:);
        cellSource.title = @"Create offer";
        cellSource.target = self;
        cellSource.backgroundColor = [AppUtils lightBlueColor];
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 82;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Or select from your existing jobs:";
        cellSource.fontSize = 16;
        cellSource.textColor = [AppUtils placeholdersColor];
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    
    [self.tableView.source addObject:section];
    
    
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
        
        NSMutableArray *sectionItems = [NSMutableArray new];
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [sectionItems addObject:cellSource];
        }
        {
            AvailableJobsCellSource *cellSource = [AvailableJobsCellSource new];
            cellSource.job = job;
            cellSource.selector = @selector(showJobDetails:);
            cellSource.target = self;
            
            [sectionItems addObject:cellSource];
        }
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [sectionItems addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 20;
            [sectionItems addObject:cellSource];
            
        }
        [self.tableView.source addObject:sectionItems];
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

-(IBAction)createOffer:(id)sender
{
    [self performSegueWithIdentifier:segue_showCreateOffer sender:nil];
}


-(IBAction)showJobDetails:(UIGestureRecognizer*)sender
{
    Job * job = sender.infoObject;
    [DataLoader userCanApplyToJob:_profiledUser.userId jobId:job.jobId success:^(id responseObject) {
        [self performSegueWithIdentifier:segue_showJobSummary sender:sender.infoObject];
    } fail:^(NSError *error) {
        
    }];
    
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
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:segue_showCreateOffer]) {
        CreateOfferViewController * create = segue.destinationViewController;
        create.forUser = _profiledUser;
    }
    
    if ([segue.identifier isEqualToString:segue_showJobSummary]) {
        JobSummaryViewController * summary = segue.destinationViewController;
        summary.assistantUser = _profiledUser;
        summary.offerJob = sender;
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



@end
