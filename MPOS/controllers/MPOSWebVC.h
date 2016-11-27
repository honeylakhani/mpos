//
//  WebViewViewController.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/9/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOSBaseVC.h"

@interface MPOSWebVC : MPOSBaseVC
@property NSString *paymentId;
@property NSString *urlString,*bodyParams,*type,*paymentMode;

@end
