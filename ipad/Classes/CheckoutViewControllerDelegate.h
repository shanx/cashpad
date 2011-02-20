//
//  CheckoutViewControllerDelegate.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 20-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckoutViewController;

@protocol CheckoutViewControllerDelegate

- (void)checkoutViewControllerDidCancel:(CheckoutViewController *)controller;
- (void)checkoutViewControllerDidFinish:(CheckoutViewController *)controller;

@end
