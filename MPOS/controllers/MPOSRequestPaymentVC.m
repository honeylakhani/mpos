//
//  MPOSRequestPaymentVC.m
//  MPOSSellerApp
//
//  Created by Umang Arya on 11/26/16.
//  Copyright © 2016 Umang Arya. All rights reserved.
//

#import "MPOSRequestPaymentVC.h"

@interface MPOSRequestPaymentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation MPOSRequestPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return tableView.frame.size.height - (120+3*75);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height-(120+3*75))];
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn setTitle:@"Send Request" forState:UIControlStateNormal];
  [btn setFrame:CGRectMake(view.frame.size.width/2-100, view.frame.size.height/2-20, 200, 40)];
  [btn addTarget:self action:@selector(btnSendPaymentClicked) forControlEvents:UIControlEventTouchUpInside];
  [btn setBackgroundColor:[self colorWithHexString:@"01BED0"]];
  [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [view addSubview:btn];
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
       UITextField *txtfld = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-40, cell.frame.size.height-20)];
      txtfld.placeholder = @"Name";
    txtfld.delegate = self;
      [cell.contentView addSubview:txtfld];
  }
  if(indexPath.row == 2)
  {
    UITextField *txtfld = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, tableView.frame.size.width-40, cell.frame.size.height-40)];
    txtfld.placeholder = @"Phone No";
    txtfld.delegate = self;
    [cell.contentView addSubview:txtfld];
  }
  
  
  return cell;
}
-(void)btnSendPaymentClicked
{
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
