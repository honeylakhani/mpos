//
//  MPOSAlertController.m
//  PayUmoney_SampleApp
//
//  Created by Vipin Aggarwal on 11/11/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import "MPOSAlertController.h"

@interface MPOSAlertController ()
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, weak, nullable) id <MPOSAlertControllerDelegate> delegate;
@end

@implementation MPOSAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[self alertWindow] setHidden:YES];
    [self setAlertWindow:nil];
}

- (void)show {
    [self showAnimated:YES];
}

- (void)showAnimated:(BOOL)animated {
    UIViewController *blankViewController = [[UIViewController alloc] init];
    [[blankViewController view] setBackgroundColor:[UIColor clearColor]];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:blankViewController];
    [window setBackgroundColor:[UIColor clearColor]];
    [window setWindowLevel:UIWindowLevelAlert + 1];
    [window makeKeyAndVisible];
    [self setAlertWindow:window];
    
    [blankViewController presentViewController:self animated:animated completion:nil];
}

+ (void)presentOkayAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    MPOSAlertController *alertController = [MPOSAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okayAction];
    
    [alertController show];
}

+ (void)alertNoInternetConnectionAvailable {
    [[self class] presentOkayAlertWithTitle:@"No Internet Connection" message:@"You don’t have internet connection. Please check your connectivity."];
}

+ (void)alertUnknownError {
    [[self class] presentOkayAlertWithTitle:@"Something went wrong" message:@"Please try again"];
}

- (nullable instancetype)initWithTitle:(NSString* _Nonnull )title
                               message:(NSString* _Nonnull)message
                    positiveButtonText:(NSString* _Nonnull)positiveButtonText
                    negativeButtonText:(NSString* _Nullable)negativeButtonText
                              delegate:(id<MPOSAlertControllerDelegate> _Nullable)delegate{
    
    MPOSAlertController *alertController = [MPOSAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert];

    self.delegate = delegate;
    UIAlertAction *positiveAction = [UIAlertAction actionWithTitle:positiveButtonText
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [self.delegate alertClosedByChoosingButton:PUMAlertButtonTypePositive];
                                                           }];
    
    UIAlertAction *negativeAction = [UIAlertAction actionWithTitle:negativeButtonText
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [self.delegate alertClosedByChoosingButton:PUMAlertButtonTypeNegative];
                                                           }];
    [alertController addAction:positiveAction];
    [alertController addAction:negativeAction];
    
    return alertController;
}

@end
