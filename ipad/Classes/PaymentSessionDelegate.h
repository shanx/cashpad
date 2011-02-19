//
//  PaymentSessionDelegate.h
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaymentSession;
@class PaymentRequest;

@protocol PaymentSessionDelegate <NSObject>

- (void)paymentSession:(PaymentSession *)session didReceivePaymentRequest:(PaymentRequest *)request;

@end
