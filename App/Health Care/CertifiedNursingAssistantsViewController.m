//
//  CertifiedNursingAssistantsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CertifiedNursingAssistantsViewController.h"
#import "SpaceCell.h"
#import "TaggedStringCell.h"
#import "CertifiedNursingAssistantProfileViewController.h"
#import "CertifiedNursingAssistantsListCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import "MultiLineStringCell.h"


@interface CertifiedNursingAssistantsViewController ()

@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet MenuButtonWithImageView *messagesMenuButton;
@property (weak, nonatomic) IBOutlet CustomInputView *searchView;


@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) UIRefreshControl *topRefreshControl;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;

@end

@implementation CertifiedNursingAssistantsViewController

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
    self.navigationItem.title = @"Certified Nursing Assistants";
    
    [self.tableView reloadData];
    
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
   

    [DataLoader getCertifiedNursingAssistantsList:self.user searchString:_searchView.textField.text forPage: page success:^(NSArray* responseObject) {
        
        [self buildInterface:responseObject forPage:page onPosition:position];
        [self endRefreshing];
        
    } fail:^(NSError *error) {
        [self endRefreshing];
    }];
    
    
}




- (void)viewDidLoad {
    
    
    [super viewDidLoad];
   
    self.user.type = _individual;
    self.tableView.scrollEnabled = YES;
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
       
    UIImage *leftButtonImage = [UIImage imageNamed:@"menuButtonImage"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;
   
    
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
    
    
    if([AppUtils isIphoneVersion:4])
    {
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 40)];
        titleLabel.text = @"Certified Nursing Assistants";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:_lato_font_regular size:18.0];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [AppUtils buttonBlueColor];
        titleLabel.numberOfLines = 2;
        titleLabel.adjustsFontSizeToFitWidth = YES; // As alternative you can also make it multi-line.
        titleLabel.minimumScaleFactor = 0.5;
        self.navigationItem.titleView = titleLabel;
    }
    
    
    self.tableView.bottomRefreshControl = _bottomRefreshControl;
    
    
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
        User * user = _items[0];
        if (user.fromPage - 1 == -1) {
            [self loadItemsForPage:0 position:_top];
            return;
        }
        fromPage = user.fromPage - 1;
    }
    [self loadItemsForPage:fromPage position:_top];
}

- (void)refreshBottom:(UIRefreshControl *)refreshControl {
    
    if (_items.count != 0) {
        User * user = _items[_items.count - 1];
        NSInteger fromPage = user.fromPage + 1;
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
    
    
    for (User *user in _items) {
        
         NSMutableArray *section = [NSMutableArray new];
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [section addObject:cellSource];
        }
        {
            CertifiedNursingAssistantsListCellSource *cellSource = [CertifiedNursingAssistantsListCellSource new];
            
            cellSource.user = user;
            cellSource.selector = @selector(showAssistantDetails:);
            cellSource.target = self;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 15;
            cellSource.backgroundColor = [AppUtils lightBlueColor];
            [section addObject:cellSource];
        }
        {
            TaggedStringCellSource *cellSource = [TaggedStringCellSource new];
            cellSource.backgroundColor = [AppUtils lightBlueColor];
            cellSource.user = user;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 15;
            cellSource.backgroundColor = [AppUtils lightBlueColor];
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
            cellSource.infoText = @"No assistants found";
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

-(IBAction)showAssistantDetails:(UITapGestureRecognizer*)sender
{
    
    [self performSegueWithIdentifier:segue_showCertifiedNursingAssistantProfile sender:sender.infoObject];
}


-(IBAction)userButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:segue_showApplications sender:nil];
}

-(IBAction)menuButtonPressed:(id)sender
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view layoutSubviews];
    [self showHideBlurView];
}

-(IBAction)hideMenuView:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view layoutSubviews];
    [self showHideBlurView];
}

-(void)showHideBlurView
{
    [self.view endEditing:YES];
    
    [_messagesMenuButton setButtonImage:[@"messagesIconImage" stringByAppendingFormat:@"%d", [Storage getNewMessagesCount] > 0]];
    [UIView animateWithDuration:0.25 animations:^{
        
        _blurView.alpha = 1.0 - _blurView.alpha;
        self.statusBarHidden = _blurView.alpha;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (BOOL)prefersStatusBarHidden
{
    // If self.statusBarHidden is TRUE, return YES. If FALSE, return NO.
    return (self.statusBarHidden) ? YES : NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:segue_showCertifiedNursingAssistantProfile]) {
        CertifiedNursingAssistantProfileViewController *dest = (CertifiedNursingAssistantProfileViewController*)segue.destinationViewController;
        dest.nurseProfileUser = sender;
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


@end
