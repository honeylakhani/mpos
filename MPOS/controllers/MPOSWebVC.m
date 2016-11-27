
//  WebViewViewController.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/9/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "MPOSWebVC.h"
#import "MPOSActivityView.h"
#import "MPOSReachability.h"
#import "MPOSAlertController.h"
#import "MPOSRequestManager.h"
#import "MPOSRequestParams.h"

@interface MPOSWebVC () <UIWebViewDelegate, UIAlertViewDelegate, MPOSAlertControllerDelegate>
@property UIWebView *webView;
@end

@implementation MPOSWebVC {
    MPOSAlertController * _backButtonAlert;
}

NSString *paymentID=@"";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![MPOSReachability isInternetReachable]) {
        [MPOSActivityView removeViewAnimated:YES];
        [MPOSAlertController alertNoInternetConnectionAvailable];
        return;
    }
    
    //Create web view
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.deviceWidth, self.deviceHeight - 64)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.paymentId=[MPOSRequestParams  sharedParams].payment_id;
    
    //Load the web view
    if([self.type isEqualToString:@"post"]) {
        NSMutableURLRequest *url = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]];
        [url setHTTPMethod:@"POST"];
        [url setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [url setHTTPBody:[self.bodyParams dataUsingEncoding:NSUTF8StringEncoding]];
        [self.webView loadRequest:url];
    }
    else if ([self.type isEqualToString:@"get"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.urlString,self.bodyParams]]]];
    }
}

- (BOOL)webView:(UIWebView *)webView  shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
//    
//    NSString *requestURL = [[request URL] absoluteString];
//    
//    NSLog(@"REQUEST URL = %@",requestURL);
//    if([requestURL containsString:@"_enrolled"])
//        [MPOSActivityView removeViewAnimated:YES];
//    // Fetch payment id
//    
//    if([requestURL containsString:@"mihpayid"]){
//        
//        NSString *query = [[request URL] query];
//        NSLog(@"query = %@",query);
//    }
//    
//    if([requestURL containsString:SUCCESS_RESPONSE] || [requestURL containsString:FAILURE_RESPONSE]){
//        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//      
//        [MPOSActivityView activityViewForView:window withLabel:LOADER_MESSAGE];
//        
//        if ([[MPOSRequestParams  sharedParams].payment_id_wallet isEqualToString:@""] || [MPOSRequestParams  sharedParams].payment_id_wallet==NULL ) {
//            paymentID=[MPOSRequestParams  sharedParams].payment_id;
//        } else {
//            paymentID=[MPOSRequestParams  sharedParams].payment_id_wallet;
//        }
//        
//        if( [_paymentMode caseInsensitiveCompare:@"wallet"] == NSOrderedSame) {
//            [self fetchResponsefromPostPayment:Post_Payment_URL isPost:YES body:[PUMServiceParameters prepareBodyForPostPayment:paymentID] tag:SDK_REQUEST_POST_PAYMENT isAccessTokenRequired:YES];
//        }else{
//            [self requestVerifyPayment:CHECK_PAYMENT_DETAILS_STATUS isPost:YES body:[PUMServiceParameters prepareBodyForVerifyPayment:paymentID] tag:SDK_REQUEST_POST_PAYMENT isAccessTokenRequired:YES];
//        }
//    }
    return YES;
}

-(void)fetchResponsefromPostPayment : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody  tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired
{
    
    if ([MPOSReachability isInternetReachable]) {
        
        MPOSRequestManager *requestManager = [[MPOSRequestManager alloc]init];
        [requestManager hitWebServiceForURLWithPostBlock:type isAccessTokenRequired:tokenRequired webServiceURL:strURL withBody:strBody andTag:tag completionHandler:^(id object, SDK_REQUEST_TYPE tag, NSError *error, NSHTTPURLResponse *response) {
          
          if(error == nil){
            [MPOSActivityView removeViewAnimated:YES];
            NSMutableDictionary *responseObject = (NSMutableDictionary*)object;
//            [[PUMAppConstant sharedInstance].dictCurrentTxn setValue:@""  forKey:KEY_PAYMENT_ID_LWALLET];

               if ([[responseObject objectForKey:@"status"] integerValue] == 0) { // Response recieved
                 // Payment Success Case
//                [self  paymentCompletedWithResponse:responseObject errorDescription:nil];
              }else{
                // Payment failure Case
//                [self paymentFailedWithResponse:responseObject errorDescription:nil];
              }
//              [PUMAppConstant resetPUMAppConstantSharedInstance];
           //   [MPOSRequestParams resetMPOSRequestParamsSharedInstance];

            }else{
              // Payment failure Case

                [MPOSActivityView removeViewAnimated:YES];
           //   [self paymentFailedWithResponse:nil errorDescription:error];
            }
        }];
    }
    else {
      // Network reachability error

        [MPOSActivityView removeViewAnimated:YES];
        [MPOSAlertController alertNoInternetConnectionAvailable];
    }
}

