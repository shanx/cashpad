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
	
	NSString *URLString = [NSString stringWithFormat:@"http://test.cashpad.com/api/user/%d/order/", [self.customer.id intValue]];
	NSURL *URL = [NSURL URLWithString:URLString];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:URL];
	request.delegate = self;
	request.requestMethod = @"POST";
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								self.creationDate,
								@"creation_date",
								[self itemList],
								@"item_list",
								nil];
	
	NSString *JSONString = [dictionary JSONRepresentation];
	NSMutableData *postBody = [[JSONString dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
	request.postBody = postBody;
	[postBody release];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	DLog(@"request finished, response status code: %d", request.responseStatusCode);
	self.completionHandler(nil);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	DLog(@"request failed, response status code: %d", request.responseStatusCode);
	self.completionHandler([NSError errorWithDomain:nil code:0 userInfo:nil]);
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
