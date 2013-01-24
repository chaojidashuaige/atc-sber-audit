//
//  QualityView.h
//  SberbankAudit
//
//  Created by pnefedov on 06.12.12.
//
//

#import <UIKit/UIKit.h>

@interface QualityView : UIView<UIScrollViewDelegate>
{
    UIScrollView * _scroll;
}

@property (nonatomic,retain) UIScrollView * scroll;

@end
