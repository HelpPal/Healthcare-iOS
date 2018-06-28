//
//  AcceptDeclineCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AcceptDeclineCell.h"
#import "UIButton+InfoObject.h"
#import "AppUtils.h"

@implementation AcceptDeclineCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"AcceptDeclineCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 42.0f;
  }
  return self;
}

@end


@implementation AcceptDeclineCell

- (void)setUpWithSource:(AcceptDeclineCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    
    _acceptButton.layer.cornerRadius = 15.0f;
    _declineButton.layer.cornerRadius = 15.0f;
    _allStatesButton.layer.cornerRadius = 15.0f;
    
    [_acceptButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_declineButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_allStatesButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    
    
    
    _acceptButton.enabled = YES;
    
    
    
    _acceptButton.infoObject = source.applicationItem;
    _declineButton.infoObject = source.applicationItem;
    _allStatesButton.infoObject = source.applicationItem;
    
    
    if (source.applicationItem.application.result == _accept_decline)  {
        
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Accept" forState:UIControlStateSelected];
        [_acceptButton setTitle:@"Accept" forState:UIControlStateHighlighted];
        
        [_acceptButton setBackgroundColor:[AppUtils inputFieldTextColor]];
        
        
        
        
        [_declineButton setTitleColor:[AppUtils buttonRedTextColor] forState:UIControlStateNormal];
        [_declineButton setTitleColor:[AppUtils buttonRedTextColor] forState:UIControlStateSelected];
        [_declineButton setTitleColor:[AppUtils buttonRedTextColor] forState:UIControlStateHighlighted];
        
        [_declineButton setTitle:@"Decline" forState:UIControlStateNormal];
        [_declineButton setTitle:@"Decline" forState:UIControlStateSelected];
        [_declineButton setTitle:@"Decline" forState:UIControlStateHighlighted];
        
        [_declineButton setBackgroundColor:[UIColor whiteColor]];
        
        _allStatesButton.hidden = YES;
        
        
        [_acceptButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
        [_declineButton addTarget:source.target action:source.declineSelector forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    else if (source.applicationItem.application.result == _acccepted)
    {
        
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_acceptButton setTitle:@"Send a message" forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Send a message" forState:UIControlStateSelected];
        [_acceptButton setTitle:@"Send a message" forState:UIControlStateHighlighted];
        
        [_acceptButton setBackgroundColor:[AppUtils inputFieldTextColor]];
        
        
        
        
        [_declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_declineButton setTitle:@"Options" forState:UIControlStateNormal];
        [_declineButton setTitle:@"Options" forState:UIControlStateSelected];
        [_declineButton setTitle:@"Options" forState:UIControlStateHighlighted];
        
        [_declineButton setBackgroundColor:[AppUtils placeholdersColor]];
        
        _allStatesButton.hidden = YES;
        
        [_acceptButton addTarget:source.target action:source.sendMessageSelector forControlEvents:UIControlEventTouchUpInside];
        [_declineButton addTarget:source.target action:source.optionsSelector forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (source.applicationItem.application.result == _declined)
    {
        
        [_acceptButton setTitleColor:[AppUtils buttonRedTextColor] forState:UIControlStateNormal];
        [_acceptButton setTitleColor:[AppUtils buttonRedTextColor] forState:UIControlStateSelected];
        [_acceptButton setTitleColor:[AppUtils buttonRedTextColor] forState:UIControlStateHighlighted];
        
        [_acceptButton setTitle:@"Declined" forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Declined" forState:UIControlStateSelected];
        [_acceptButton setTitle:@"Declined" forState:UIControlStateHighlighted];
        
        [_acceptButton setBackgroundColor:[UIColor whiteColor]];
     
        
        
        [_declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
         
        [_declineButton setTitle:@"Options" forState:UIControlStateNormal];
        [_declineButton setTitle:@"Options" forState:UIControlStateSelected];
        [_declineButton setTitle:@"Options" forState:UIControlStateHighlighted];
        
        [_declineButton setBackgroundColor:[AppUtils placeholdersColor]];
        
        _allStatesButton.hidden = YES;
        
        _acceptButton.enabled = NO;
        [_declineButton addTarget:source.target action:source.declinedOptionsSelector forControlEvents:UIControlEventTouchUpInside];
    }
  
    else if(source.applicationItem.application.result == _waiting)
    {
        [_allStatesButton setTitleColor:[AppUtils placeholdersColor] forState:UIControlStateNormal];
        [_allStatesButton setTitleColor:[AppUtils placeholdersColor] forState:UIControlStateSelected];
        [_allStatesButton setTitleColor:[AppUtils placeholdersColor] forState:UIControlStateHighlighted];
        
        [_allStatesButton setTitle:@"Waiting for an answer" forState:UIControlStateNormal];
        [_allStatesButton setTitle:@"Waiting for an answer" forState:UIControlStateSelected];
        [_allStatesButton setTitle:@"Waiting for an answer" forState:UIControlStateHighlighted];
        
        [_allStatesButton setBackgroundColor:[UIColor whiteColor]];
        [_allStatesButton addTarget:source.target action:source.waitingOptionsSelector forControlEvents:UIControlEventTouchUpInside];
        _allStatesButton.hidden = NO;
    }

}




@end




