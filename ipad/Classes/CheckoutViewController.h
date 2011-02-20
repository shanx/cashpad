//
//  CheckoutViewController.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 20-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CheckoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableView;
	NSArray *checkoutMethods;
}

@end
