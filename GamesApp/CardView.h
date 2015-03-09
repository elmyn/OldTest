//
//  CardView.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

@interface CardView : UIView

- (id)initCardView;
- (void)flipBackView;

@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UIImageView *fullImageView;

@property (weak, nonatomic) UIImageView *iconImageView;
@property (weak, nonatomic) UILabel *gameNameLabel;
@property (weak, nonatomic) UILabel *ratingLabel;
@property (weak, nonatomic) UITextView *descriptionTextView;

@property (nonatomic) float ratingValue;


@end
