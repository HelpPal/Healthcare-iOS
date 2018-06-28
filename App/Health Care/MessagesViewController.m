//
//  MessagesViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessagesUserListCell.h"
#import "UserMessagesViewController.h"
#import "MultiLineStringCell.h"



@interface MessagesViewController ()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceTableView;
@property (weak, nonatomic) IBOutlet UIView *botomView;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic,assign) int selectedCount;
@property (nonatomic,assign) BOOL isEditing;
@end

@implementation MessagesViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Messages";
    
    [self loadItems];
}

-(void)loadItems
{
    [DataLoader getUserMessageList:self.user.userId success:^(NSArray* messaagesList) {
        _items = [NSArray arrayWithArray:messaagesList];
        [self buildInterface];
    } fail:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _botomView.layer.borderWidth = 1.0;
    _botomView.layer.borderColor = [AppUtils separatorsColor].CGColor;

    
    
    _bottomSpaceTableView.constant = 0;
    UIImage *rightButtonImage = [UIImage imageNamed:@"editMessagesIcon"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(pressEditButton:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
     [self.view layoutIfNeeded];
    // Do any additional setup after loading the view.
}


-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    {
    SeparatorCellSource *cellSource = [SeparatorCellSource new];
    [section addObject:cellSource];
    }
    for (MessageListItem * item in _items) {
        {
            MessagesUserListCellSource *cellSource = [MessagesUserListCellSource new];
            cellSource.messageListItem = item;
            cellSource.isEditing = _isEditing;
            cellSource.selector = @selector(selectUser:);
            cellSource.target = self;
            [section addObject:cellSource];
        }
        
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [section addObject:cellSource];
        }
        
    }
    
    
    if (_items.count == 0) {
        
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            cellSource.backgroundColor = [UIColor whiteColor];
            cellSource.staticHeightForCell = 60;
            [section addObject:cellSource];
        }
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"No messages";
            [section addObject:cellSource];
        }
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}

-(void)selectUser:(UIButton*)sender
{
    if (_isEditing == NO) {
        [self performSegueWithIdentifier:segue_showUserMesages sender:sender.infoObject];
    }
    
    else
    {
        MessageListItem * messageListItem = sender.infoObject;
        messageListItem.isSelected = !messageListItem.isSelected;
        _selectedCount += messageListItem.isSelected ? 1 : -1;
        
        [_deleteButton setTitle:[NSString stringWithFormat:@"Delete %d conversations", _selectedCount] forState:UIControlStateNormal];
        [_deleteButton setTitle:[NSString stringWithFormat:@"Delete %d conversations", _selectedCount] forState:UIControlStateSelected];
        [_deleteButton setTitle:[NSString stringWithFormat:@"Delete %d conversations", _selectedCount] forState:UIControlStateHighlighted];
        [self buildInterface];
    }
}

-(IBAction)deleteMessages:(id)sender
{
    [self.items enumerateObjectsUsingBlock:^(MessageListItem * item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (item.isSelected) {
            [DataLoader deleteConversationUser:item.user withPartner:item.partner success:^(id responseObject) {
                [self pressEditButton:nil];
                [self loadItems];
                _selectedCount = 0;
            } fail:^(NSError *error) {
                
            }];
        }
    }];

}

-(IBAction)pressEditButton:(id)sender
{
    _isEditing = !_isEditing;
    
    [_deleteButton setTitle:[NSString stringWithFormat:@"Delete %d conversations", _selectedCount] forState:UIControlStateNormal];
    [_deleteButton setTitle:[NSString stringWithFormat:@"Delete %d conversations", _selectedCount] forState:UIControlStateSelected];
    [_deleteButton setTitle:[NSString stringWithFormat:@"Delete %d conversations", _selectedCount] forState:UIControlStateHighlighted];
    
    [self buildInterface];
    
    [UIView animateWithDuration:0.5 animations:^{
        _bottomSpaceTableView.constant = _isEditing ? 60 : 0;
        [self.view layoutIfNeeded];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     [super prepareForSegue:segue sender:sender];
   
     UserMessagesViewController * dest = (UserMessagesViewController*)segue.destinationViewController;
     dest.listItem = sender;
     
 }


@end
