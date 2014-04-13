//
//  CTTouchInterceptingWindow.h
//  JACTouchIndicator
//
//  Created by Julio Carrettoni on 3/22/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (GK_CTTouchInterceptingWindow)

- (void) setEventInterceptorView:(UIView*) aView;
- (void) interceptedSendEvent:(UIEvent *)event;

@end