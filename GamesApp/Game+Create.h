//
//  Game+Create.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "Game.h"

@interface Game (Create)

+ (void)createWithJSONComponents:(NSDictionary*)components intoContext:(NSManagedObjectContext*)context;

@end
