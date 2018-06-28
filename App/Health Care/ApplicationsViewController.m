//
//  ApplicationsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ApplicationsViewController.h"
#import "MultiLineStringCell.h"
#import "SpaceCell.h"
#import "CertifiedNursingAssistantsListCell.h"
#import "TaggedStringCell.h"
#import "ApplicationsCell.h"
#import "ShowJobDetailsCell.h"
#import "AcceptDeclineCell.h"
#import "UserMessagesViewController.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import "JobDetailsViewController.h"


@interface ApplicationsViewController ()

@property (weak, nonatomic) IBOutlet UIVisualEffectView *bottomBlurrView;
@property (weak, nonatomic) IBOutlet UILabel *bottomMessageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBottomSpace;
@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) UIRefreshControl *topRefreshControl;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;
@end

@implementation ApplicationsViewController


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
    
    self.navigationItem.title = @"Applications";
    
   
        [self loadItemsForPage:0 position:_top];
    
    
    [Storage setApplicationsPushesCount:0];
    
}

-(void)loadItemsForPage:(NSUInteger)page position:(Position)position
{
    if (self.user.type == _individual) {
        [DataLoader getApplicationsForUser:self.user.userId page: page success:^(NSArray* items) {
            [self buildInterface:items forPage:page onPosition:position];
        } fail:^(NSError *error) {
            [self endRefreshing];
        }];
    }
    else if (self.user.type == _profesional) {
        
        [DataLoader getApplicationsForProfesionalUser:self.user.userId page: page success:^(NSArray* items) {
            [self buildInterface:items forPage:page onPosition:position];
            
        } fail:^(NSError *error) {
            [self endRefreshing];
        }];
    }
    
    else
    {
      NSLog(@"\n\n\nunknownUser type\n\n\n");
    }
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
    
    
    
    
    _bottomBlurrView.alpha = 0;
    NSString * nameString = [Storage getHiredUser];
    
    if (self.user.type == _individual && [AppUtils isValidString:nameString])
    {
        NSString *messageString = [@"Hire request sent to\n" stringByAppendingString:nameString];
        NSMutableAttributedString * attrMessageString = [[NSMutableAttributedString alloc] initWithString:messageString];
        [attrMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_bottomMessageLabel.font.fontName size:20] range:[messageString rangeOfString:nameString]];
        _bottomMessageLabel.attributedText = attrMessageString;
        
        _bottomBlurrView.alpha = 0.9;
    }
    
    
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
        ApplicationItem * item = _items[0];
        if (item.fromPage - 1 == -1) {
            [self loadItemsForPage:0 position:_top];
            return;
        }
        fromPage = item.fromPage - 1;
    }
    [self loadItemsForPage:fromPage position:_top];
}

