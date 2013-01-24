
#import "MenuHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MenuHeaderView

- (id)initWithFrame:(CGRect)aFrame
{
	if ((self = [super initWithFrame:aFrame]))
	{
		UIImageView *sberLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"retina-logo-2.png"]];
//		UIImageView *sberLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_logo.png"]];
        [sberLogoView setFrame:CGRectMake(16, 50, 165, 34)];
        [self addSubview:sberLogoView];
        [sberLogoView release];
        
        UIImageView *sberUnderLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLine setFrame:CGRectMake(15, self.frame.size.height, 169, 2)];
        [self addSubview:sberUnderLine];
        [sberUnderLine release];
        
//        self.backgroundColor = [UIColor grayColor];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

@end
