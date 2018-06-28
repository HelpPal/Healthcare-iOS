//
//  UserMessagesViewController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView.h>
#import "BaseTableViewController.h"
#import "MessageListItem.h"

@interface UserMessagesViewController : BaseTableViewController
@property (nonatomic, strong) MessageListItem * listItem;
-(void)loadItems;
@end
