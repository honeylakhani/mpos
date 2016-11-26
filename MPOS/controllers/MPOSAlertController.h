//
//  MPOSAlertController.h
//  PayUmoney_SampleApp
//
//  Created by Vipin Aggarwal on 11/11/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PUMAlertButtonType) {
    PUMAlertButtonTypePositive,
    PUMAlertButtonTypeNegative
};

@protocol MPOSAlertControllerDelegate <NSObject>
- (void)alertClosedByChoosingButton:(PUMAlertButtonType)buttonType;
@end

@interface MPOSAlertController : UIAlertController

/*!
 * Present alert window (using new UIAlertController class) without knowing the presenting view controller
 */
+ (void)presentOkayAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

/*!
 * This method shows error alter with message of no internet connection
 */
+ (void)alertNoInternetConnectionAvailable;

/*!
 * This method shows generic error message in an alert
 */
+ (void)alertUnknownError;

/*!
 * Use below method to create alert contrller to receive the callback about tapped button
 */
- (nullable instancetype)initWithTitle:(NSString* _Nonnull )title
                               message:(NSString* _Nonnull)message
                    positiveButtonText:(NSString* _Nonnull)positiveButtonText
                    negativeButtonText:(NSString* _Nullable)negativeButtonText
                              delegate:(id<MPOSAlertControllerDelegate> _Nullable)delegate;

/*!
 * Show the alert 
 */
- (void)show;



@end
