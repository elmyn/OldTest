//
//  CardView.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "CardView.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>


#define kIpadCardSize 500.0f
#define kIphoneCardSize 300.0f
#define kIconSize 70.0f
#define kItemPadding 5.0f
#define kProgressViewHeight 40.0f

@interface CardView()
{
    float *progressValue;
}

@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL isFlipped;

@property (strong, nonatomic) UIView *firstView;
@property (strong, nonatomic) UIView *secondView;

@property (weak, nonatomic) ProgressView *progressView;

- (UIView*)createFirstViewWithFrame:(CGRect)frame;
- (UIView*)createSecondViewWithFrame:(CGRect)frame;
- (UIView*)createProgressViewWithFrame:(CGRect)frame;
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;
- (void)flipView;

@end

@implementation CardView


- (id)initCardView
{
    CGRect frame;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        frame = CGRectMake(0, 0, kIpadCardSize, kIpadCardSize);
    } else {
        frame = CGRectMake(0, 0, kIphoneCardSize, kIphoneCardSize);
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *singleFingerTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        
        self.secondView = [self createSecondViewWithFrame:frame];      
        self.firstView = [self createFirstViewWithFrame:frame];
        [self addSubview:self.firstView];
        

    }
    return self;
}

#pragma mark - subviews initialization

- (UIView*)createFirstViewWithFrame:(CGRect)frame
{
    UIView *firstView = [[UIView alloc] initWithFrame:frame];
    firstView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImageView *aFullImageView = [[UIImageView alloc] initWithFrame:frame];
    aFullImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.fullImageView = aFullImageView;
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    [firstView addSubview:self.fullImageView];
    
    return firstView;
}


- (UIView*)createSecondViewWithFrame:(CGRect)frame
{
    UIView *secondView = [[UIView alloc] initWithFrame:frame];
    secondView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [secondView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *aIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kItemPadding, kItemPadding, kIconSize, kIconSize)];
    aIconImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    self.iconImageView = aIconImageView;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [secondView addSubview:self.iconImageView];
    
    UILabel *gameNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kItemPadding * 2 + kIconSize,
                                                               kItemPadding,
                                                               frame.size.width - (kItemPadding * 3 + kIconSize),
                                                               kIconSize)];
    self.gameNameLabel = gameNameLabel;    
    self.gameNameLabel.textAlignment = NSTextAlignmentCenter;
    self.gameNameLabel.backgroundColor = [UIColor clearColor];
    self.gameNameLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
    self.gameNameLabel.font = [UIFont fontWithName:@"Lato-Regular" size:20];
    self.gameNameLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [secondView addSubview:self.gameNameLabel];


    UIView *progressView = [self createProgressViewWithFrame:frame];
    [secondView addSubview:progressView];
    
    UITextView *descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(kItemPadding,
                                                                                  kItemPadding * 4 + kIconSize + kProgressViewHeight,
                                                                                  frame.size.width - kItemPadding * 2,
                                                                                   frame.size.height - (kItemPadding * 5 + kIconSize + kProgressViewHeight))];
    self.descriptionTextView = descriptionTextView;
    self.descriptionTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.descriptionTextView.editable = NO;
    self.descriptionTextView.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    self.descriptionTextView.textColor = [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
    [secondView addSubview:descriptionTextView];
    
    return secondView;
}

- (UIView*)createProgressViewWithFrame:(CGRect)frame
{
    
    CGRect newFrame = CGRectMake(kItemPadding, kItemPadding * 2 + kIconSize, frame.size.width - 2*kItemPadding, kProgressViewHeight);
    ProgressView *aProgressView = [[ProgressView alloc] initWithFrame:newFrame];
    aProgressView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    self.progressView = aProgressView;
    return self.progressView;
    
}

#pragma mark - view flipping

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self flipView];
}

- (void)flipBackView
{
    if(self.isFlipped)
    {
        [self flipView];
    }
}

- (void)flipView
{
    if(!self.isAnimating)
    {
        if(!self.fullImageView.image) {return;}
        self.isAnimating = YES;
        
        UIView *viewToFlipIn;
        UIView *viewToFlipOut;
        
        if(self.isFlipped)
        {
            viewToFlipIn = self.firstView;
            viewToFlipOut = self.secondView;
        } else {
            viewToFlipIn = self.secondView;
            viewToFlipOut = self.firstView;
        }
        
        [self.secondView setFrame:AVMakeRectWithAspectRatioInsideRect(self.fullImageView.image.size,self.fullImageView.frame)];
        
        [UIView transitionFromView:viewToFlipOut
                            toView:viewToFlipIn
                          duration:0.25
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:^(BOOL finished) {
                            self.isAnimating = NO;
                            self.isFlipped = !self.isFlipped;
                            if(self.isFlipped)
                            {
                                [self.progressView setRating:_ratingValue];
                            } else {
                                [self.progressView setRating:0];
                            }
                        }];
    }
}


@end
