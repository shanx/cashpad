//
//  ReceiptView.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReceiptTotalView;

@interface ReceiptView : UIView
{
}

@property(nonatomic, retain) UITableView*       productTableView;
@property(nonatomic, retain) ReceiptTotalView*  receiptTotalView;



@end