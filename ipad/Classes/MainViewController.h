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

@interface MainViewController : UIViewController <GKPeerPickerControllerDelegate, UITableViewDelegate, UITableViewDataSource> 
{
	IBOutlet UITableView *receiptTableView;
	NSMutableArray *products;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
