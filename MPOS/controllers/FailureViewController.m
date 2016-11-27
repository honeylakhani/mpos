//
//  FailureViewController.m
//  MPOS
//
//  Created by Honey Lakhani on 11/27/16.
//  Copyright © 2016 com.payu. All rights reserved.
//

#import "FailureViewController.h"

@interface FailureViewController ()

@end

@implementation FailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, self.view.frame.size.width - 20, 100)];
  lbl.text = @"Your payment failed!!!";
  [self.view addSubview:lbl];
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
