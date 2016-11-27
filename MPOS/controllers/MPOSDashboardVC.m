//
//  MPOSDashboardVC.m
//  MPOSSellerApp
//
//  Created by Umang Arya on 11/26/16.
//  Copyright © 2016 Umang Arya. All rights reserved.
//

#import "MPOSDashboardVC.h"
#import "MPOSCreateOrderVC.h"
#import "MPOSRequestParams.h"
#import <CommonCrypto/CommonDigest.h>
@interface MPOSDashboardVC ()
{
  MPOSRequestParams *params;
}
@end

@implementation MPOSDashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
params = [MPOSRequestParams sharedParams];
  params.key= @"mdyCKV";
  params.merchantid=@"4914106";
  params.txnid = [NSString stringWithFormat:@"0nf7%@",[self getRandomString:2]];
  params.surl = @"https://www.payumoney.com/mobileapp/payumoney/success.php";
  params.furl = @"https://www.payumoney.com/mobileapp/payumoney/failure.php";
  
  params.udf1 = @"";
  params.udf2 = @"";
  params.udf3 = @"";
  params.udf4 = @"";
  params.udf5 = @"";
  params.udf6 = @"";
  params.udf7 = @"";
  params.udf8 = @"";
  params.udf9 = @"";
  params.udf10 = @"";
  params.productinfo = @"product_info";
  params.email = @"hl@yopmail.com";
  params.phone = @"9837489759";

    // Do any additional setup after loading the view.
}
- (NSString *)getRandomString:(NSInteger)length
{
  NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
  
  NSString *numbers = @"0123456789";
  
  // First number cannot be 0
  [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
  
  for (int i = 1; i < length; i++) {
    [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
  }
  
  return returnString;
}
-(void)generateHashForProdAndNavigateToSDK{
  NSString *hashSequence = [NSString stringWithFormat:@"mdyCKV|%@|%@|%@|%@|%@|||||||||||Je7q3652",params.txnid,params.amount,params.productinfo,params.firstname,params.email];
  
  NSString *hash = [[[[[self createSHA512:hashSequence] description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
  
  params.hashValue = hash;
 
}

- (NSData *) createSHA512:(NSString *)source {
  
  const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
  
  NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
  
  uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
  
  CC_SHA512(keyData.bytes, (CC_LONG)keyData.length, digest);
  
  NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
  NSLog(@"out --------- %@",output);
  return output;
}


-(void)setupVies{
    self.navigationController.title = @"HOME";
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnClickedRequestPayment:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MPOSCreateOrderVC class])] animated:nil];
    
}

@end
