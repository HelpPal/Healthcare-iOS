//
//  BaseViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpirationSubcribtionViewController.h"
#import "Skill.h"
#import "BaseNavigationController.h"
#import "UIButton+InfoObject.h"
#import "AppDelegate.h"
#import <StoreKit/StoreKit.h>
#import "ExpirationSubcribtionViewController.h"
#import "RegistrationStep4ViewController.h"
#import "PurchasedReceipt.h"
#import "InAppPurchase.h"
#import "AppleSubscriptionViewController.h"
@interface BaseViewController ()<SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation BaseViewController

-(void)addRightButton
{

}

-(void)applicationDidBecomeActive
{
    [self viewWillAppear:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"";
    [self.navigationController.navigationBar setTranslucent:NO];
    
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.currentViewController = self;
    
    BaseNavigationController * navController = (BaseNavigationController*)self.navigationController;
    navController.user = self.user;

    
    if ([AppUtils isValidObject:[Storage getUserLogin]] &&
        [AppUtils isValidObject:[Storage getPriority]] &&
        [AppUtils isValidObject:self.user.userId])
    {
        
        [DataLoader getUserMessagesCount:self.user.userId success:^(id responseObject) {
            [Storage setNewMessagesCount:[responseObject integerValue]];
        } fail:^(NSError *error) {
            
        }];
        
        NSLog(@"Other skills %@", self.user.otherSkills);
        
//        if ([self isKindOfClass:[ExpirationSubcribtionViewController class]] == NO
//            && [self isKindOfClass:[RegistrationStep4ViewController class]] == NO  && [self isKindOfClass:[AppleSubscriptionViewController class]] == NO) {
//
//            if ([AppUtils isUserSubscribed] == NO)
//            {
//                [self.navigationController performSegueWithIdentifier:segue_showExpiredSubscribtion sender:nil];
//            }
//
//        }
    }
    
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
        return NO;
    }
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.navigationItem.title = @"";
    [self removeObservers];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *leftButtonImage = [UIImage imageNamed:@"back-button-image"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [self observeKeyboard];
}

- (void)observeKeyboard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
     [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The callback for frame-changing of keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    self.keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    self.keyboardHeight = keyboardFrame.size.height;
    

}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    self.keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    self.keyboardHeight = keyboardFrame.size.height;
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BaseViewController *viewController = segue.destinationViewController;
    viewController.user = self.user;
}


-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (BOOL)prefersStatusBarHidden
{
    // If self.statusBarHidden is TRUE, return YES. If FALSE, return NO.
    return (self.statusBarHidden) ? YES : NO;
}





-(IBAction)goToTermsSubscribe:(UIButton*)sender
{
    
    [self performSegueWithIdentifier:@"AppleSubscriptions" sender:self];
}

-(IBAction)subscribeNow:(UIButton*)sender
{
    
    
    if([SKPaymentQueue canMakePayments]){
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject: SUBSCRIPTION_ID]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        
        //this is called the user cannot make payments, most likely due to parental controls
    }
    
}

-(IBAction)restorePurchases:(id)sender
{
    [self restore];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    NSInteger count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        
        request.delegate = self;
        [self purchase:validProduct];
        
    }
    else if(!validProduct){
        
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (void)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    
    [self paymentQueue:queue updatedTransactions:queue.transactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
                
                
            case SKPaymentTransactionStateDeferred:
                break;
                
            case SKPaymentTransactionStatePurchasing:
                
                
                
                break;
            case SKPaymentTransactionStatePurchased:
            {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [Storage setIsTrial:YES];
                [Storage setDidPurchase:YES];
                if ([self isKindOfClass:[ExpirationSubcribtionViewController class]])
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else if ([self isKindOfClass:[RegistrationStep4ViewController class]] ||  [self isKindOfClass:[AppleSubscriptionViewController class]])
                {
                    [self performSegueWithIdentifier:segue_showRegistrationStep_5 sender:nil];
                }
                
            }
                break;
            case SKPaymentTransactionStateRestored:
            {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [self verifyReceiptForURL:@"https://buy.itunes.apple.com/verifyReceipt"];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSString *messageString = transaction.error.localizedDescription;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:appErrorDomain message:messageString preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"Retry"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               [self buildInterface];
                                           }];
                
                [alert addAction:okButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
        }
    }
    
    
}




- (void)verifyReceiptForURL : (NSString*)urlString {
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    if ([AppUtils isValidObject:receipt])
    {
        NSDictionary * json = @{
                                @"receipt-data" : [receipt base64EncodedStringWithOptions:0],
                                @"password" : @"d58fa991a73e429aa590bffb3048916e"
                                };
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
        if ([AppUtils isValidObject:jsonData]) {
            
            NSURL *storeURL = [NSURL URLWithString:urlString];
            NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
            [storeRequest setHTTPMethod:@"POST"];
            [storeRequest setHTTPBody:jsonData];
            
            
            
            [[[NSURLSession sharedSession] dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    
                }
                else {
                    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
                    if ([jsonResponse[@"status"] integerValue] == 21007) {
                        [self verifyReceiptForURL: @"https://sandbox.itunes.apple.com/verifyReceipt"];
                    }
                    else
                    {
                        [Storage setIsTrial:NO];
                        [Storage setDidPurchase:NO];
                        PurchasedReceipt * purchasedReceipt = [[PurchasedReceipt new] initWithDictionary:jsonResponse];
                        for (InAppPurchase * inAppPurchase in purchasedReceipt.receipt.in_app) {
                            
                            if (inAppPurchase.isValidPurchase) {
                                [Storage setIsTrial:[inAppPurchase.is_trial_period boolValue]];
                                [Storage setDidPurchase:inAppPurchase.isValidPurchase];
                                
                                if ([self isKindOfClass:[ExpirationSubcribtionViewController class]])
                                {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }
                                else if ([self isKindOfClass:[RegistrationStep4ViewController class]] && [self isKindOfClass:[AppleSubscriptionViewController class]])
                                {
                                    [self performSegueWithIdentifier:segue_showRegistrationStep_5 sender:nil];
                                }

                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }] resume];
            
        }
        
        
        
    }
}

-(void)buildInterface
{
    
}



@end
