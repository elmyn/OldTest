//
//  Store.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (nonatomic,strong,readonly) NSManagedObjectContext* managedObjectContext;

- (void)saveContext;

@end
