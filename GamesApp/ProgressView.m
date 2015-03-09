//
//  ProgressView.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "ProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import "UICountingLabel.h"

#define kCountInAnimationDuration 0.35f

@interface ProgressView()

@property (nonatomic, weak) UIView *progressTrack;
@property (nonatomic, weak) UICountingLabel *countingLabel;

@property (nonatomic, strong) NSArray *backgroundColorsArray;
@property (nonatomic, strong) NSArray *trackColorsArray;

@end

@implementation ProgressView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        
        self.backgroundColorsArray = [NSArray arrayWithObjects:
                                      [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f],
                                      [UIColor colorWithRed:255.0f/255.0f green:125.0f/255.0f blue:95.0f/255.0f alpha:1.0f],
                                      [UIColor colorWithRed:255.0f/255.0f green:160.0f/255.0f blue:95.0f/255.0f alpha:1.0f],
                                      [UIColor colorWithRed:165.0f/255.0f green:205.0f/255.0f blue:144.0f/255.0f alpha:1.0f],
                                      [UIColor colorWithRed:65.0f/255.0f green:195.0f/255.0f blue:0.0f/255.0f alpha:1.0f],
                                      [UIColor colorWithRed:65.0f/255.0f green:195.0f/255.0f blue:0.0f/255.0f alpha:1.0f], nil];
        self.trackColorsArray = [NSArray arrayWithObjects:
                                 [UIColor colorWithRed:110.0f/255.0f green:110.0f/255.0f blue:110.0f/255.0f alpha:1.0f],
                                 [UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:0.0f/255.0f alpha:1.0f],
                                 [UIColor colorWithRed:255.0f/255.0f green:102.0f/255.0f blue:0.0f/255.0f alpha:1.0f],
                                 [UIColor colorWithRed:105.0f/255.0f green:190.0f/255.0f blue:60.0f/255.0f alpha:1.0f],
                                 [UIColor colorWithRed:50.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1.0f],
                                 [UIColor colorWithRed:50.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1.0f], nil];
        
        self.backgroundColor = [self.backgroundColorsArray objectAtIndex:0];
        
        UIView *progressTrack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        self.progressTrack = progressTrack;
        self.progressTrack.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self.progressTrack setBackgroundColor:[self.trackColorsArray objectAtIndex:0]];
        [self addSubview:progressTrack];
      
        UICountingLabel *countingLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.countingLabel = countingLabel;
        self.countingLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.countingLabel.textAlignment = NSTextAlignmentCenter;
        self.countingLabel.textColor = [UIColor whiteColor];
        self.countingLabel.backgroundColor = [UIColor clearColor];
        self.countingLabel.font = [UIFont fontWithName:@"Lato-Bold" size:25];
        self.countingLabel.format = @"%.1f";
        [self addSubview:countingLabel];
        

    }
    return self;
}

- (void)setRating:(float)rating
{
    float progress = rating/5.0f;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
    [self.countingLabel countFrom:0 to:rating withDuration:kCountInAnimationDuration];
    [UIView animateWithDuration:kCountInAnimationDuration animations:^{
        [self.progressTrack setFrame:frame];
        self.backgroundColor = [self.backgroundColorsArray objectAtIndex:(int)rating];
        self.progressTrack.backgroundColor = [self.trackColorsArray objectAtIndex:(int)rating];
    }];
}

@end
