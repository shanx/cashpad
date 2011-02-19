//
//  Customer.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ASIHTTPRequestDelegate.h"

typedef void(^CustomerSaveBlock)(NSError *error);

@class Order;

@interface Customer :  NSManagedObject   <ASIHTTPRequestDelegate>
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* orders;
@property (nonatomic, retain) NSString *identifier;

- (void)saveWithCompletionHandler:(CustomerSaveBlock)completionHandler;

@end


@interface Customer (CoreDataGeneratedAccessors)
- (void)addOrdersObject:(Order *)value;
- (void)removeOrdersObject:(Order *)value;
- (void)addOrders:(NSSet *)value;
- (void)removeOrders:(NSSet *)value;

@end

