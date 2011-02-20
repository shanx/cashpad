//
//  CheckoutViewController.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 20-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "CheckoutViewController.h"
#import "CheckoutViewControllerDelegate.h"
#import "PaymentSession.h"
#import "PaymentRequest.h"
#import "Order.h"

@implementation CheckoutViewController

@synthesize delegate;
@synthesize paymentSession;
@synthesize order;

- (id)init
{
	self = [super initWithNibName:@"CheckoutView" bundle:nil];
	
	if (self) {
		checkoutMethods = [[NSArray alloc] initWithObjects:@"Cash", @"PIN", @"Mobile", nil];
	}
	
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 1;
	}
	
	return [checkoutMethods count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if (indexPath.section == 1) {
		cell.hidden = NO;
		cell.textLabel.text = [checkoutMethods objectAtIndex:indexPath.row];
	} else {
		cell.hidden = YES;
	}

	
	return cell;
}

- (IBAction)mobile:(id)sender
{
	DLog(@"paymentSession:%@", paymentSession);
	PaymentRequest *paymentRequest = [[PaymentRequest alloc] init];
	paymentRequest.amount = [[order totalPrice] floatValue];
	paymentRequest.productDescription = [order orderDescription];
	[paymentSession sendPaymentRequest:paymentRequest];
	[paymentRequest release];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return 300.0;
	}
	return 44.0;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
	[cancelBarButtonItem release];
	
	self.title = @"Betalen";
	
	amountLabel.text = [NSString stringWithFormat:@"Totaal bedrag: %C %.2f", 0x20ac, [[order totalPrice] floatValue]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	
	DLog(@"%@", [NSValue valueWithCGRect:self.view.frame]);
}

- (void)cancel
{
	[delegate checkoutViewControllerDidCancel:self];
}

- (void)paymentSession:(PaymentSession *)session didAcceptPaymentRequest:(PaymentRequest *)request
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Betaling ontvangen!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
	[order saveWithCompletionHandler:^(NSError *error) {
		if (error) {
			DLog(@"Could not save order: %@", [error localizedDescription]);
		} else {
			DLog(@"Order saved successfully");
		}
	}];
}

- (void)paymentSession:(PaymentSession *)session didDenyPaymentRequest:(PaymentRequest *)request
{
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[delegate checkoutViewControllerDidFinish:self];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
