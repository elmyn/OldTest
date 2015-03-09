//
//  Connection.h
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Store;

@interface Connection : NSObject

- (id)initWithStore:(Store*)store andURLString:(NSString*)URLString;
- (void)downloadData;
@end
