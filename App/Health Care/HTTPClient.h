//
//  HTTPClient.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#import "BaseViewController.h"

@interface HTTPClient : AFHTTPSessionManager


@property (nonatomic , strong) BaseViewController * requestViewController;
// Initialisation Methods
+ (HTTPClient *)sharedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (BOOL)connected;

@end
