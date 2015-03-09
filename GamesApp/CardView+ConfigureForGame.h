//
//  CardView+ConfigureForGame.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "CardView.h"

@class Game;

@interface CardView (ConfigureForGame)

- (void)configureForGame:(Game*)game;

@end
