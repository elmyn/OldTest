//
//  CardView+ConfigureForGame.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "CardView+ConfigureForGame.h"
#import "Game.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "ProgressView.h"


@implementation CardView (ConfigureForGame)

- (void)configureForGame:(Game*)game
{
    [self.nameLabel setText:game.commercialName];
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:game.iconUrl]
                       placeholderImage:nil];
    self.ratingValue = [game.rating floatValue];
    self.gameNameLabel.text = game.commercialName;
    self.descriptionTextView.text = game.descripiton;
    
    
    __block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = self.fullImageView.center;
    [activityIndicator startAnimating];
    activityIndicator.hidesWhenStopped = YES;
    
    [self.fullImageView setImageWithURL:[NSURL URLWithString:game.imageURL]
              placeholderImage:nil
                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                           [activityIndicator removeFromSuperview];
                       }];
    
    [self.fullImageView addSubview:activityIndicator];
}

@end
