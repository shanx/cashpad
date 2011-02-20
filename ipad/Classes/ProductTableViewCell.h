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
    IBOutlet UIView*  cellView;
    IBOutlet UILabel* amountLabel;
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* priceLabel;
}

@property (nonatomic, retain) UIView*  cellView;
@property (nonatomic, retain) UILabel* amountLabel;
@property (nonatomic, retain) UILabel* nameLabel;
@property (nonatomic, retain) UILabel* priceLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
