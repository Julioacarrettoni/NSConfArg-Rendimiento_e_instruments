//
//  JACTI_CanvasView.h
//  JACTouchIndicator
//
//  Created by Julio Carrettoni on 3/22/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JACTI_CanvasView : UIView
- (void) touchEvent:(NSInteger) pointID beganFromPoint:(CGPoint) point;
- (void) touchEvent:(NSInteger) pointID movedToPoint:(CGPoint) point;
- (void) touchEvent:(NSInteger) pointID endedAtPoint:(CGPoint) point;

@property (nonatomic, retain) UIColor *thumbColor;
@property (nonatomic, assign) CGFloat thumbSize;

@end
