//
//  UIViewExt.m
//  SberbankAudit
//
//  Created by Артем Куликов on 01.06.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "UIViewExt.h"

@implementation UIViewExt

- (UIView *) hitTest: (CGPoint) pt withEvent: (UIEvent *) event 
{   
	
	UIView* viewToReturn=nil;
	CGPoint pointToReturn;
	
	UIView* uiLeftView = (UIView*)[[self subviews] objectAtIndex:1];
	
	if ([[uiLeftView subviews] objectAtIndex:0]) {
		
		UIView* uiScrollView = [[uiLeftView subviews] objectAtIndex:0];	
		
		if ([[uiScrollView subviews] objectAtIndex:0]) {	 
			
			UIView* uiMainView = [[uiScrollView subviews] objectAtIndex:1];	
			
			for (UIView* subView in [uiMainView subviews]) {
				CGPoint point  = [subView convertPoint:pt fromView:self];
				if ([subView pointInside:point withEvent:event]) {
					viewToReturn = subView;
					pointToReturn = point;
				}
				
			}
		}
		
	}
	
	if(viewToReturn != nil) {
		return [viewToReturn hitTest:pointToReturn withEvent:event];		
	}
	
	return [super hitTest:pt withEvent:event];	
	
}
@end