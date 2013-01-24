#import <Foundation/Foundation.h>

@protocol StackScrollViewDelegate <NSObject>

@optional
- (void) viewControllerWillClose;

@end

@interface StackScrollViewController :  UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
	
	UIView* slideViews;
	UIView* borderViews;
	
	UIView* viewAtLeft;
	UIView* viewAtRight;
	UIView* viewAtLeft2;
	UIView* viewAtRight2;	
	UIView* viewAtRightAtTouchBegan;
	UIView* viewAtLeftAtTouchBegan;
	
	NSMutableArray* viewControllersStack;
	
	NSString* dragDirection;
	
	CGFloat viewXPosition;		
	CGFloat displacementPosition;
	CGFloat lastTouchPoint;
	CGFloat slideStartPosition;
	
	CGPoint positionOfViewAtRightAtTouchBegan;
	CGPoint positionOfViewAtLeftAtTouchBegan;
}

- (void) addViewInSlider:(UIViewController*)controller drawShadow:(BOOL)isDraw invokeByController:(UIViewController*)invokeByController isStackStartView:(BOOL)isStackStartView;
- (void)bounceBack:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context;
- (void) clearAllsubviews;

@property (nonatomic, retain) UIView* slideViews;
@property (nonatomic, retain) UIView* borderViews;
@property (nonatomic, assign) CGFloat slideStartPosition;
@property (nonatomic, retain) NSMutableArray* viewControllersStack;
@property (nonatomic, assign) id<StackScrollViewDelegate> delegate;



@end
