//
//  ClickableTableView.h
//  Hyves
//
//  Created by Sergey on 4/6/10.
//  Copyright 2010 Hyves. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickableViewDelegate
-(void)viewClicked:(UIView*)aView;
@end

@interface ClickableView : UIView
{
    id<ClickableViewDelegate> clickDelegate;
}

@property(assign) id<ClickableViewDelegate> clickDelegate;

@end

@interface ClickableTableView : UITableView
{
    id<ClickableViewDelegate> clickDelegate;
}

@property(assign) id<ClickableViewDelegate> clickDelegate;

@end


@interface ClickableLabel : UILabel
{
    id<ClickableViewDelegate> clickDelegate;
}

@property(assign) id<ClickableViewDelegate> clickDelegate;

@end
