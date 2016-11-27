//
//  MPOSRequestPaymentVC.h
//  MPOSSellerApp
//
//  Created by Umang Arya on 11/26/16.
//  Copyright © 2016 Umang Arya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOSBaseVC.h"
@interface MPOSRequestPaymentVC : MPOSBaseVC
@property (weak, nonatomic) IBOutlet UITableView *tblVw;
@property(strong,nonatomic) NSString *totalQty,*totalAmt;
@end
