//
//  Connection.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 22.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "Connection.h"
#import "Store.h"
#import "Reachability.h"
#import "Game+Create.h"
#import "SDImageCache.h"

#define kUpdateTimeInHours 24

@interface Connection()

@property (nonatomic, strong) Store* store;
@property (nonatomic, strong) NSString* URLString;

- (BOOL)isConnected;
- (BOOL)isUpdateTime;
- (void)processDownloadedData:(NSArray*)downloadedArray;
@end

@implementation Connection

- (id)initWithStore:(Store*)store andURLString:(NSString*)URLString
{
    self = [super init];
    
    if(self)
    {
        self.store = store;
        self.URLString = URLString;
    }
    return self;
}

#pragma mark - data dowloading

-(void)downloadData
{
    if(![self isUpdateTime]) { return; }
    if(![self isConnected]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"It seems you have problems with connection. Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
         {
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:kNilOptions
                                                                        error:&error];
             if (!error) {
                 
                 NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                 NSDate *todaysDate = [NSDate date];
                 [prefs setObject:todaysDate forKey:@"lastDate"];
                 [prefs synchronize];
                 
                 NSArray *array = [jsonDict objectForKey:@"games"];
                 [self processDownloadedData:array];
             }
         }
         else if ([data length] == 0 && error == nil)
         {
             /* TODO work on error handling */
         }
         else if (error != nil)
         {
             /* TODO work on error handling */
             
         }
     }];
}

#pragma mark - data processing

- (void)processDownloadedData:(NSArray*)downloadedArray
{
    NSMutableArray *existingIds = [[NSMutableArray alloc] init];
    
    //create or update objects
    for (NSDictionary *gameDictionary in downloadedArray)
    {
        [Game createWithJSONComponents:gameDictionary
                           intoContext:self.store.managedObjectContext];
        
        [existingIds addObject:gameDictionary[@"sbName"]];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not (sbName in %@)", existingIds];
    [fetchRequest setPredicate:predicate];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Game"
                                      inManagedObjectContext:self.store.managedObjectContext];
    
    NSArray *results = [self.store.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //delete objects
    for (Game *game in results) {
        [self.store.managedObjectContext deleteObject:game];
        [[SDImageCache sharedImageCache] removeImageForKey:game.iconUrl];
        [[SDImageCache sharedImageCache] removeImageForKey:game.imageURL];
    }
    [self.store saveContext];
}



#pragma mark - bool methods
/* 
 TODO work on it to be thread safe and save last update after making sure last one did success
 */

- (BOOL)isUpdateTime
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDate *lastDate = [prefs objectForKey:@"lastDate"];
    if(!lastDate) { lastDate = [NSDate dateWithTimeIntervalSince1970:0]; }
    NSDate *todaysDate = [NSDate date];
    NSTimeInterval dateDiff = [todaysDate timeIntervalSinceNow] - [lastDate timeIntervalSinceNow];
    
    //convert second on hours
    if((dateDiff/3600)>=kUpdateTimeInHours)
    {
        return YES;
    } else
    {
        return NO;  
    }
}

- (BOOL)isConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
@end
