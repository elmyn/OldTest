//
//  MainViewController.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 19.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "MainViewController.h"
#import "Store.h"
#import "FetchedResultCarousleDataSource.h"
#import "iCarousel.h"
#import "Connection.h"
#import "CardView+ConfigureForGame.h"
#import "SlideLabelView.h"
#import "Game.h"

static NSString* baseURL = @"http://www.konzeptual.es/sb/gamesDetail.json";

@class Game;

@interface MainViewController () <iCarouselDelegate>

@property (nonatomic, strong) Store* store;
@property (nonatomic, strong) FetchedResultCarousleDataSource* dataSource;
@property (nonatomic, strong) iCarousel* carousel;
@property (nonatomic, strong) SlideLabelView *slideLabelView;
@property (nonatomic) NSInteger lastVisibleCarouselIndex;

- (void)setUpSlideLabelView;
- (void)setUpCarouselView;

@end

@implementation MainViewController

#pragma mark - initializing and loading

- (id)initWithStore:(Store*)store
{
    self = [super init];
    if(self) {
        self.store = store;
    }
    return self;
}

- (void)setUpSlideLabelView
{
    self.slideLabelView = [[SlideLabelView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 35.0f, self.view.frame.size.width, self.view.frame.size.height)];
	self.slideLabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.slideLabelView];
    
    Game *game = [self.dataSource itemAtIndexPath:[NSIndexPath indexPathForRow:self.carousel.currentItemIndex inSection:0]];
    if(game)
    {
        [self.slideLabelView slideLabelFromLeftWithText:game.commercialName];
    }
}

- (void)setUpCarouselView
{
    self.carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
	self.carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.carousel.delegate = self;
    
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sbName" ascending:YES]];
    NSFetchedResultsController* fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.store.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.dataSource = [[FetchedResultCarousleDataSource alloc] initWithCarousel:self.carousel fetchedResultsController:fetchedResultsController];
    
    self.carousel.dataSource = self.dataSource;
    self.dataSource.configureViewBlock = ^(CardView *view, Game *game)
    {
        [view configureForGame:game];
    };
    
   	[self.view addSubview:self.carousel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView  setImage:[UIImage imageNamed:@"bg.jpg"]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    
    [self setUpCarouselView];
    [self setUpSlideLabelView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!UIDeviceOrientationIsPortrait([[UIApplication sharedApplication]statusBarOrientation]))
    {
        self.carousel.type = iCarouselTypeCoverFlow;
    } else {
        self.carousel.type = iCarouselTypeLinear;
    }
}

#pragma mark - data downloading

- (void)downloadData
{
    Connection *connection = [[Connection alloc] initWithStore:self.store andURLString:baseURL];
    [connection downloadData];
}

#pragma mark - interface orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [UIView beginAnimations:nil context:nil];
    if(fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.carousel.type = iCarouselTypeLinear;
    } else {
        self.carousel.type = iCarouselTypeCoverFlow;
    }
    
    [UIView commitAnimations];
}

#pragma mark - iCarouselDelegate

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    CardView* firstView = (CardView*)[carousel itemViewAtIndex:self.lastVisibleCarouselIndex];
    [firstView flipBackView];
    
    Game *game = [self.dataSource itemAtIndexPath:[NSIndexPath indexPathForRow:carousel.currentItemIndex inSection:0]];
    
    if(self.lastVisibleCarouselIndex>carousel.currentItemIndex)
    {
        [self.slideLabelView slideLabelFromLeftWithText:game.commercialName];
    } else {
        [self.slideLabelView slideLabelFromRightWithText:game.commercialName];
    }
    self.lastVisibleCarouselIndex = carousel.currentItemIndex;
    
}


@end
