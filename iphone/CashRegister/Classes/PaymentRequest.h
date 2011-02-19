//
//  PaymentRequest.h
//  CashRegister
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PaymentRequest : NSObject
{
	float amount;
	NSInteger identifier;
}

@property (nonatomic, assign) float amount;
@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, assign) NSInteger identifier;

@end
