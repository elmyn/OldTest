//
//  FetchedResultCarousleDataSource.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "FetchedResultCarousleDataSource.h"
#import "CardView.h"

@interface FetchedResultCarousleDataSource () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) iCarousel* iCarousel;

@end

@implementation FetchedResultCarousleDataSource

#pragma mark - initializing

- (id)initWithCarousel:(iCarousel*)iCarousel fetchedResultsController:(NSFetchedResultsController*)aFetchedResultsController;
{
    self = [super init];
    if(self) {
        self.iCarousel = iCarousel;
        self.fetchedResultsController = aFetchedResultsController;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.iCarousel.dataSource = self;
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:NULL];
    [self.iCarousel reloadData];
}

#pragma mark - item accessing methods

- (id)itemAtIndexPath:(NSIndexPath*)path {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    if([sectionInfo numberOfObjects] == 0)
    {
        return nil;
    }

    return [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:path.row inSection:path.section]];
}

- (id)itemAtIndex:(NSUInteger)index {
    return [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}


#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSUInteger i = [self.fetchedResultsController.sections[(NSUInteger) 0] numberOfObjects];
    return i;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{

    if(view == nil)
    {
        view = [[CardView alloc] initCardView];
    }
    
    id item = [self itemAtIndex:index];
    if(self.configureViewBlock) {
        self.configureViewBlock(view, item);
    }
    return view;
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.iCarousel reloadData];
    });
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.iCarousel insertItemAtIndex:newIndexPath.row animated:NO];
            });
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.iCarousel reloadItemAtIndex:indexPath.row animated:YES];
            });
        }
            break;
        default:
            break;
    }
}


- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.iCarousel.itemWidth);
}


@end
