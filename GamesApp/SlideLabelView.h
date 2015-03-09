//
//  SlideLabelView.h
//  rotateTest
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideLabelView : UIView

- (void)slideLabelFromLeftWithText:(NSString*)text;
- (void)slideLabelFromRightWithText:(NSString*)text;
@end
