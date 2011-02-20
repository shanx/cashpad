//
//  Order.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ASIHTTPRequestDelegate.h"

@class Customer;
@class Product;

typedef void(^OrderCompletionHandler)(NSError *error);

@interface Order :  NSManagedObject <ASIHTTPRequestDelegate>
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * totalPrice;
@property (nonatomic, retain) NSSet* products;
@property (nonatomic, retain) Customer * customer;
@property (nonatomic, retain) NSDate *creationDate;

- (void)saveWithCompletionHandler:(OrderCompletionHandler)completionHandler;
- (NSArray *)itemList;

@end


@interface Order (CoreDataGeneratedAccessors)
- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet *)value;
- (void)removeProducts:(NSSet *)value;

@end

