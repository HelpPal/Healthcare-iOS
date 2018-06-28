//
//  ApplicationsCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ApplicationsCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import "UIButton+InfoObject.h"

@implementation ApplicationsCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"ApplicationsCell";

    }
    return self;
}

@end


@implementation ApplicationsCell

- (void)setUpWithSource:(ApplicationsCellSource*)source
{

    _messageLabel.text = source.applicationItem.offerType;
    
    _addressWidth.constant = self.frame.size.width - 135;
    _addressTrailing.constant = 10;
    _addressView.layer.cornerRadius = 10;
    _addressView.clipsToBounds = YES;
    _addressLabel.text = source.applicationItem.job.location.address.length ? source.applicationItem.job.location.address : [source.applicationItem.job.location.city stringByAppendingFormat:@", %@",source.applicationItem.job.location.country];
    
    
    _addressLabel.frame = CGRectMake(5, 2, _addressWidth.constant - 10, 0) ;
    _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addressLabel.numberOfLines = 0;
    [_addressLabel sizeToFit];
    
    _addressWidth.constant = _addressLabel.frame.size.width + 10;
    _addressHeight.constant = _addressLabel.frame.size.height + 3;
    
    _segmentBackView.layer.cornerRadius = _daysSegmentedControll.frame.size.height/2.0;
    _segmentBackView.layer.borderColor = self.backgroundColor.CGColor;
    _segmentBackView.layer.borderWidth = 1.0;
    
    _segmentBackView.clipsToBounds = YES;
    
    _priceLabel.text = [NSString stringWithFormat:@"%@$ - %@$/h", source.applicationItem.job.min_price, source.applicationItem.job.max_price];
    
    if ([source.applicationItem.job.min_price isEqualToString:source.applicationItem.job.max_price]) {
        _priceLabel.text = [NSString stringWithFormat:@"%@$/h", source.applicationItem.job.min_price];
    }

    
    [_daysSegmentedControll setTitleTextAttributes:@{NSForegroundColorAttributeName:[AppUtils inputFieldTextColor],
                                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:16]}
                                          forState:UIControlStateNormal];
    
    
    [_daysSegmentedControll selectAllSegments:YES];
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet new] initWithIndexSet:_daysSegmentedControll.selectedSegmentIndexes];
    
    
  
    
    _separatorsImage.layer.borderColor = [AppUtils separatorsColor].CGColor;
    _separatorsImage.layer.borderWidth = 0.5f;
    
    
    _acceptButton.layer.cornerRadius = 15.0f;
    _declineButton.layer.cornerRadius = 15.0f;
    _allStatesButton.layer.cornerRadius = 15.0f;
    
    

    _acceptButton.enabled = YES;
    [_acceptButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_declineButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_allStatesButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    
   
    _acceptButton.infoObject = source.applicationItem;
    _declineButton.infoObject = source.applicationItem;
    if (source.applicationItem.application.result == _accept_decline ) {
        
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

    
    
    else if(source.applicationItem.application.result == _waiting )
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
    
    
    [source.applicationItem.job.days enumerateObjectsUsingBlock:^(Day* day, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexSet removeIndex:[day.day integerValue]];
    }];
    [_daysSegmentedControll selectAllSegments:NO];
    _daysSegmentedControll.selectedSegmentIndexes = indexSet;

    
    _titleLabel.text = source.applicationItem.user.fullName;
    _subtitleLabel.text = source.applicationItem.job.time_desc;
    _descriptionLabel.text = source.applicationItem.job.information;
    
    
   
 
    _acceptButton.infoObject = source.applicationItem;
    _declineButton.infoObject = source.applicationItem;
    _allStatesButton.infoObject = source.applicationItem;
    
    
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.showJobDetailsSelector];
    _tapGesture.infoObject = source.applicationItem.job;
    
}

@end




