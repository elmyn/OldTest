//
//  FetchedResultCarousleDataSource.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCarousel.h"


typedef void (^ConfigureBlock)(id view, id item);

@interface FetchedResultCarousleDataSource : NSObject <iCarouselDataSource>

@property (nonatomic, copy) ConfigureBlock configureViewBlock;

- (id)initWithCarousel:(iCarousel*)iCarousel fetchedResultsController:(NSFetchedResultsController*)aFetchedResultsController;

- (id)itemAtIndexPath:(NSIndexPath*)path;
    
@end
