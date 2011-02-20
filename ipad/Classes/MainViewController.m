//
//  MainViewController.m
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "ProductTableViewCell.h"
#import "Product.h"
#import "PaymentSession.h"
#import "PaymentRequest.h"
#import "ButtonGridView.h"
#import "ReceiptTotalView.h"
#import "ReceiptView.h"

@implementation MainViewController

@synthesize managedObjectContext;
@synthesize receiptView;

- (id)init
{
	self = [super initWithNibName:@"MainView" bundle:nil];
	
	if (self) {
		products = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
}

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
	GKSession *session = [[[GKSession alloc] initWithSessionID:nil displayName:[UIDevice currentDevice].name sessionMode:GKSessionModePeer] autorelease];
	
	paymentSession = [[PaymentSession alloc] initWithGKSession:session];
	paymentSession.delegate = self;
	
	[picker dismiss];
	
	return session;
}

- (void)sendPaymentRequest:(id)sender
{
	PaymentRequest *request = [[PaymentRequest alloc] init];
	request.productDescription = @"Bier";
	request.amount = 20.0;
	[paymentSession sendPaymentRequest:request];
	[request release];
}

- (void)paymentSession:(PaymentSession *)session didDenyPaymentRequest:(PaymentRequest *)request
{
	DLog(@"payment denied");
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment denied" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)paymentSession:(PaymentSession *)session didAcceptPaymentRequest:(PaymentRequest *)request
{
	DLog(@"payment accepted");
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment accepted" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)peerPickerController:(GKPeerPickerController *)picker 
			  didConnectPeer:(NSString *)peerID 
				   toSession:(GKSession *)session
{
	[picker dismiss];
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Connected!"
													 message:[NSString stringWithFormat:@"Connected to peer with ID: %@", peerID] 
													delegate:nil 
										   cancelButtonTitle:nil 
										   otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)connectPressed:(id)aSender
{
	GKPeerPickerController *controller = [[GKPeerPickerController alloc] init];
	controller.delegate = self;
	// controller.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
	[controller show];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	NSArray *productTitles = [NSArray arrayWithObjects:
							  @"Bier",
							  @"7up",
							  @"Coca Cola",
							  @"Tonic",
							  @"Cassis",
							  @"Fanta",
							  @"Spa Rood",
							  @"Spa Blauw",
							  @"Wijn",
							  @"Whisky",
							  @"Likeur",
							  @"Pepsi", nil];
	
	productsGridView.rowCount = 3;
	productsGridView.columnCount = 3;
	productsGridView.titles = productTitles;
	productsGridView.buttonSize = CGSizeMake(200.0, 100.0);
	
	NSArray *categoryTitles = [NSArray arrayWithObjects:
							   @"Koffie en thee",
							   @"Alcoholische dranken",
							   @"Frisdranken",
							   @"Etenswaren", nil];
	
	categoriesGridView.rowCount = 1;
	categoriesGridView.columnCount = 4;
	categoriesGridView.titles = categoryTitles;
	categoriesGridView.buttonSize = CGSizeMake(150.0, 100.0);
	
	
	DLog(@"%@", self.managedObjectContext);
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
	Product *product = [[Product alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
	product.name = @"Bier";
	DLog(@"%@", product);
	[products addObject:product];
	[product release];

	UIBarButtonItem* connectItem = [[UIBarButtonItem alloc] initWithTitle:@"Connect" 
																	style:UIBarButtonItemStyleBordered 
																   target:self 
																   action:@selector(connectPressed:)];
	
	self.navigationItem.rightBarButtonItem = connectItem;
	[connectItem release];
    
    receiptView.productTableView.delegate = self;
    receiptView.productTableView.dataSource = self;
}

#pragma mark -
#pragma mark ButtonGridViewDelegate

- (void)buttonGridView:(ButtonGridView *)aButtonGridView buttonTappedAtIndex:(NSInteger)index
{
	DLog(@"index: %d", index);
	
	
}


#pragma mark -
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	return [products count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	ProductTableViewCell *cell = (ProductTableViewCell *) [receiptView.productTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	Product *product = [products objectAtIndex:indexPath.row];
	if (cell == nil) {
		cell = [[[ProductTableViewCell alloc] initWithProduct:product reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.product = product;
	
	return cell;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations.
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
        
    self.receiptView = nil;
}


- (void)dealloc 
{
    [receiptView release];
    [products release];
    [super dealloc];
}


@end
