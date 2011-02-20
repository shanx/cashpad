//
//  CheckoutViewController.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 20-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "CheckoutViewController.h"


@implementation CheckoutViewController

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
	
	self.title = @"Checkout";
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	
	DLog(@"%@", [NSValue valueWithCGRect:self.view.frame]);
}

- (void)cancel
{
	[self.navigationController.parentViewController dismissModalViewControllerAnimated:YES];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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
