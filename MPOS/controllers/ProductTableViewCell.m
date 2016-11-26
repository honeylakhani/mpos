//
//  ProductTableViewCell.m
//  MPOS
//
//  Created by Honey Lakhani on 11/26/16.
//  Copyright © 2016 com.payu. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "MPOSConstants.h"
@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  UILabel *lblRightVw = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
  lblRightVw.font = FONT_NORMAL(10.0);
  lblRightVw.text = @"/Unit";
  self.txtFldAmt.rightView = lblRightVw;
  self.txtFldAmt.rightViewMode = UITextFieldViewModeAlways;
  self.txtFldProductName.inputAccessoryView = [self designKeyboardToolbar];
  self.txtFldQty.inputAccessoryView = [self designKeyboardToolbar];
  self.txtFldAmt.inputAccessoryView = [self designKeyboardToolbar];
}
-(UIToolbar *)designKeyboardToolbar{
UIToolbar *toolBarItemKeyboard = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
toolBarItemKeyboard.items = [NSArray arrayWithObjects:
                             [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelKeyboard)],
                             [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithKeyboard)],
                             nil];
  return toolBarItemKeyboard;
}
-(void)cancelKeyboard
{
  [self.txtFldQty resignFirstResponder];
  [self.txtFldAmt resignFirstResponder];
  [self.txtFldProductName resignFirstResponder];
}
-(void)doneWithKeyboard
{
  [self.txtFldQty resignFirstResponder];
  [self.txtFldAmt resignFirstResponder];
  [self.txtFldProductName resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
