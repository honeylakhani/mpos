//
//  LoginSingupVC.m
//  mPOSBuyerApp
//
//  Created by Umang Arya on 11/26/16.
//  Copyright © 2016 Umang Arya. All rights reserved.
//

#import "MPOSLoginSingupVC.h"

#import "MPOSCreateOrderVC.h"

#import "MPOSDashboardVC.h"
#import "MPOSAlertController.h"
@interface MPOSLoginSingupVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtFldUserName;

@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;



@end

@implementation MPOSLoginSingupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
//    [atextView  setTextContainerInset:UIEdgeInsetsMake(7, 7, 0, 0)];
    // Do any additional setup after loading the view from its nib.
  [self dismissKeyboardOnTapOutsideTextField];
}

-(void)setUpViews{
    self.navigationController.navigationBar.hidden = NO;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.txtFldPassword.leftView = paddingView;
    self.txtFldPassword.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.txtFldUserName.leftView = paddingView2;
    self.txtFldUserName.leftViewMode = UITextFieldViewModeAlways;
    

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


- (IBAction)bnClickedLogin:(id)sender {

  if(![self.txtFldUserName hasText] || ![self.txtFldPassword hasText])
    
  {
    
  }
  else
  {
    [self fetchResponsefrom:@"/v1/user/login" isPost:YES body:[NSString stringWithFormat:@"user_name=%@&passwd=%@",self.txtFldUserName.text,self.txtFldPassword.text] tag:LOGIN isAccessTokenRequired:NO];
  }
  
    

}
-(void)parseResponse:(NSDictionary *)object tag: (SDK_REQUEST_TYPE)tag
{
  if(tag == LOGIN)
  {
    
    if([[object valueForKey:@"login_message"] isEqualToString:@"Success"])
    {
      self.phone = [object valueForKey:@"u_phone"];
      UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"MPOSMain" bundle:nil];
      MPOSDashboardVC * dashBrdVC = [storybrd instantiateInitialViewController];
      [self.navigationController pushViewController:dashBrdVC animated:YES];
    }
    else
    {
      [MPOSAlertController presentOkayAlertWithTitle:@"PayX" message:@"Invalid Credentials"];
    }
   
  }
}
- (IBAction)btnClickedForgotPassword:(id)sender {
}

@end
