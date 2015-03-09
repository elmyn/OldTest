//
//  SlideLabelView.m
//  rotateTest
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "SlideLabelView.h"

#define kStandardLabelHeight 25.0f
#define kStandardDuration 0.3
#define kFontSize 20

@interface SlideLabelView()
@property (nonatomic, weak) UILabel *currentLabel;
@end

@implementation SlideLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*
 I will have rebuild it to queue animations
 */
- (void)animateFromLeft:(BOOL)left withDuration:(CGFloat)duration text:(NSString*)text
{
    CGFloat startingPoint = left ? -self.frame.size.width : self.frame.size.width;
    CGRect frame = CGRectMake(startingPoint, 0, self.frame.size.width, kStandardLabelHeight);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Lato-Regular" size:kFontSize];
    [self addSubview:label];
    
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [label setFrame:CGRectMake(0, 0, frame.size.width, kStandardLabelHeight)];
        [self.currentLabel setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self.currentLabel removeFromSuperview];
        self.currentLabel = label;
    }];
}

- (void)slideLabelFromLeftWithText:(NSString*)text;
{
    [self animateFromLeft:YES withDuration:kStandardDuration text:text];
}

- (void)slideLabelFromRightWithText:(NSString*)text
{
    [self animateFromLeft:NO withDuration:kStandardDuration text:text];
}

- (void)layoutSubviews
{
    [self.currentLabel  setFrame:CGRectMake(0, 0, self.frame.size.width, kStandardLabelHeight)];
    
}


@end