-(void)requestVerifyPayment : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody  tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired {
  
  if ([MPOSReachability isInternetReachable]) {
    
    MPOSRequestManager *requestManager = [[MPOSRequestManager alloc]init];
    [requestManager hitWebServiceForURLWithPostBlock:type isAccessTokenRequired:tokenRequired webServiceURL:strURL withBody:strBody andTag:tag completionHandler:^(id object, SDK_REQUEST_TYPE tag, NSError *error, NSHTTPURLResponse *response) {
      
//      [PUMAppConstant resetPUMAppConstantSharedInstance];
    //  [MPOSRequestParams resetMPOSRequestParamsSharedInstance];
      [MPOSActivityView removeViewAnimated:YES];

      if(error == nil){
        NSMutableDictionary *responseObject = (NSMutableDictionary*)object;
        if ([[responseObject objectForKey:@"status"] integerValue] == 0) { // Response recieved
          
          NSDictionary *dictResult = [responseObject objectForKey:@"result"];
          if ([dictResult isKindOfClass:[NSDictionary class]]) {
//            NSString *transactionStatus = [[PUMUtils checkNullValue:[dictResult valueForKey:@"status"]] lowercaseString];
//            if ([transactionStatus isEqualToString:@"success"]) {
//              // Payment Success Case
//              [self  paymentCompletedWithResponse:dictResult errorDescription:nil];
//            }
//            else{ // Payment Failure case
//              [self paymentFailedWithResponse:dictResult errorDescription:nil];
//            }
            
          }
        }
        else{ // API Failed
//          [self paymentFailedWithResponse:responseObject errorDescription:nil];
        }
      }
      else{ // Error in Network
//        [self paymentFailedWithResponse:nil errorDescription:error];
      }
    }];
  }
  else {
    // Network reachability error
    [MPOSActivityView removeViewAnimated:YES];
    [MPOSAlertController alertNoInternetConnectionAvailable];
  }
}

#pragma mark - Back Button Handling
-(void) onBackButtonPressed{
    if (!_backButtonAlert) { //iof alert controller not created yet, create it
        _backButtonAlert = [[MPOSAlertController alloc]
                            initWithTitle:@"Cancel Transaction"
                            message:@"Are you sure you want to cancel the transaction?"
                            positiveButtonText:@"Yes"
                            negativeButtonText:@"No" delegate:self];
        
    }
    
    [_backButtonAlert show];
}

#pragma mark - PUMAlertController Delegate
- (void)alertClosedByChoosingButton:(PUMAlertButtonType)buttonType {
  if (buttonType == PUMAlertButtonTypePositive) {
    //User wants to cancel the transaction
//    [self cancelTransaction];
    [self.webView stopLoading];
  }
}


#pragma mark- Payment Completion Methods
#pragma mark-
//
//-(void)cancelTransaction{
//  
//  NSString *requestBody = [PUMServiceParameters prepareBodyForCancelTransactionWithPaymentId:self.paymentId withStatus:@"1"];
//  [MPOSRequestManager cancelTransactionManuallyWithRequestBody:requestBody];
//  
//  // Merchant Controller instance
//  id delegate = [MPOSRequestParams sharedParams].delegate;
//  
//  if (delegate != nil && [delegate respondsToSelector:@selector(transactinCanceledByUser)] ) {
//    [delegate performSelector:@selector(transactinCanceledByUser) withObject:nil];
//  }
//  else{
////    PayULog(@"Delegate is nil. error occured");
//  }
//  
////  [PUMAppConstant resetPUMAppConstantSharedInstance];
//  [MPOSRequestParams resetMPOSRequestParamsSharedInstance];
//}

//
//-(void)paymentCompletedWithResponse:(NSDictionary*)response
//                   errorDescription:(NSError*)error{
//  // Merchant Controller instance
//  id delegate = [MPOSRequestParams sharedParams].delegate;
//  
//  if (delegate != nil && [delegate respondsToSelector:@selector(transactionCompletedWithResponse:errorDescription:)] ) {
//    [delegate performSelector:@selector(transactionCompletedWithResponse:errorDescription:) withObject:response withObject:error];
//  }
//  else{
//    PayULog(@"Delegate is nil. error occured");
//  }
////  [PUMAppConstant resetPUMAppConstantSharedInstance];
//  [MPOSRequestParams resetMPOSRequestParamsSharedInstance];
//  
//}

//
//-(void)paymentFailedWithResponse:(NSDictionary*)response
//                errorDescription:(NSError*)error{
//
//  // Merchant Controller instance
//  id delegate = [MPOSRequestParams sharedParams].delegate;
//  
//  if (delegate != nil && [delegate respondsToSelector:@selector(transactinFailedWithResponse:errorDescription:)] ) {
//    [delegate performSelector:@selector(transactinFailedWithResponse:errorDescription:) withObject:response withObject:error];
//  }
//  else{
//    PayULog(@"Delegate is nil. error occured");
//  }
////  [PUMAppConstant resetPUMAppConstantSharedInstance];
//  [MPOSRequestParams resetMPOSRequestParamsSharedInstance];
//  
//}




@end
