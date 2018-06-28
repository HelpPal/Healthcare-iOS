//
//  InAppPurchase.h
//  Chat for WhatsApp
//
//  Created by Midnight.Works iMac on 12/1/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receipt.h"

@interface InAppPurchase : NSObject

@property (nonatomic, strong) NSString* quantity;
@property (nonatomic, strong) NSString* purchase_date_ms;
@property (nonatomic, strong) NSString* expires_date;
@property (nonatomic, strong) NSString* expires_date_pst;
@property (nonatomic, strong) NSString* transaction_id;
@property (nonatomic, strong) NSString* is_trial_period;
@property (nonatomic, strong) NSString* original_transaction_id;
@property (nonatomic, strong) NSString* purchase_date;
@property (nonatomic, strong) NSString* product_id;
@property (nonatomic, strong) NSString* original_purchase_date_pst;
@property (nonatomic, strong) NSString* original_purchase_date_ms;
@property (nonatomic, strong) NSString* web_order_line_item_id;
@property (nonatomic, strong) NSString* expires_date_ms;
@property (nonatomic, strong) NSString* purchase_date_pst;
@property (nonatomic, strong) NSString* original_purchase_date;
@property (nonatomic, assign) BOOL isValidPurchase;


- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end
