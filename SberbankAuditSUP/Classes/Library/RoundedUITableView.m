
#import "RoundedUITableView.h"
#import <QuartzCore/QuartzCore.h>

#define kCornerRadius 6.f

@implementation RoundedUITableViewMask
@synthesize squareCorners = _squareCorners;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
		self.squareCorners = NO;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat minx = CGRectGetMinX(rect);
    CGFloat midx = CGRectGetMidX(rect);
    CGFloat maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat midy = CGRectGetMidY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minx, midy);
	
	if (self.squareCorners) {
		CGContextAddLineToPoint(context, minx, miny);							// move to bottom-left
		CGContextAddLineToPoint(context, midx, miny);							// move to botttom-mid
		CGContextAddArcToPoint(context, maxx, miny, maxx, midy, kCornerRadius); // add an arc in the bottom right corner
		CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, kCornerRadius); // add an arc in the top right corner
		CGContextAddLineToPoint(context, minx, maxy);							// move to top-left
	} else {		
		CGContextAddArcToPoint(context, minx, miny, midx, miny, kCornerRadius);
		CGContextAddArcToPoint(context, maxx, miny, maxx, midy, kCornerRadius);
		CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, kCornerRadius);
		CGContextAddArcToPoint(context, minx, maxy, minx, midy, kCornerRadius);		
	}
	
    CGContextClosePath(context);
    CGContextFillPath(context);
}


- (void)dealloc {
    [super dealloc];
}

@end


@implementation RoundedUITableView
@synthesize squareCorners;

- (void)setupView {
	mask = nil;
	squareCorners = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;    
}


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)aTableStyle {
    if (self = [super initWithFrame:frame style:aTableStyle]) {
		[self setupView];
    }
	
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
		[self setupView];
    }
    
    return self;
}


- (void)adjustMask {
	if (nil == mask) {
		mask = [[RoundedUITableViewMask alloc] initWithFrame:CGRectZero];
		mask.squareCorners = self.squareCorners;
		self.layer.mask = mask.layer;
	}
	
    // Re-calculate the size of the mask to account for adding/removing rows.
    CGRect frame = mask.frame;
    if(self.contentSize.height > self.frame.size.height) {
    	frame.size = self.contentSize;
    } else {
        frame.size = self.frame.size;
    }
    mask.frame = frame;
	
    [mask setNeedsDisplay];
    [self setNeedsDisplay];
}


- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self adjustMask];
}


- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self adjustMask];
}


- (void)reloadData {
    [super reloadData];
    [self adjustMask];
}


- (void)dealloc {
    [mask release];
    [super dealloc];
}


@end