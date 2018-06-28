//
//  AvailableJobsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AvailableJobsViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "DoubleMenuButton.h"
#import "Job.h"
#import "JobDetailsViewController.h"
#import "AvailableJobsCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface AvailableJobsViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet MenuButtonWithImageView *messagesMenuButton;
@property (weak, nonatomic) IBOutlet DoubleMenuButton *availableButtonsView;
@property (weak, nonatomic) IBOutlet CustomInputView *searchView;
@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) UIRefreshControl *topRefreshControl;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;

@end

@implementation AvailableJobsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _items = [NSMutableArray new];
    }
    return self;
}

- (IBAction)searchTextChanged:(UITextField *)sender {
    if (sender.text.length > 2 || sender.text.length == 0 ) {
    [self loadItemsForPage:0 position:_top];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self loadItemsForPage:0 position:_top];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    _searchView.textField.text = [Storage getSearchSettingsSearchString];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_blurView.alpha == 1.0 animated:YES];
    self.navigationItem.title = @"Available jobs for you";
    [self loadItemsForPage:0 position:_top];
    [self addRightButton];
     [_messagesMenuButton setButtonImage:[@"messagesIconImage" stringByAppendingFormat:@"%d", [Storage getNewMessagesCount] > 0]];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.statusBarHidden = _blurView.alpha;
        [self setNeedsStatusBarAppearanceUpdate];
        [self.view layoutSubviews];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.statusBarHidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.view layoutSubviews];
}


-(void)loadItemsForPage:(NSUInteger)page position:(Position)position
{
    
    [DataLoader getAvailableJobsForUser:self.user searchString:_searchView.textField.text forPage:page success:^(NSArray* items) {
        [self buildInterface:items forPage:page onPosition:position];
    } fail:^(NSError *error) {
        [self endRefreshing];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    

    
    
    UIImage *leftButtonImage = [UIImage imageNamed:@"menuButtonImage"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    
    [_availableButtonsView changeStateForButton:(self.user.available ? _availableButtonsView.leftButton : _availableButtonsView.rightButton)];
    
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
    
    // Do any additional setup after loading the view.
}

-(void)addRightButton
{
    UIImage *rightButtonImage = [UIImage imageNamed:@"userFormImageDark"];
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setImage:rightButtonImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(userButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    BBBadgeBarButtonItem *rightBarButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:rightButton];
    // Set a value for the badge
    rightBarButton.badgeValue = [@([Storage getApplicationsPushesCount]) stringValue];
    rightBarButton.badgeOriginX = 0;
    rightBarButton.badgeOriginY = rightButton.frame.size.height/2;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
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
    
    
    
    
    
    for (Job *job in _items)
    {
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



-(IBAction)signOut:(id)sender
{
   [DataLoader deletePush:self.user.userId success:^(id responseObject) {
       [self.navigationController popViewControllerAnimated:YES];
   } fail:^(NSError *error) {
       
   }];
}

-(IBAction)showJobDetails:(UIButton*)sender
{
    Job * job = sender.infoObject;
    [self performSegueWithIdentifier:segue_showJobDetails sender:job];
}

- (IBAction)setUserAvailability:(UIButton *)sender {
    [DataLoader setAvailableUser:self.user available:@(sender.tag) success:^(id responseObject) {
        self.user.available = sender.tag;
        [_availableButtonsView changeStateForButton:sender];
    } fail:^(NSError *error) {
        
    }];
}




-(IBAction)userButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:segue_showApplications sender:nil];
}

-(IBAction)menuButtonPressed:(id)sender
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view layoutSubviews];
    [self showHideBlurView];
}

-(IBAction)hideMenuView:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.view layoutSubviews];
    [self showHideBlurView];
}

-(void)showHideBlurView
{
    [self.view endEditing:YES];
    self.statusBarHidden = (self.statusBarHidden) ? NO : YES;
    
    [_messagesMenuButton setButtonImage:[@"messagesIconImage" stringByAppendingFormat:@"%d", [Storage getNewMessagesCount] > 0]];
    [UIView animateWithDuration:0.25 animations:^{
        
        _blurView.alpha = 1.0 - _blurView.alpha;
        self.statusBarHidden = _blurView.alpha;
        [self setNeedsStatusBarAppearanceUpdate];
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
    
    if ([segue.identifier isEqualToString:segue_showJobDetails] ) {
        JobDetailsViewController * jobDetails = segue.destinationViewController;
        jobDetails.job = sender;
    }
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



@end
