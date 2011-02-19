//
//  ReceiptTableViewCell.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface ProductTableViewCell : UITableViewCell
{

}

@property (nonatomic, retain) Product *product;

- (id)initWithProduct:(Product *)aProduct reuseIdentifier:(NSString *)identifier;

@end
