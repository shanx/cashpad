//
//  ProductTableViewFooter.h
//  CashRegister-iPad
//
//  Created by Sergey Novitsky on 2/19/11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReceiptTotalView : UIView 
{
    UILabel* paymentTextLabel;
    UILabel* paymentTotalLabel;
}

@property(nonatomic, retain) UILabel* paymentTextLabel;
@property(nonatomic, retain) UILabel* paymentTotalLabel;


@end
