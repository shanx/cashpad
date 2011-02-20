//
//  MainViewController.m
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "CheckoutViewController.h"
#import "ProductTableViewCell.h"
#import "Product.h"
#import "ProductCategory.h"
#import "PaymentSession.h"
#import "PaymentRequest.h"
#import "ButtonGridView.h"
#import "ReceiptTotalView.h"
#import "ReceiptView.h"
#import "Customer.h"
#import "Order.h"

#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) Order *order;
@property (nonatomic, retain) NSArray *productGroupDictionaries;

- (NSArray *)categoryTitles;
- (NSArray *)productTitles;
- (ProductCategory *)selectedCategory;
- (NSArray *)productsInSelectedCategory;

@end

@implementation MainViewController

@synthesize managedObjectContext;
@synthesize receiptView;
@synthesize customer;
@synthesize order;
@synthesize productGroupDictionaries;

- (id)init
{
	self = [super initWithNibName:@"MainView" bundle:nil];
	
	if (self) {
		selectedCategoryIndex = 0;
		categories = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (IBAction)pay:(id)sender
{
	CheckoutViewController *controller = [[CheckoutViewController alloc] init];
	UINavigationController *tempNavigationController = [[UINavigationController alloc] initWithRootViewController:controller];
	tempNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentModalViewController:tempNavigationController animated:YES];
	[controller release];
	[tempNavigationController release];
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

- (NSArray *)categoryTitles
{
	NSMutableArray *categoryTitles = [NSMutableArray array];
	
	for (ProductCategory *category in categories) {
		[categoryTitles addObject:category.name];
	}
	
	return categoryTitles;
}

- (NSArray *)productTitles
{
	NSMutableArray *productTitles = [NSMutableArray array];
	
	for (Product *product in [self productsInSelectedCategory]) {
		[productTitles addObject:product.name];
	}
	
	return productTitles;
}

- (NSArray *)productsInSelectedCategory
{
	NSMutableArray *products = [NSMutableArray array];
	
	for (Product *product in [self selectedCategory].products) {
		[products addObject:product];
	}
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	[products sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	return products;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    // Load receipt view.
    [[NSBundle mainBundle] loadNibNamed:@"ReceiptView" owner:self options:nil];
    
    CGRect ownBounds = self.view.bounds;
    CGRect receiptViewFrame = receiptView.frame;
    receiptViewFrame.origin.x = ownBounds.size.width - receiptViewFrame.size.width;
    receiptViewFrame.size.height = ownBounds.size.height;
    receiptView.frame = receiptViewFrame;
    
	[self.view addSubview:receiptView];
    
	NSInteger productID = 0;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"];
	NSArray *categoryDictionaries = [[NSArray alloc] initWithContentsOfFile:path];
	NSEntityDescription *categoryEntity = [NSEntityDescription entityForName:@"ProductCategory" inManagedObjectContext:self.managedObjectContext];
	NSEntityDescription *productEntity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
	for (NSDictionary *categoryDictionary in categoryDictionaries) {
		ProductCategory *category = [[ProductCategory alloc] initWithEntity:categoryEntity insertIntoManagedObjectContext:self.managedObjectContext];
		category.name = [categoryDictionary objectForKey:@"name"];
		
		[categories addObject:category];
		
		for (NSDictionary *productDictionary in [categoryDictionary objectForKey:@"products"]) {
			Product *product = [[Product alloc] initWithEntity:productEntity insertIntoManagedObjectContext:self.managedObjectContext];
			product.category = category;
			product.name = [productDictionary objectForKey:@"name"];
			product.price = [productDictionary objectForKey:@"price"];
			product.id = [NSNumber numberWithInt:productID];
			productID++;
			
			//[products addObject:product];
			
			[product release];
		}
		
		[category release];
	}
			
	
	NSEntityDescription *customerEntity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
	Customer *tempCustomer = [[Customer alloc] initWithEntity:customerEntity insertIntoManagedObjectContext:self.managedObjectContext];
	self.customer = tempCustomer;
	[tempCustomer release];
	
	customer.name = @"Rits";
	customer.identifier = [[UIDevice currentDevice] uniqueIdentifier];
	
	NSEntityDescription *orderEntity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:self.managedObjectContext];
	Order *tempOrder = [[Order alloc] initWithEntity:orderEntity insertIntoManagedObjectContext:self.managedObjectContext];
	self.order = tempOrder;
	[tempOrder release];
	
	order.customer = customer;
	
	productsGridView.rowCount = 3;
	productsGridView.columnCount = 3;
	productsGridView.titles = [self productTitles];
	productsGridView.buttonSize = CGSizeMake(200.0, 100.0);
	
    productsGridView.layer.masksToBounds = YES;
    productsGridView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    productsGridView.layer.borderWidth = 1.0;
	
	categoriesGridView.rowCount = 1;
	categoriesGridView.columnCount = 4;
	categoriesGridView.titles = [self categoryTitles];
	categoriesGridView.buttonSize = CGSizeMake(150.0, 100.0);
	
	
    categoriesGridView.layer.masksToBounds = YES;
    categoriesGridView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    categoriesGridView.layer.borderWidth = 1.0;
    
    
	DLog(@"%@", self.managedObjectContext);
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
	Product *product = [[Product alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
	product.name = @"Bier";
	DLog(@"%@", product);
	//[products addObject:product];
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

- (ProductCategory *)selectedCategory
{
	return [categories objectAtIndex:selectedCategoryIndex];
}

#pragma mark -
#pragma mark ButtonGridViewDelegate

- (void)buttonGridView:(ButtonGridView *)aButtonGridView buttonTappedAtIndex:(NSInteger)index
{
	if (aButtonGridView == productsGridView) {
		Product *product = [[self productsInSelectedCategory] objectAtIndex:index];
		
		NSEntityDescription *productEntity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
		Product *newProduct = [[Product alloc] initWithEntity:productEntity insertIntoManagedObjectContext:self.managedObjectContext];
		newProduct.id = product.id;
		newProduct.name = product.name;
		newProduct.price = product.price;
		
		[order addProductsObject:newProduct];
		[newProduct release];
		
		DLog(@"%@", order.products);
		
		self.productGroupDictionaries = [order itemList];

		[receiptView.productTableView reloadData];
		
		receiptView.receiptTotalView.paymentTotalLabel.text = [NSString stringWithFormat:@"%C %@", 0x20ac, [order totalPrice]];
	} else {
		selectedCategoryIndex = index;
		productsGridView.titles = [self productTitles];
	}

}


#pragma mark -
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	return [productGroupDictionaries count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	ProductTableViewCell *cell = (ProductTableViewCell *) [receiptView.productTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	NSDictionary *dictionary = [productGroupDictionaries objectAtIndex:indexPath.row];
	if (cell == nil) {
		cell = [[[ProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                            reuseIdentifier:CellIdentifier] autorelease];
	}
	
#warning "Set product fields!!!" 
	cell.priceLabel.text = [[dictionary objectForKey:@"product_price"] stringValue];
	cell.nameLabel.text = [dictionary objectForKey:@"product_name"];
	cell.amountLabel.text = [[dictionary objectForKey:@"amount"] stringValue];
	//cell.product = product;
	
	return cell;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations.
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight || 
           interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
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
    [super dealloc];
}


@end
