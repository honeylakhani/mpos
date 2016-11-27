//
//  RequestParams.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/12/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "MPOSRequestParams.h"

@implementation MPOSRequestParams
static MPOSRequestParams *params = nil;
+(MPOSRequestParams *)sharedParams {
  if(params == nil)
  {
    static dispatch_once_t once;
  
    
    dispatch_once(&once, ^{
        params = [[self alloc] init];
        params = [[MPOSRequestParams alloc]init];
        params.responseNetBankingDetails=[[NSMutableArray alloc] init];
        params.emiBanksDetails=[[NSMutableDictionary alloc] init];
        params.userConfigDTO=[[NSMutableDictionary alloc] init];
        params.userSaveCards=[[NSMutableArray alloc] init];
        params.merchantTypeWalletOnly=false;
        params.isWalletEnabled=NO;
        params.isLoadWalletEnabled=NO;
        params.isMerchantIsHighRisk=NO;
        params.total_amount_need_to_pay=0.0;
        params.payment_id=@"";
        params.public_key=@"";
        params.payment_id_wallet=@"";
        params.logo_url=@"";
        params.merchant_display_name=@"";
    });
  }
    return params;
}

+(void) resetPUMRequestParamsSharedInstance{

    MPOSRequestParams *requestParams = [[self class] sharedParams];
//    requestParams.environment =;
    requestParams.email = nil;
    requestParams.logo_url = nil;
    requestParams.firstname = nil;
    requestParams.productinfo = nil;
    requestParams.txnid = nil;
    requestParams.merchantid = nil;
    requestParams.merchant_display_name = nil;
    requestParams.surl = nil;
    requestParams.furl = nil;
    requestParams.phone = nil;
    requestParams.amount = nil;
    requestParams.payment_id = nil;
    requestParams.payment_id_wallet = nil;
    requestParams.public_key = nil;
    
    requestParams.hashValue = nil;
    requestParams.key = nil;
    requestParams.response = nil;
    requestParams.emiBanksDetails = nil;
    requestParams.userConfigDTO = nil;
    requestParams.responseNetBankingDetails = nil;
    requestParams.userSaveCards = nil;
    requestParams.availableCreditCards = nil;
    requestParams.availableDebitCards = nil;
    requestParams.merchantTypeWalletOnly = NO;
    requestParams.isWalletEnabled = NO;
    requestParams.isLoadWalletEnabled = NO;
    requestParams.isMerchantIsHighRisk = NO;
    requestParams.total_amount_need_to_pay = 0;
    
    requestParams.udf1 = nil;
    requestParams.udf2 = nil;
    requestParams.udf3 = nil;
    requestParams.udf4 = nil;
    requestParams.udf5 = nil;
    requestParams.udf6 = nil;
    requestParams.udf7 = nil;
    requestParams.udf8 = nil;
    requestParams.udf9 = nil;
    requestParams.udf10 = nil;

}
@end
