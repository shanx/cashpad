//
//  ProductTableViewFooter.m
//  CashRegister-iPad
//
//  Created by Sergey Novitsky on 2/19/11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "ReceiptTotalView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ReceiptTotalView
@synthesize total;

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

@end
