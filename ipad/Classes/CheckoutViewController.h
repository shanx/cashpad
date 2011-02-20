//
//  CheckoutViewController.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 20-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentSessionDelegate.h"

@class Order;
@class PaymentSession;
@protocol CheckoutViewControllerDelegate;

@interface CheckoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PaymentSessionDelegate, UIAlertViewDelegate> {
	IBOutlet UITableView *tableView;
	IBOutlet UILabel *amountLabel;
	NSArray *checkoutMethods;
	PaymentSession *paymentSession;
}

@property (nonatomic, assign) id <CheckoutViewControllerDelegate> delegate;
@property (nonatomic, retain) PaymentSession *paymentSession;
@property (nonatomic, retain) Order *order;

- (IBAction)mobile:(id)sender;

@end
