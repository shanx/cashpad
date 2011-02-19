//
//  MainViewController.m
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "PaymentSession.h"
#import "PaymentRequest.h"

@implementation MainViewController

- (id)init
{
	self = [super initWithNibName:@"MainView" bundle:nil];
	
	if (self) {
		
	}
	
	return self;
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
	
}

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
	DLog(@"");
	
	GKSession *session = [[[GKSession alloc] initWithSessionID:nil displayName:[UIDevice currentDevice].name sessionMode:GKSessionModePeer] autorelease];
	return session;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
	DLog(@"");
	
	[picker dismiss];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connected!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
	paymentSession = [[PaymentSession alloc] initWithGKSession:session];
	paymentSession.delegate = self;
}

- (void)paymentSession:(PaymentSession *)session didReceivePaymentRequest:(PaymentRequest *)request
{
	DLog(@"");
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment requested" message:request.productDescription delegate:self cancelButtonTitle:@"Deny" otherButtonTitles:@"Accept", nil];
	[alertView show];
	[alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		[paymentSession denyPaymentRequest:paymentSession.receivedRequest];
	} else {
		[paymentSession acceptPaymentRequest:paymentSession.receivedRequest];
	}
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
	
	GKPeerPickerController *controller = [[GKPeerPickerController alloc] init];
	controller.delegate = self;
	// controller.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
	[controller show];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
