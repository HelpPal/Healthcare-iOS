//
//  PurchasedReceipt.h
//  Chat for WhatsApp
//
//  Created by Midnight.Works iMac on 12/1/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receipt.h"

@interface PurchasedReceipt : NSObject



@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString* environment;
@property (nonatomic, strong) Receipt* receipt;
@property (nonatomic, strong) NSMutableArray* latest_receipt_info;
@property (nonatomic, strong) NSString* latest_receipt;


- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end
