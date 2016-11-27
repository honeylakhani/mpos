//
//  MPOSRequestPaymentVC.m
//  MPOSSellerApp
//
//  Created by Umang Arya on 11/26/16.
//  Copyright © 2016 Umang Arya. All rights reserved.
//

#import "MPOSRequestPaymentVC.h"
#import "MPOSRequestParams.h"
#import <ChirpSDK/ChirpSDK.h>
#import "MPOSSSKeychain.h"
@interface MPOSRequestPaymentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
  UITextField *txtFldName,*txtFldPhone;
}
@end

@implementation MPOSRequestPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
  [[ChirpSDK sdk] setAppKey:CHIRP_APP_KEY andSecret:CHIRP_APP_SECRET withCompletion:nil];
  
  
  [[ChirpSDK sdk] setChirpHeardBlock:^(Chirp *chirp, NSError *error)
   {
     if (!error && chirp)
     {
       [chirp fetchAssociatedDataWithCompletion:^(Chirp *chirp, NSError *error) {
         NSDictionary *data = [chirp data];
         NSString *body = data[@"text"];
//         self.textViewReceiver.text = body;
       }];
       
     }
     else
     {
       NSLog(@"Error: %@", error);
     }
   }];
}

- (IBAction)sendMessage
{
  NSString *strBody;
  NSError *err;
  MPOSRequestParams *params = [MPOSRequestParams sharedParams];
  NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:params.surl,params.furl,params.email,params.phone, nil] forKeys:[NSArray arrayWithObjects:@"surl",@"furl",@"email",@"phone", nil]];
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted
                                                       error:&err];
  NSString *stt = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
  //NSLog(@"url json ==== %@     %@",[jsonData description],stt);
  
 
  
  NSString *guestCheckout=@"false";

  strBody = [NSString stringWithFormat:@"key=%@&amount=%@&txnid=%@&email=%@&firstname=%@&udf1=%@&udf2=%@&udf3=%@&udf4=%@&udf5=%@&hash=%@&deviceId=%@&paymentParts=%@&paymentIdentifiers=%@&purchaseFrom=%@&txnDetails=%@&productinfo=%@&guestCheckout=%@",params.key,params.amount,params.txnid,params.email,params.firstname,params.udf1,params.udf2,params.udf3,params.udf4,params.udf5,params.hashValue,[self appUniqueID],@"[]",@"[]",@"merchant-app",stt,params.productinfo,guestCheckout];
  
  NSLog(@"prepareBodyForCreatePayment strBody :: %@",strBody);
  NSDictionary *data  = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:strBody,txtFldPhone.text, nil] forKeys:[NSArray arrayWithObjects:@"Post Data",@"Phone", nil]];
  
  [Chirp createChirpWithAssociatedData:data andCompletion:^(Chirp *chirp, NSError *error) {
    [chirp chirp];
  }];
  
}
-(NSString*) appUniqueID{
  // getting the unique key (if present ) from keychain , assuming "your app identifier" as a key
  NSString *retrieveuuid = [MPOSSSKeychain passwordForService:SDK_BUNDLE_IDENTIFIER account:SDK_KEYCHAIN_ACCOUNT_KEY];
  if (retrieveuuid == nil) { // if this is the first time app lunching , create key for device
    NSString *strudid  = [self stringUniqueID];
    // save newly created key to Keychain
    [MPOSSSKeychain setPassword:strudid forService:SDK_BUNDLE_IDENTIFIER account:SDK_KEYCHAIN_ACCOUNT_KEY];
    // this is the one time process
  }
  
  NSString  *uniqueID = [MPOSSSKeychain passwordForService:SDK_BUNDLE_IDENTIFIER account:SDK_KEYCHAIN_ACCOUNT_KEY];
  
  //NSLog(@"PayuMoneyUniqueID = %@",uniqueID);
  
  return uniqueID;
}

- (NSString *)stringUniqueID {
  
  CFUUIDRef theUUID = CFUUIDCreate(NULL);
  CFStringRef string = CFUUIDCreateString(NULL, theUUID);
  CFRelease(theUUID);
  return (__bridge NSString *)string ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn setTitle:@"Send Request" forState:UIControlStateNormal];
  [btn setFrame:CGRectMake(view.frame.size.width/2-100, view.frame.size.height/2-20, 200, 40)];
  [btn addTarget:self action:@selector(btnSendPaymentClicked) forControlEvents:UIControlEventTouchUpInside];
  [btn setBackgroundColor:[self colorWithHexString:@"01BED0"]];
  [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [view addSubview:btn];
  [view setBackgroundColor:[UIColor whiteColor]];
  return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.row == 3?120:75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell;
  if(indexPath.row == 0)
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell1"];
  else if(indexPath.row == 1 || indexPath.row == 2)
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell2"];
  else
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    
  if(cell == nil)
  {
    if(indexPath.row == 0)
    {
      cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
      cell.textLabel.text = @"Enter Customer Details";
      cell.textLabel.textAlignment = NSTextAlignmentCenter;

    }
    else if(indexPath.row == 3)
    {
      cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell3"];
      cell.textLabel.text = [NSString stringWithFormat:@"Products: %@",_totalQty];
      cell.detailTextLabel.text = [NSString stringWithFormat:@"Amount: %@",_totalAmt];
    }
    else
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    
  }
  [[cell.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
  if(indexPath.row == 1)
  {
      txtFldName = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-40, cell.frame.size.height-20)];
      txtFldName.placeholder = @"Name";
    txtFldName.delegate = self;
      [cell.contentView addSubview:txtFldName];
  }
  if(indexPath.row == 2)
  {
    txtFldPhone = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-40, cell.frame.size.height-20)];
    txtFldPhone.placeholder = @"Phone No";
    txtFldPhone.delegate = self;
    [cell.contentView addSubview:txtFldPhone];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}
-(void)btnSendPaymentClicked
{
  [self sendMessage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
