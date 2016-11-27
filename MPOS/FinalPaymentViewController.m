//
//  FinalPaymentViewController.m
//  MPOS
//
//  Created by Honey Lakhani on 11/27/16.
//  Copyright © 2016 com.payu. All rights reserved.
//

#import "FinalPaymentViewController.h"
#import <ChirpSDK/ChirpSDK.h>
#import "SuccessViewController.h"
#import "FailureViewController.h"
@interface FinalPaymentViewController ()

@end

@implementation FinalPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [[ChirpSDK sdk] setChirpHeardBlock:^(Chirp *chirp, NSError *error)
   {
     if (!error && chirp)
     {
       [chirp fetchAssociatedDataWithCompletion:^(Chirp *chirp, NSError *error) {
         NSDictionary *data = [chirp data];
         if([[data valueForKey:@"phone"]isEqualToString:self.custPhone])
         {
           NSString *status = [data valueForKey:@"status"];
           if([status isEqualToString:@"success"])
           {
             SuccessViewController *vc = [[SuccessViewController alloc]init];
             [self.navigationController pushViewController:vc animated:YES];
           }
          else
           {
             FailureViewController *vc = [[FailureViewController alloc]init];
             [self.navigationController pushViewController:vc animated:YES];
           }

         }
        
       }];
       
     }
     else
     {
       NSLog(@"Error: %@", error);
     }
   }];
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

@end
