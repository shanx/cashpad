//
//  ProductsViewDelegate.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonGridView;

@protocol ButtonGridViewDelegate <UIScrollViewDelegate>

- (void)buttonGridView:(ButtonGridView *)aButtonGridView buttonTappedAtIndex:(NSInteger)index;

@end