- (void)refreshBottom:(UIRefreshControl *)refreshControl {
    
    if (_items.count != 0) {
        ApplicationItem * item = _items[_items.count - 1];
        NSInteger fromPage = item.fromPage + 1;
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
    
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 9;
        [self.tableView.source addObject:@[cellSource]];
    }
    
    
    for (ApplicationItem *applicationItem in _items) {
        
        NSMutableArray *section = [NSMutableArray new];
        NSString * actionString = applicationItem.offerType;

        
        if (self.user.type == _profesional ||
            (self.user.type == _individual && [actionString isEqualToString:@"You received an offer from"] == NO))
        {
            
            {
                
                ApplicationsCellSource *cellSource = [ApplicationsCellSource new];
                cellSource.applicationItem = applicationItem;
                cellSource.selector = @selector(acceptApplication:);
                cellSource.declineSelector = @selector(declineApplication:);
                cellSource.sendMessageSelector = @selector(sendMessage:);
                cellSource.optionsSelector = @selector(options:);
                cellSource.declinedOptionsSelector = @selector(declinedOptions:);
                cellSource.waitingOptionsSelector = @selector(waitingOptions:);
                cellSource.showJobDetailsSelector = @selector(showJobDetails:);
                cellSource.target = self;
                [section addObject:cellSource];

            }
        }
        
        
        
        
        else
        {
            
            {
                SeparatorCellSource *cellSource = [SeparatorCellSource new];
                [section addObject:cellSource];
            }
            {
                SpaceCellSource *cellSource = [SpaceCellSource new];
                cellSource.staticHeightForCell = 10;
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                [section addObject:cellSource];
            }
            {
                MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
                cellSource.infoText = actionString;
                cellSource.fontSize = 12;
                cellSource.textColor = [AppUtils grayTextColor];
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                cellSource.textAlignment = NSTextAlignmentLeft;
                [section addObject:cellSource];
            }
            {
                CertifiedNursingAssistantsListCellSource *cellSource = [CertifiedNursingAssistantsListCellSource new];
                cellSource.user = applicationItem.user;
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
                ShowJobDetailsCellSource *cellSource = [ShowJobDetailsCellSource new];
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                cellSource.job = applicationItem.job;
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
                cellSource.staticHeightForCell = 15;
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                [section addObject:cellSource];
            }
            {
                AcceptDeclineCellSource *cellSource = [AcceptDeclineCellSource new];
                cellSource.applicationItem = applicationItem;
                cellSource.selector = @selector(acceptApplication:);
                cellSource.declineSelector = @selector(declineApplication:);
                cellSource.sendMessageSelector = @selector(sendMessage:);
                cellSource.optionsSelector = @selector(options:);
                cellSource.declinedOptionsSelector = @selector(declinedOptions:);
                cellSource.waitingOptionsSelector = @selector(waitingOptions:);
                cellSource.backgroundColor = [AppUtils lightBlueColor];
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
        }
        
    
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
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
            cellSource.infoText = @"No applications";
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

-(void)buildInterface
{

   NSMutableArray *section = [NSMutableArray new];
   
    
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 9;
        [section addObject:cellSource];
    }
    
    
    for (ApplicationItem *applicationItem in _items) {
        
       
        NSString * actionString = applicationItem.offerType;
        
        
        if (self.user.type == _profesional ||
            (self.user.type == _individual && [actionString isEqualToString:@"You received an offer from"] == NO))
        {
            
            {
                
                ApplicationsCellSource *cellSource = [ApplicationsCellSource new];
                cellSource.applicationItem = applicationItem;
                cellSource.selector = @selector(acceptApplication:);
                cellSource.declineSelector = @selector(declineApplication:);
                cellSource.sendMessageSelector = @selector(sendMessage:);
                cellSource.optionsSelector = @selector(options:);
                cellSource.declinedOptionsSelector = @selector(declinedOptions:);
                cellSource.waitingOptionsSelector = @selector(waitingOptions:);
                cellSource.showJobDetailsSelector = @selector(showJobDetails:);
                cellSource.target = self;
                [section addObject:cellSource];
               
                
            }
        }
        
        
        
        
        else
        {
            
            {
                SeparatorCellSource *cellSource = [SeparatorCellSource new];
                [section addObject:cellSource];
                
                
            }
            {
                SpaceCellSource *cellSource = [SpaceCellSource new];
                cellSource.staticHeightForCell = 10;
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                [section addObject:cellSource];
            }
            {
                MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
                cellSource.infoText = actionString;
                cellSource.fontSize = 12;
                cellSource.textColor = [AppUtils grayTextColor];
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                cellSource.textAlignment = NSTextAlignmentLeft;
                [section addObject:cellSource];
            }
            {
                CertifiedNursingAssistantsListCellSource *cellSource = [CertifiedNursingAssistantsListCellSource new];
                cellSource.user = applicationItem.user;
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
                ShowJobDetailsCellSource *cellSource = [ShowJobDetailsCellSource new];
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                cellSource.job = applicationItem.job;
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
                cellSource.staticHeightForCell = 15;
                cellSource.backgroundColor = [AppUtils lightBlueColor];
                [section addObject:cellSource];
            }
            {
                AcceptDeclineCellSource *cellSource = [AcceptDeclineCellSource new];
                cellSource.applicationItem = applicationItem;
                cellSource.selector = @selector(acceptApplication:);
                cellSource.declineSelector = @selector(declineApplication:);
                cellSource.sendMessageSelector = @selector(sendMessage:);
                cellSource.optionsSelector = @selector(options:);
                cellSource.declinedOptionsSelector = @selector(declinedOptions:);
                cellSource.waitingOptionsSelector = @selector(waitingOptions:);
                cellSource.backgroundColor = [AppUtils lightBlueColor];
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
        }
        
        
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            [section addObject:cellSource];
        }
    }
    
    if (_items.count == 0) {
         [self loadItemsForPage:0 position:_top];
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
}

-(void)endRefreshing
{
    [_topRefreshControl endRefreshing];
    [_bottomRefreshControl endRefreshing];
}


- (IBAction)hideBottomMessage:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomBlurrView.alpha = 0;
        [Storage setDidHireUser:nil];
    }];
}


-(IBAction)showJobDetails:(UIGestureRecognizer*)sender
{
    [self performSegueWithIdentifier: segue_showJobDetails sender:sender.infoObject];
}


-(IBAction)showAssistantDetails:(UIButton*)sender
{
    
    
}

-(IBAction)sendMessage:(UIButton*)sender
{
    
    [self performSegueWithIdentifier:segue_showUserMesages sender:sender.infoObject];
    
}

