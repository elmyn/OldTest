//
//  MainViewController.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Store;

@interface MainViewController : UIViewController

- (id)initWithStore:(Store*)store;
- (void)downloadData;

@end
