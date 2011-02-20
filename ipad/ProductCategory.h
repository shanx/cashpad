//
//  ProductCategory.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Product;

@interface ProductCategory :  NSManagedObject  
{
}

@property (nonatomic, retain) NSSet* products;
@property (nonatomic, retain) NSString *name;

@end


@interface ProductCategory (CoreDataGeneratedAccessors)
- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet *)value;
- (void)removeProducts:(NSSet *)value;

@end

