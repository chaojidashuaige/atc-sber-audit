
#import <UIKit/UIKit.h>


@interface RoundedUITableViewMask : UIView {
	BOOL _squareCorners;
}
@property BOOL squareCorners;
@end


@interface RoundedUITableView : UITableView {
    RoundedUITableViewMask *mask;
	BOOL squareCorners;
}
@property BOOL squareCorners;

- (void)adjustMask;
@end