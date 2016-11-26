//
//  PayuRequestManager.h
//  PayuMoney
//
//  Created by Imran Khan on 10/5/15.
//  Copyright © 2015 PayuMoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPOSConstants.h"
@interface MPOSRequestManager : NSObject<NSURLSessionDataDelegate>

-(void)hitWebServiceForURLWithPostBlock:(BOOL)isPost isAccessTokenRequired:(BOOL)tokenRequired webServiceURL:(NSString *)apiURL withBody:(NSString *)requestBody andTag:(SDK_REQUEST_TYPE)tag completionHandler:(void (^)(id, SDK_REQUEST_TYPE, NSError *,NSHTTPURLResponse *))callback;
@end
