//
//  UserMessagesViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "UserMessagesViewController.h"
#import "MessagesConversationUserCell.h"
#import "MyMessagesConversationUserCell.h"
#import "SpaceCell.h"
#import "Message.h"
#import "AppUtils.h"
#import "AvailableJobsCell.h"
#import "CertifiedNursingAssistantProfileViewController.h"

@interface UserMessagesViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIImageView *sendMessagesSeparatorsImageView;
@property (weak, nonatomic) IBOutlet UIView * sendMessageView;
@property (weak, nonatomic) IBOutlet UITextView *sendMessageTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, assign) int messageLenght;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic,strong) UITapGestureRecognizer * navSingleTap;

@end

@implementation UserMessagesViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _listItem.partnerName;
    _sendMessageView.frame = CGRectMake(0, 0, 320, 55);

    _navSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAssistantDetails:)];
    _navSingleTap.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer:_navSingleTap];
    [self.navigationController.navigationBar setUserInteractionEnabled:YES];

    [self loadItems];
}

-(void)loadItems
{
    [DataLoader getUserConversation:self.user.userId withPartner:_listItem.partner success:^(NSArray *conversations) {
        _items = [NSArray arrayWithArray:conversations];
        [self buildInterface];
    } fail:^(NSError *error) {
        
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _sendMessageTextView.text = @"     ";
    _sendMessageTextView.text = @"m";
    CGRect tvTvrect = _sendMessageTextView.frame;
    [_sendMessageTextView sizeToFit];
    tvTvrect.size.height = _sendMessageTextView.frame.size.height;
    _sendMessageTextView.frame = tvTvrect;
    _sendMessageTextView.center = CGPointMake(_sendMessageTextView.center.x, _sendMessageView.frame.size.height / 2.0f);
    _sendMessageTextView.text = @"";
   
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar removeGestureRecognizer:_navSingleTap];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    _navSingleTap = nil;
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    _sendButton.layer.cornerRadius = 12;
   
    
  
    _sendMessagesSeparatorsImageView.layer.borderWidth = 0.5f;
    _sendMessagesSeparatorsImageView.layer.borderColor = [AppUtils separatorsColor].CGColor;
    _sendMessagesSeparatorsImageView.clipsToBounds = YES;
    
    _placeholderLabel.textColor = [AppUtils placeholdersColor];
    _sendMessageTextView.textColor = [AppUtils inputFieldTextColor];
    
    
    
}


-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    
    for (Message * message in _items)
    {
        if ([message.user isEqualToString:self.user.userId])
        {
            MyMessagesConversationUserCellSource *cellSource = [MyMessagesConversationUserCellSource new];
            cellSource.message = message;
            [section addObject:cellSource];
        }
        else
        {
            MessagesConversationUserCellSource *cellSource = [MessagesConversationUserCellSource new];
            cellSource.message = message;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 20;
            [section addObject:cellSource];
        }
        
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    if (section.count)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:section.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
   
    
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    [super keyboardWillShow:notification];
    
    if (_items.count) {
        NSArray * arr = self.tableView.source[0];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:arr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}


-(IBAction)showAssistantDetails:(UITapGestureRecognizer*)sender
{
    
    
    [DataLoader individualUserProfile:_listItem.partner  myuserid:self.user.userId success:^(User *user) {
        if (user.type == _profesional) {
            [self performSegueWithIdentifier:segue_showCertifiedNursingAssistantProfile sender:user];
        }
    } fail:^(NSError *error) {
        
    }];
   
}

- (UIView *)inputAccessoryView{
    
    return _sendMessageView;
    
}

- (BOOL)canBecomeFirstResponder{
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView
{
       
    
    _placeholderLabel.hidden = textView.text.length;
    if (abs(_messageLenght - (int)textView.text.length) > 2 ) {
        _sendMessageTextView.contentSize = CGSizeZero;
        [self scrollViewDidEndScrollingAnimation:textView];
    }
    _messageLenght = (int)textView.text.length;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    if (_sendMessageTextView.contentSize.height >= 180) {
        CGRect rect = _sendMessageView.frame;
        float height = _sendMessageTextView.contentSize.height;
        
        height = height < 55 ? 55 : height;
        height = height > 200 ? 200 : height;
        
        rect.size.height = height ;
        
        _sendMessageView.frame = rect;
        [_sendMessageTextView reloadInputViews];
        return;
    }
    CGRect tvTvrect = _sendMessageTextView.frame;
    [_sendMessageTextView sizeToFit];
    
    float height = _sendMessageTextView.frame.size.height;
    
    
    
    height = height < 55 ? 55 : height;
    height = height > 200 ? 200 : height;

    
    tvTvrect.size.height = height;
    _sendMessageTextView.frame = tvTvrect;
    _sendMessageTextView.center = CGPointMake(_sendMessageTextView.center.x, _sendMessageView.frame.size.height / 2.0f);
    
    CGRect rect = _sendMessageView.frame;
    height = _sendMessageTextView.frame.size.height;
    
    
   
    height = height < 55 ? 55 : height;
    height = height > 200 ? 200 : height;
    
    rect.size.height = height ;
    
    _sendMessageView.frame = rect;
    [_sendMessageTextView reloadInputViews];

}





-(IBAction)sendMessage:(UIButton*)sender
{
    if (_sendMessageTextView.text.length ) {
        _sendMessageTextView.text = [_sendMessageTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [DataLoader sendMessageFromUser:self.user.userId toPartner:_listItem.partner text:_sendMessageTextView.text success:^(id responseObject) {
            _sendMessageTextView.text = @"";
            [self loadItems];
        } fail:^(NSError *error) {
            
        }];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // // Get the new view controller using [segue destinationViewController].
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:segue_showCertifiedNursingAssistantProfile]) {
        CertifiedNursingAssistantProfileViewController *dest = (CertifiedNursingAssistantProfileViewController*)segue.destinationViewController;
        dest.nurseProfileUser = sender;
    }
}


@end
