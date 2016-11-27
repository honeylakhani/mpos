//
//  MPOSBaseVC.m
//  PayUmoneyiOS_SDK
//
//  Created by Imran Khan on 6/17/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import "MPOSBaseVC.h"
#import "MPOSActivityView.h"
#import "MFSideMenu.h"
//#import "PUMAppConstant.h"
//#import "PUMRequestParams.h"
//#import "PUMServiceParameters.h"
#import "MPOSReachability.h"
//#import "PUMInternalConstants.h"
//#import "PUMUtils.h"
#import "MPOSAlertController.h"
#import <CommonCrypto/CommonDigest.h>
#import "MPOSRequestManager.h"


@implementation MPOSBaseVC {
    UINavigationBar *navBar;
    UINavigationItem *navItemLeft,*navItemCenter,*navItemRight;
}

@synthesize deviceHeight,deviceWidth;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    CGRect cgRect=[UIScreen mainScreen].bounds;
    deviceHeight=cgRect.size.height;
    deviceWidth=cgRect.size.width;
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor =COLOR_A5C339;
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  
    [self setUpImageBackButton];

    [self setNavBarTitleAsImage];
}

- (void)setupMenuBarButtonItems {
  if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
     ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
  } else {
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
  }
}

- (void)leftSideMenuButtonPressed:(id)sender {
  [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    [self setupMenuBarButtonItems];
  }];
}
- (UIBarButtonItem *)leftMenuBarButtonItem {
  return [[UIBarButtonItem alloc]
          initWithImage:[UIImage imageNamed:@"hamburger-white"] style:UIBarButtonItemStylePlain
          target:self
          action:@selector(leftSideMenuButtonPressed:)];
}

-(void) setTextTitleForNav:(NSString*) title{
  
}

- (void)setUpImageBackButton {  
  }


- (void)setUpLoginButton
{
}


-(void) setNavBarTitle{
  
}

-(void) setNavBarTitleAsImage{
  
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
  NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  
  // String should be 6 or 8 characters
  if ([cString length] < 6) return [UIColor grayColor];
  
  // strip 0X if it appears
  if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
  
  if ([cString length] != 6) return  [UIColor grayColor];
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];
  
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  // Scan values
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float) r / 255.0f)
                         green:((float) g / 255.0f)
                          blue:((float) b / 255.0f)
                         alpha:1.0f];
}


//added to remove redundancy of api call

-(void)fetchResponsefrom : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody  tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired
{
    
    if ([MPOSReachability isInternetReachable]) {
      UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
      [MPOSActivityView activityViewForView:[self view] withLabel:@""];
        MPOSRequestManager *requestManager = [[MPOSRequestManager alloc]init];
        [requestManager hitWebServiceForURLWithPostBlock:type isAccessTokenRequired:tokenRequired webServiceURL:strURL withBody:strBody andTag:tag completionHandler:^(id object, SDK_REQUEST_TYPE tag, NSError *error,NSHTTPURLResponse *httpResponse) {
         
            if(error == nil){
              [self parseResponse:object tag:tag];
            }
          
                else {
                    [MPOSActivityView removeViewAnimated:YES];
                    [MPOSAlertController alertUnknownError];
                }
          
          
        }
         
         ];
        [MPOSActivityView removeViewAnimated:YES];
    }
  else
  {
    
  }
  
}

-(void)parseResponse:(id)object tag:(SDK_REQUEST_TYPE)tag
{
    
}




@end
