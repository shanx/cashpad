//
//  ReceiptView.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReceiptTotalView;
@class ReceiptTitleView;

@interface ReceiptView : UIView
{
    IBOutlet UIButton*          getReceiptButton;
    IBOutlet ReceiptTitleView*  receiptTitleView;
    IBOutlet UITableView*       productTableView;
    IBOutlet ReceiptTotalView*  receiptTotalView;
    IBOutlet UIButton*          payButton;
    IBOutlet UIButton*          onNameButton;
}

@property(nonatomic, retain) UIButton*          getReceiptButton;
@property(nonatomic, retain) ReceiptTitleView*  receiptTitleView;
@property(nonatomic, retain) UITableView*       productTableView;
@property(nonatomic, retain) ReceiptTotalView*  receiptTotalView;
@property(nonatomic, retain) UIButton*          payButton;
@property(nonatomic, retain) UIButton*          onNameButton;

@end