-(IBAction)options:(UIButton*)sender
{
    ApplicationItem *applicationItem = sender.infoObject;
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:appErrorDomain message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
    
    
    if (applicationItem.user.type == _profesional)
    {
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:[@"Call " stringByAppendingString:applicationItem.user.phone]
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel://%@",applicationItem.user.phone]];
                                       
                                       if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
                                           [[UIApplication sharedApplication] openURL:phoneUrl];
                                       }
                                       
                                       else
                                       {
                                           NSError *error = [NSError errorWithDomain:appErrorDomain code:0 userInfo:@{@"message" : @"Invalid operation"}];
                                           [DataLoader alertUserForError:error];
                                           return;
                                       }
                                       
                                   }];
        
        [alert addAction:okButton];
    }
    
    
    
    UIAlertAction* reportButton = [UIAlertAction
                                   actionWithTitle:@"Report"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                       [DataLoader reportJobFromUser:applicationItem.user.userId jobId:applicationItem.job.jobId success:^(id responseObject) {
                                           
                                       } fail:^(NSError *error) {
                                           
                                       }];
                                       
                                   }];
    
    UIAlertAction* deleteAppButton = [UIAlertAction
                                      actionWithTitle:@"Delete this application"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          
                                          
                                          [DataLoader deleteApplication:applicationItem success:^(id responseObject) {
                                              [_items removeObject:applicationItem];
                                              [self buildInterface];
                                          } fail:^(NSError *error) {
                                              
                                          }];
                                      }];
    
    
    [alert addAction:reportButton];
    [alert addAction:deleteAppButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}




-(IBAction)waitingOptions:(UIButton*)sender
{
    ApplicationItem *applicationItem = sender.infoObject;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:appErrorDomain message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
  
    
    UIAlertAction* deleteAppButton = [UIAlertAction
                                      actionWithTitle:@"Cancel the request"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          
                                          [DataLoader deleteApplication:applicationItem success:^(id responseObject) {
                                              [_items removeObject:applicationItem];
                                              [self buildInterface];
                                          } fail:^(NSError *error) {
                                              
                                          }];
                                          
                                          
                                      }];
    
    [alert addAction:cancelButton];
    [alert addAction:deleteAppButton];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


-(IBAction)declinedOptions:(UIButton*)sender
{
    ApplicationItem *applicationItem = sender.infoObject;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:appErrorDomain message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
    UIAlertAction* reportButton = [UIAlertAction
                                   actionWithTitle:@"Report"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [DataLoader reportJobFromUser:applicationItem.user.userId jobId:applicationItem.job.jobId success:^(id responseObject) {
                                           
                                       } fail:^(NSError *error) {
                                           
                                       }];

                                   }];
    
    UIAlertAction* deleteAppButton = [UIAlertAction
                                      actionWithTitle:@"Delete this application"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          
                                          [DataLoader deleteApplication:applicationItem success:^(id responseObject) {
                                              [_items removeObject:applicationItem];
                                              [self buildInterface];
                                          } fail:^(NSError *error) {
                                              
                                          }];
                                          
                                          
                                      }];
    
    [alert addAction:cancelButton];
    [alert addAction:reportButton];
    [alert addAction:deleteAppButton];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}





-(IBAction)acceptApplication:(UIButton*)sender
{
    ApplicationItem *application = sender.infoObject;
    [DataLoader acceptApplication:self.user.userId applicationId:application.application.appId success:^(id responseObject) {
        application.application.result = _acccepted;
        [self.tableView reloadData];
    } fail:^(NSError *error) {
       
    }];
    
}

-(IBAction)declineApplication:(UIButton*)sender
{
    
     ApplicationItem *application = sender.infoObject;
    [DataLoader refuseApplication:self.user.userId applicationId:application.application.appId success:^(id responseObject) {
        application.application.result = _declined;
        [self.tableView reloadData];
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
    
    if ([segue.identifier isEqualToString:segue_showUserMesages]) {
        
        ApplicationItem * appItem = sender;
        UserMessagesViewController * mess = (UserMessagesViewController*)segue.destinationViewController;
        MessageListItem *item = [MessageListItem new];
        item.itemId = nil;
        item.user = self.user.userId;
        item.partner = appItem.user.userId;
        item.partnerName = appItem.user.fullName;
        item.lastMessage = [Message new];
        mess.listItem = item;
        
    }
    
    if ([segue.identifier isEqualToString:segue_showJobDetails]) {
        JobDetailsViewController * details = segue.destinationViewController;
        details.job = sender;
        details.hideEditButton = YES;
    }
}


@end
