//
//  NearbyMatch.m
//  MinesweeperFlags
//
//  Created by Rits Plasman on 23-01-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaymentSession.h"
#import "PaymentSessionDelegate.h"
#import "PaymentRequest.h"
#import "JSON.h"

#define kPaymentSessionRequestActionKey					@"action"
#define kPaymentSessionRequestActionRequestPaymentKey	@"request_payment"
#define kPaymentSessionRequestPaymentRequestKey			@"payment_request"
#define kPaymentSessionRequestProductDescriptionKey		@"product_description"
#define kPaymentSessionRequestAmountKey					@"amount"
#define kPaymentSessionRequestIdentifierKey				@"id"
#define kPaymentSessionRequestActionAcceptPaymentKey	@"accept_payment"
#define kPaymentSessionRequestActionDenyPaymentKey		@"deny_payment"

@interface PaymentSession ()

@property (nonatomic, retain) PaymentRequest *receivedRequest;
@property (nonatomic, retain) PaymentRequest *sentRequest;

- (void)sendObject:(id)sender;
- (void)receiveObject:(id)object;

@end

@implementation PaymentSession

@synthesize delegate;
@synthesize receivedRequest;
@synthesize sentRequest;

- (id)initWithGKSession:(GKSession *)aSession
{
	self = [super init];
	
	if (self) {
		session = [aSession retain];
		session.delegate = self;
		
		[session setDataReceiveHandler:self withContext:nil];
	}
	
	return self;
}


- (void)session:(GKSession *)aSession didFailWithError:(NSError *)error
{
	
}

- (void)session:(GKSession *)aSession didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
	
}

- (void)session:(GKSession *)aSession peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)peerState
{
	switch (peerState) {
		case GKPeerStateConnecting:
			
			break;
		case GKPeerStateConnected:
			break;
		case GKPeerStateDisconnected:
			break;
		default:
			break;
	}
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)aSession context:(void *)context
{
	NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	DLog(@"received: '%@'", response);
	id object = [response JSONValue];
	[response release];
	
	[self receiveObject:object];
}

- (void)sendObject:(id)object
{
	DLog(@"object:%@", object);
	NSString *JSONValue = [object JSONRepresentation];
	DLog(@"sending: '%@'", JSONValue);
	NSData *data = [JSONValue dataUsingEncoding:NSUTF8StringEncoding];
	[session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}

- (void)receiveObject:(id)object
{
	DLog(@"object:%@", object);
	NSString *action = [object objectForKey:kPaymentSessionRequestActionKey];
	if (action == nil) {
		return;
	}
	
	if ([action isEqualToString:kPaymentSessionRequestActionRequestPaymentKey]) {
		NSDictionary *requestDictionary = [object objectForKey:kPaymentSessionRequestPaymentRequestKey];
		
		NSString *productDescription = [requestDictionary objectForKey:kPaymentSessionRequestProductDescriptionKey];
		NSNumber *amountNumber = [requestDictionary objectForKey:kPaymentSessionRequestAmountKey];
		NSNumber *identifierNumber = [requestDictionary objectForKey:kPaymentSessionRequestIdentifierKey];
		
		PaymentRequest *request = [[PaymentRequest alloc] init];
		request.productDescription = productDescription;
		request.amount = [amountNumber floatValue];
		request.identifier = [identifierNumber intValue];
		
		self.receivedRequest = request;
		
		[delegate paymentSession:self didReceivePaymentRequest:request];
		
		[request release];
	} else if ([action isEqualToString:kPaymentSessionRequestActionAcceptPaymentKey]) {
		NSNumber *identifierNumber = [object objectForKey:kPaymentSessionRequestIdentifierKey];
		
		if (sentRequest.identifier == [identifierNumber intValue]) {
			[delegate paymentSession:self didAcceptPaymentRequest:sentRequest];
			
			self.sentRequest = nil;
		}			
	} else if ([action isEqualToString:kPaymentSessionRequestActionDenyPaymentKey]) {
		NSNumber *identifierNumber = [object objectForKey:kPaymentSessionRequestIdentifierKey];
		
		if (sentRequest.identifier == [identifierNumber intValue]) {
			[delegate paymentSession:self didDenyPaymentRequest:sentRequest];
			
			self.sentRequest = nil;
		}
	}
}

- (void)sendPaymentRequest:(PaymentRequest *)request
{
	self.sentRequest = request;
	
	NSString *productDescription = request.productDescription;
	NSNumber *amountNumber = [NSNumber numberWithFloat:request.amount];
	NSNumber *identifierNumber = [NSNumber numberWithInt:request.identifier];
	
	NSDictionary *requestDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
									   productDescription,
									   kPaymentSessionRequestProductDescriptionKey,
									   amountNumber,
									   kPaymentSessionRequestAmountKey, nil];
	
	NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:
							kPaymentSessionRequestActionRequestPaymentKey,
							kPaymentSessionRequestActionKey,
							requestDictionary,
							kPaymentSessionRequestPaymentRequestKey,
							identifierNumber,
							kPaymentSessionRequestIdentifierKey, nil];
	
	[self sendObject:object];			
}

- (void)acceptPaymentRequest:(PaymentRequest *)request
{
	if (request == receivedRequest) {
		NSNumber *identifierNumber = [NSNumber numberWithInt:request.identifier];
		NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
									kPaymentSessionRequestActionAcceptPaymentKey,
									kPaymentSessionRequestActionKey,
									identifierNumber,
									kPaymentSessionRequestIdentifierKey, nil];
		
		[self sendObject:dictionary];
	}
}


- (void)denyPaymentRequest:(PaymentRequest *)request
{
	if (request == receivedRequest) {
		NSNumber *identifierNumber = [NSNumber numberWithInt:request.identifier];
		NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
									kPaymentSessionRequestActionDenyPaymentKey,
									kPaymentSessionRequestActionKey,
									identifierNumber,
									kPaymentSessionRequestIdentifierKey, nil];
		
		[self sendObject:dictionary];
	}
}

@end
