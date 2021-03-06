//
//  PaymentRequest.m
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaymentRequest.h"


@implementation PaymentRequest

@synthesize amount;
@synthesize productDescription;
@synthesize identifier;

- (id)init
{
	self = [super init];
	
	if (self) {
		identifier = arc4random() % 10000;
	}
	
	return self;
}

@end