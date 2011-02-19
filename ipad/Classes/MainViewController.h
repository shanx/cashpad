//
//  MainViewController.h
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GameKit/GameKit.h>
#import "PaymentSessionDelegate.h"
#import "ButtonGridViewDelegate.h"

@class PaymentSession;
@class ButtonGridView;

@interface MainViewController : UIViewController <GKPeerPickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, PaymentSessionDelegate, ButtonGridViewDelegate>
{
	IBOutlet UITableView *receiptTableView;
	IBOutlet ButtonGridView *categoriesGridView;
	IBOutlet ButtonGridView *productsGridView;
	NSMutableArray *products;
	PaymentSession *paymentSession;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)sendPaymentRequest:(id)sender;

@end
