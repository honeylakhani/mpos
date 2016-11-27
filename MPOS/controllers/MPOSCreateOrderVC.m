//
//  MPOSCreateOrderVC.m
//  MPOSSellerApp
//
//  Created by Umang Arya on 11/26/16.
//  Copyright © 2016 Umang Arya. All rights reserved.
//

#import "MPOSCreateOrderVC.h"
#import "ProductTableViewCell.h"
#import "MPOSRequestPaymentVC.h"
#define cellHeight 100
#define kTableFooterHeight 120
#define kgentag 1000
@interface MPOSCreateOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
  UITableView *_tblVw;
  int noOfRows;
  ProductTableViewCell *_cellProduct;
  UIView *vwFooter;
  UILabel *lblTotalAmt;
  double totalAmt;
  int totalQty;
}
@end

@implementation MPOSCreateOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
  [self designTableView];
  noOfRows = 1;
  self.title = @"ADD ORDER";
  
  
}
-(void)designTableView
{
  CGFloat tableVwHeight = CGRectGetHeight(self.view.frame)-kTableFooterHeight;
  _tblVw = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), tableVwHeight) style:UITableViewStylePlain];
  _tblVw.delegate = self;
  _tblVw.dataSource = self;
  [self.view addSubview:_tblVw];
  [_tblVw setBackgroundColor:[UIColor whiteColor]];
  [_tblVw registerClass:[ProductTableViewCell class] forCellReuseIdentifier:@"cell"];
  [_tblVw registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
  vwFooter = [self designNewFooterView];
  CGRect frameOfFooter = vwFooter.frame;
  frameOfFooter.origin.y = _tblVw.frame.origin.y + _tblVw.frame.size.height;
  vwFooter.frame = frameOfFooter;
  [self.view addSubview:vwFooter];
//  _tblVw.separatorColor = [UIColor whiteColor];
}
-(UIView*)designNewFooterView

{
  
  UIView *vwFooterForVat = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tblVw.frame), kTableFooterHeight)];
  vwFooterForVat.backgroundColor = [UIColor whiteColor];
  vwFooterForVat.layer.shadowOffset = CGSizeMake(0.0, 1.0);
  vwFooterForVat.layer.shadowColor = [UIColor brownColor].CGColor;
  vwFooterForVat.layer.shadowRadius = 3;
  vwFooterForVat.layer.shadowOpacity = 0.5;
  vwFooterForVat.layer.masksToBounds = NO;
  
  CGFloat xpos = 20;
  
  CGFloat ypos = 15;
  
  CGFloat width = vwFooterForVat.frame.size.width/2 - 40;
  
  CGFloat heightBtn = 30;
  
  UILabel *lblTotalText = [[UILabel alloc]initWithFrame:CGRectMake(xpos, ypos,width, heightBtn)];
  [lblTotalText setText:@"Grand Total"];
  lblTotalText.font = FONT_NORMAL(16);
 
  lblTotalText.textAlignment = NSTextAlignmentLeft;
  [vwFooterForVat addSubview:lblTotalText];
  
  xpos = vwFooterForVat.frame.size.width/2 - 10;
  
  lblTotalAmt =[[UILabel alloc]initWithFrame:CGRectMake(xpos, ypos,width, heightBtn)];
  [lblTotalAmt setText:@"0"];
  lblTotalAmt.font = FONT_NORMAL(16);
  
  lblTotalAmt.textAlignment = NSTextAlignmentRight;
  [vwFooterForVat addSubview:lblTotalAmt];
  
  
  xpos = 20;
  
 
  
  //  width = vwFooterForVat.frame.size.width/2 - 10;
  
  //  heightBtn = 30;
    [self updateTotalAmountValue];
 
  
  ypos +=heightBtn+20;
  UIButton *btnSendBill;
  btnSendBill = [UIButton buttonWithType:UIButtonTypeCustom];
  [btnSendBill setTitle:@"PROCEED" forState:UIControlStateNormal];
  [btnSendBill addTarget:self action:@selector(btnSendBillClicked) forControlEvents:UIControlEventTouchUpInside];
  btnSendBill.frame = CGRectMake(CGRectGetWidth(vwFooterForVat.frame)/2 - 100, ypos, 200, 40);
  [btnSendBill setBackgroundColor:[self colorWithHexString:@"01BED0"]];
  btnSendBill.titleLabel.font = FONT_NORMAL(14.0);
  [btnSendBill setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  btnSendBill.clipsToBounds = YES;
  [vwFooterForVat addSubview:btnSendBill];
  
  return vwFooterForVat;
}
-(void)btnSendBillClicked
{
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MPOSMain" bundle:[NSBundle mainBundle]];
  
  MPOSRequestPaymentVC *vc = [sb instantiateViewControllerWithIdentifier:@"requestPayment"];
  vc.totalQty =[NSString stringWithFormat:@"%d",totalQty];
  vc.totalAmt = [NSString stringWithFormat:@"%0.2lf",totalAmt];
  [self.navigationController pushViewController:vc animated:YES];
}
-(void)updateTotalAmountValue
{
  lblTotalAmt.text = [NSString stringWithFormat:@"%@%0.2lf",RUPEES_SIGN_TEXT,totalAmt];
}
#pragma mark -  table view methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return noOfRows;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
  _cellProduct = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  _cellProduct.txtFldProductName.delegate = self;
  _cellProduct.txtFldAmt.delegate = self;
  _cellProduct.txtFldQty.delegate = self;
  _cellProduct.txtFldProductName.tag = (kgentag*2)+indexPath.row;
  _cellProduct.txtFldQty.tag = (kgentag*3)+indexPath.row;
  _cellProduct.txtFldAmt.tag = (kgentag*4)+indexPath.row;
  return  _cellProduct;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return noOfRows == 1?NO: YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_tblVw beginUpdates];
    noOfRows--;
    [_tblVw deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [_tblVw endUpdates];
    
  }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
  
 
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
 
  NSUInteger txtfldNo  = textField.tag/kgentag;
  if(txtfldNo == 4)
  {
//    [self navigateVATViewToUpSide:NO];
    totalAmt+=[textField.text doubleValue];
    [self updateTotalAmountValue];
    
  }
  else if (txtfldNo == 3)
  {
    totalQty+=[textField.text intValue];
    
  }
  if (txtfldNo == 2) {
    if([textField hasText])
    {
    NSUInteger row  = textField.tag%kgentag;
    if(row == noOfRows-1)
    {
      [_tblVw beginUpdates];
      noOfRows++;
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:noOfRows-1 inSection:0];
      [_tblVw insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
      [_tblVw endUpdates];
    }
  }
  }
  [self.view endEditing:YES];
  return;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
