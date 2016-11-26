//
//  PayuRequestManager.m
//  PayuMoney
//
//  Created by Imran Khan on 10/5/15.
//  Copyright © 2015 PayuMoney. All rights reserved.
//

#import "MPOSRequestManager.h"
//#import "PUMAppConstant.h"
//#import "PUMRequestParams.h"
#import "MPOSReachability.h"
//#import "PUMInternalConstants.h"
//#import "PUMUtils.h"

#define REQUEST_TIMEOUT 60.0
#define baseURL @""
@implementation MPOSRequestManager
    
-(void)hitWebServiceForURLWithPostBlock:(BOOL)isPost isAccessTokenRequired:(BOOL)tokenRequired webServiceURL:(NSString *)apiURL withBody:(NSString *)requestBody andTag:(SDK_REQUEST_TYPE)tag completionHandler:(void (^)(id, SDK_REQUEST_TYPE, NSError *,NSHTTPURLResponse *))callback
{
   
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
  
    NSString *strMainURL = [NSString stringWithFormat:@"%@%@", baseURL, apiURL];
    NSLog(@"SERVICE URL = %@",requestBody);
    strMainURL = [strMainURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   // NSLog(@"SERVICE URL = %@",strMainURL);

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL
                                                                            URLWithString:strMainURL]];
    [urlRequest setHTTPMethod:isPost?@"POST":@"GET"];
    
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"*/*" forHTTPHeaderField:@"Accept"];
  //  [urlRequest setValue:USER_AGENT_FOR_SELLER_APP forHTTPHeaderField:@"User-Agent"];
  
    
    if (isPost) {
        
        
        [urlRequest setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //9873030220
    //if(tokenRequired)
   // {
     //   NSString *strAccessToken=[[PUMAppConstant sharedInstance] accessToken];
        
       // if (strAccessToken.length>2) {
         //   NSString *accessTokenForAuthorization = [NSString stringWithFormat:@"Bearer %@",strAccessToken];
           // NSLog(@"urlRequest accessTokenForAuthorization :: %@",accessTokenForAuthorization);
             //TODO
            //[urlRequest setValue:accessTokenForAuthorization forHTTPHeaderField:@"Authorization"];
        //}

    //}
  
    NSLog(@"urlRequest :: %@",[urlRequest description]);
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse*)response;
                                                           
                                                           NSLog(@"SERVER RESPONSE = %@",httpResponse.description);

                                                           if(error ==  nil){
                                                               NSError *parserError = nil;
                                                               id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parserError];
                                                               NSLog(@"Response:%@", object);

                                                               if(parserError == nil){
                                                                   callback(object,tag,error,httpResponse);
                                                               }
                                                               else{
                                                                   NSLog(@"Parser Error:%@", parserError.localizedDescription);

                                                                   callback(nil,tag,parserError,httpResponse);
                                                               }
                                                           }
                                                           else{
                                                               NSLog(@"Server Error:%@", error.localizedDescription);
                                                               callback(nil,tag,error,httpResponse);
                                                           }

                                                       }];
    [dataTask resume];
    
}




+ (NSString *) appVersionNew
{
    return [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}
@end
