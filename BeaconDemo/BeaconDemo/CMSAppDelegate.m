//
//  CMSAppDelegate.m
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import "CMSAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "CMSBeaconDefaults.h"

@interface CMSAppDelegate()<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation CMSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // This location manager will be used to notify the user of region state transitions.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;

    CLBeaconRegion *foundRegion;
    CLBeaconRegion *baconRegion = [CMSBeaconDefaults baconRegion];
    foundRegion = [self.locationManager.monitoredRegions member:baconRegion];
    if (YES)//!foundRegion)
    {
        [self.locationManager startMonitoringForRegion:baconRegion];
    }
    
    CLBeaconRegion *registrationRegion = [CMSBeaconDefaults registrationRegion];
    foundRegion = [self.locationManager.monitoredRegions member:registrationRegion];
    if (YES)//!foundRegion)
    {
        [self.locationManager startMonitoringForRegion:registrationRegion];
    }
    
    CLBeaconRegion *sessionRegion = [CMSBeaconDefaults sessionRegion];
    foundRegion = [self.locationManager.monitoredRegions member:sessionRegion];
    if (YES)//!foundRegion)
    {
        [self.locationManager startMonitoringForRegion:sessionRegion];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // If the application is in the foreground, we will notify the user of the region's state via an alert.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    // A user can transition in or out of a region while the application is not running.
    // When this happens CoreLocation will launch the application momentarily, call this delegate method
    // and we will let the user know via a local notification.
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    CMSBeacon *beacon = nil;
    
    if ([region isEqual:[CMSBeaconDefaults baconRegion]])
    {
        beacon = [CMSBeaconDefaults baconBeacon];
        if (state == CLRegionStateInside)
        {
            notification.alertBody = @"You've got bacon!";
            notification.soundName = @"PigSnort.mp3";
        }
    }
    else if ([region isEqual:[CMSBeaconDefaults registrationRegion]])
    {
        beacon = [CMSBeaconDefaults registrationBeacon];
        if (state == CLRegionStateInside)
        {
            notification.alertBody = @"Welcome to CocoaConf Raleigh!";
        }
    }
    else if ([region isEqual:[CMSBeaconDefaults sessionRegion]])
    {
        beacon = [CMSBeaconDefaults sessionBeacon];
        if (state == CLRegionStateInside)
        {
            notification.alertBody = @"Welcome to the I, Beacon session at CocoaConf";
        }
    }
    
    [beacon setState:state];

    if (!beacon || state != CLRegionStateInside)
    {
        return;
    }
    
    // If the application is in the foreground, it will get a callback to application:didReceiveLocalNotification:.
    // If its not, iOS will display the notification to the user.
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
