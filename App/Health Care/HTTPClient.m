//
//  HTTPClient.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/24/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import "HTTPClient.h"
#import "AFNetworking.h"
#import "DataLoader.h"
#import "AppUtils.h"


@implementation HTTPClient

+ (HTTPClient *)sharedHTTPClient
{
    static HTTPClient *_sharedHTTPClient = nil;
    _sharedHTTPClient.requestViewController = (BaseViewController*)[AppUtils topViewController];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[HTTPClient new] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        
      
       
    });
    
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
   
    if (self) {
        AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [self.requestSerializer setTimeoutInterval:120.0];
    }
    
    return self;
}

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
