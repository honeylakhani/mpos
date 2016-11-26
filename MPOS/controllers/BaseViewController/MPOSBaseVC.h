//
//  MPOSBaseVC.h
//  PayUmoneyiOS_SDK
//
//  Created by Imran Khan on 6/17/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOSConstants.h"

@interface MPOSBaseVC : UIViewController<UIAlertViewDelegate> {
    BOOL  isUserLoggedIn;
}

@property CGFloat deviceHeight,deviceWidth;

- (void)setUpLoginButton;
- (void)setUpImageBackButton;
-(UIColor*)colorWithHexString:(NSString*)hex;


- (void)setTextTitleForNav:(NSString*) title;



- (void)fetchResponsefrom : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody  tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired;


@end
