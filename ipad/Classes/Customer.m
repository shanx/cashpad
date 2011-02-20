// 
//  Customer.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Customer.h"
#import "ASIHTTPRequest.h"
#import "Order.h"

@interface Customer ()

@property (nonatomic, copy) CustomerSaveBlock completionHandler;
@property (nonatomic, retain) ASIHTTPRequest *HTTPRequest;

@end

@implementation Customer 

@dynamic id;
@dynamic name;
@dynamic orders;
@dynamic identifier;
@synthesize completionHandler;
@synthesize HTTPRequest;

- (void)saveWithCompletionHandler:(CustomerSaveBlock)aCompletionHandler
{
	self.completionHandler = aCompletionHandler;
	
	self.identifier = [[UIDevice currentDevice] uniqueIdentifier];
	NSString *URLString = [NSString stringWithFormat:@"http://www.ipadkassasysteem.nl/++rest++api/user/%@", self.identifier];
	NSURL *URL = [NSURL URLWithString:URLString];
	
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:URL];
	self.HTTPRequest = request;
	[request release];
	
	[HTTPRequest addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"]; 
	HTTPRequest.delegate = self;
	HTTPRequest.requestMethod = @"PUT";
	[HTTPRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	DLog(@"request finished, response status code: %d", request.responseStatusCode);
	NSError *error = nil;
	switch (request.responseStatusCode) {
		case 201:
			DLog(@"response code 201: new user created");
			break;
		case 204:
			DLog(@"response code 204: existing user updated");
			break;
		default:
			DLog(@"response code %d", request.responseStatusCode);
			error = [NSError errorWithDomain:@"Customer" code:0 userInfo:nil];
			break;
	}
	self.completionHandler(error);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	DLog(@"request failed, response status code: %d", request.responseStatusCode);
	self.completionHandler([NSError errorWithDomain:@"Customer" code:0 userInfo:nil]);
}

@end
