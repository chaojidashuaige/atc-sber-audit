//
//  QualityView.m
//  SberbankAudit
//
//  Created by pnefedov on 06.12.12.
//
//

#import "QualityView.h"

@implementation QualityView
@synthesize scroll = _scroll;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scroll = [[UIScrollView alloc] initWithFrame:self.frame];
        _scroll.showsVerticalScrollIndicator = YES;
        _scroll.scrollEnabled = YES;
        _scroll.userInteractionEnabled = YES;
        //    _scroll.userInteractionEnabled = NO;
        _scroll.contentSize = CGSizeMake(504, 900);
        _scroll.delegate = self;
        [self addSubview:_scroll];

        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [_scroll release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
