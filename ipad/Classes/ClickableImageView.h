//
//  ClickableImageView.h
//  Hyves
//
//  Created by Teun van Run on 8/22/08.
//  Copyright 2008 Service2Media B.V. All rights reserved. Redistribution is strictly prohibited.
//

#import <UIKit/UIKit.h>

@protocol ClickableImageDelegate
@optional
-(void)imageClicked:(id)aImageView;
-(void)imageClicked:(id)aImageView atPoint:(CGPoint)aPoint duration:(NSTimeInterval)aDuration;
@end

@interface ClickableImageView : UIImageView 
{
    IBOutlet id<ClickableImageDelegate> delegate;
    // Field to indicate that touch events are propagated
    // further.
    // YES by default.
    // Set this field to NO if you don't want clicks to also be handled
    // by parent views.
    BOOL                                propagateTouchEvents;
    
    // Duration of a single long tap, after which a delegate method is to be called.
    // If == 0, the delegate is only called when touch is ended.
    NSTimeInterval                      longTapDuration;
    NSTimeInterval                      touchesBeganTimeStamp;
    CGPoint                             touchesBeganLocation;
    NSTimer*                            longTapTimer;
}

@property(nonatomic,assign) id<ClickableImageDelegate>  delegate;
@property(nonatomic,assign) BOOL                        propagateTouchEvents;
@property(nonatomic,retain) NSTimer*                    longTapTimer;
@property(nonatomic,assign) NSTimeInterval              longTapDuration;

-(void)setSelected:(BOOL)selected;

@end
