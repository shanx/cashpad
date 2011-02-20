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
#import "ButtonGridViewDelegate.h"
#import "CheckoutViewControllerDelegate.h"

@class ButtonGridView;
@class ReceiptView;
@class PaymentSession;

@interface MainViewController : UIViewController <GKPeerPickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, ButtonGridViewDelegate, CheckoutViewControllerDelegate>
{
	IBOutlet UIPageControl *productsPageControl;
	IBOutlet ButtonGridView *categoriesGridView;
	IBOutlet ButtonGridView *productsGridView;
	IBOutlet ReceiptView* receiptView;
	IBOutlet UIButton *category1;
	IBOutlet UIButton *category2;
	IBOutlet UIButton *category3;
	IBOutlet UIButton *category4;
	NSMutableArray *categories;
	NSInteger selectedCategoryIndex;
	PaymentSession *paymentSession;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) ReceiptView* receiptView;

- (IBAction)sendPaymentRequest:(id)sender;
- (IBAction)pay:(id)sender;
- (IBAction)category:(id)sender;
- (IBAction)pageControlValueChanged:(id)sender;
- (IBAction)connect:(id)sender;

@end
