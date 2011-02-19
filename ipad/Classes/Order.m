// 
//  Order.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Order.h"
#import "JSON.h"
#import "Customer.h"
#import "Product.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface Order ()

@property (nonatomic, copy) OrderCompletionHandler completionHandler;

- (NSArray *)itemList;
- (NSInteger)numberOfProductsWithID:(NSNumber *)id;

@end

@implementation Order 

@dynamic id;
@dynamic totalPrice;
@dynamic products;
@dynamic customer;
@dynamic creationDate;
@synthesize completionHandler;

- (void)saveWithCompletionHandler:(OrderCompletionHandler)aCompletionHandler
{
	self.completionHandler = aCompletionHandler;
	
	NSString *URLString = [NSString stringWithFormat:@"http://www.ipadkassasysteem.nl/++rest++api/user/%@/order/", self.customer.identifier];
	DLog(@"URLString:%@", URLString);
	NSURL *URL = [NSURL URLWithString:URLString];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:URL];
	request.delegate = self;
	[request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"]; 
	//[request setPostValue:@"application/json; charset=utf8" forKey:@"Content-Type"];
	request.requestMethod = @"POST";
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithInt:time(NULL)],
								@"created_on",
								[self itemList],
								@"item_list",
								self.totalPrice,
								@"total_price",
								nil];
	
	NSString *JSONString = [dictionary JSONRepresentation];
	//JSONString = @"{\"item_list\":[{\"unit_price\":200.0,\"product_id\":0,\"product_name\":\"Biertje\",\"amount\":1}],\"created_on\":1298153368}";
	DLog(@"JSONString: '%@'", JSONString);
	NSMutableData *postBody = [[JSONString dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
	request.postBody = postBody;
	[postBody release];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	DLog(@"request finished, response status code: %d", request.responseStatusCode);
	NSError *error = nil;
	switch (request.responseStatusCode) {
		case 201:
			DLog(@"response code 201: order created");
			break;
		case 400:
			DLog(@"response code 400: data could not be parsed");
			error = [NSError errorWithDomain:@"Order" code:0 userInfo:nil];
			break;
		default:
			DLog(@"response code %d", request.responseStatusCode);
			error = [NSError errorWithDomain:@"Order" code:0 userInfo:nil];
			break;
	}
	self.completionHandler(error);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	DLog(@"request failed, response status code: %d", request.responseStatusCode);
	self.completionHandler([NSError errorWithDomain:@"Order" code:0 userInfo:nil]);
}

- (NSInteger)numberOfProductsWithID:(NSNumber *)id
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product.id = %@ AND product.orders contains %@", id, self];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setPredicate:predicate];
	NSError *error = nil;
	NSUInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	
	if (error) {
		DLog(@"could not execute fetch request: %@", error);
	}
	
	return count;
}

- (NSArray *)itemList
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	
	for (Product *product in self.products) {
		NSMutableDictionary *item = [dictionary objectForKey:product.id];
		if (!item) {
			item = [NSMutableDictionary dictionary];
			[dictionary setObject:item forKey:product.id];
			[item setObject:product.name forKey:@"product_name"];
			[item setObject:product.id forKey:@"product_id"];
			[item setObject:product.price forKey:@"unit_price"];
		}
		
		NSInteger amount = [[item objectForKey:@"amount"] intValue];
		[item setObject:[NSNumber numberWithInt:amount + 1] forKey:@"amount"];
	}
	
	return [dictionary allValues];
}
		

@end
