//
//  Product.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Order;
@class ProductCategory;

@interface Product :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSSet* orders;
@property (nonatomic, retain) ProductCategory *category;

@end


@interface Product (CoreDataGeneratedAccessors)
- (void)addOrdersObject:(Order *)value;
- (void)removeOrdersObject:(Order *)value;
- (void)addOrders:(NSSet *)value;
- (void)removeOrders:(NSSet *)value;

@end

