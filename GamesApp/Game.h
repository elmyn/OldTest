//
//  Game.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Game : NSManagedObject

@property (nonatomic, retain) NSString * commercialName;
@property (nonatomic, retain) NSString * descripiton;
@property (nonatomic, retain) NSString * iconUrl;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * sbName;

@end
