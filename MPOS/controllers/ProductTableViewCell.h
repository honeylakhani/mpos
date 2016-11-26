//
//  ProductTableViewCell.h
//  MPOS
//
//  Created by Honey Lakhani on 11/26/16.
//  Copyright © 2016 com.payu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txtFldProductName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldQty;
@property (weak, nonatomic) IBOutlet UITextField *txtFldAmt;

@end
