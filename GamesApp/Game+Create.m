//
//  Game+Create.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "Game+Create.h"
#import "SDImageCache.h"

@implementation Game (Create)

+ (instancetype)findOrCreateWithIdentifier:(id)identifier inContext:(NSManagedObjectContext*)context
{
    NSString* entityName = NSStringFromClass(self);
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"sbName = %@", identifier];
    fetchRequest.fetchLimit = 1;
    id object = [[context executeFetchRequest:fetchRequest error:NULL] lastObject];
    if(object == nil) {
        object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    }
    return object;
}

+ (void)createWithJSONComponents:(NSDictionary*)components intoContext:(NSManagedObjectContext*)context
{
    NSString* identifier = components[@"sbName"];
    NSString* commercialName = components[@"commercialName"];
    NSString* imageUrl = components[@"image"];
    NSString* iconUrl = components[@"icon"];
    NSNumber* rating = [NSNumber numberWithFloat:[ components[@"rating"] floatValue]];
    NSString* descripiton = components[@"description"];
    
    Game* game = [self findOrCreateWithIdentifier:identifier inContext:context];
    
    if(![game.commercialName isEqualToString:commercialName] || !game.commercialName)
    {
        
        game.commercialName = commercialName;
    }
    
    if(!game.sbName)
    {
        game.sbName = identifier;
    }
    
    if(![imageUrl isEqualToString:game.imageURL]
       || !game.imageURL )
    {
        [[SDImageCache sharedImageCache] removeImageForKey:game.imageURL];
        game.imageURL = imageUrl;
    }
    
    if(![iconUrl isEqualToString:game.iconUrl]
       || !game.iconUrl)
    {
        [[SDImageCache sharedImageCache] removeImageForKey:game.iconUrl];
        game.iconUrl = iconUrl;
    }
    
    if(![game.rating isEqualToNumber:rating])
    {
        game.rating = rating;
    }
    
    if(![game.description isEqualToString:descripiton] || !game.description)
    {
        game.descripiton = descripiton;
    }
    
}

@end
