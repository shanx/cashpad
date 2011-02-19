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

@end

@implementation Customer 

@dynamic id;
@dynamic name;
@dynamic orders;
@synthesize completionHandler;

- (void)saveWithCompletionHandler:(CustomerSaveBlock)aCompletionHandler
{
	self.completionHandler = aCompletionHandler;
	
	NSString *identifier = [[UIDevice currentDevice] uniqueIdentifier];
	NSString *URLString = [NSString stringWithFormat:@"http://test.cashpad.com/api/user/%@", identifier];
	NSURL *URL = [NSURL URLWithString:URLString];
	
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:URL];
	request.delegate = self;
	request.requestMethod = @"PUT";
}

@end
