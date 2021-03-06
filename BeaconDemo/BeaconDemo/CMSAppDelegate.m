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
#import <AudioToolbox/AudioToolbox.h>

@interface CMSAppDelegate()<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) SystemSoundID pigSoundID;

@end

@implementation CMSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // This location manager will be used to notify the user of region state transitions.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;

    CLBeaconRegion *foundRegion;
    NSArray *regions = [CMSBeaconDefaults regions];
    
    for (CLBeaconRegion *region in regions)
    {
        foundRegion = [self.locationManager.monitoredRegions member:region];
        if (!foundRegion)
        {
            [self.locationManager startMonitoringForRegion:region];
        }
    }
    
    return YES;
}
							
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // If the application is in the foreground, we will notify the user of the region's state via an alert.
    BOOL playSound = [[[notification userInfo] objectForKey:@"playSound"] boolValue];
    
    if (playSound)
        AudioServicesPlaySystemSound([self pigSoundID]);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    // A user can transition in or out of a region while the application is not running.
    // When this happens CoreLocation will launch the application momentarily, call this delegate method
    // and we will let the user know via a local notification.
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    CMSBeacon *beacon = nil;
    
    if ([region.identifier isEqualToString:kBaconRegionIdentifier])
    {
        beacon = [CMSBeaconDefaults baconBeacon];
        if (state == CLRegionStateInside)
        {
            notification.alertBody = @"You've got bacon!";
            notification.soundName = @"PigSnort.mp3";
            [notification setUserInfo:@{@"playSound" : @YES}];
        }
        else if (state == CLRegionStateOutside)
        {
            notification.alertBody = @"Sadly, away from bacon.";
            notification.soundName = @"PigSnort.mp3";
        }
    }
    else if ([region.identifier isEqualToString:kRegistrationRegionIdentifier])
    {
        beacon = [CMSBeaconDefaults registrationBeacon];
        if (state == CLRegionStateInside)
        {
            notification.alertBody = @"Welcome to CocoaConf Raleigh!";
        }
    }
    else if ([region.identifier isEqualToString:kSessionRegionIdentifier])
    {
        beacon = [CMSBeaconDefaults sessionBeacon];
        if (state == CLRegionStateInside)
        {
            notification.alertBody = @"Welcome to the I, Beacon session at CocoaConf";
        }
    }
    
    [beacon setState:state];

    if (!notification.alertBody)
    {
        return;
    }
    
    
    // If the application is in the foreground, it will get a callback to application:didReceiveLocalNotification:.
    // If its not, iOS will display the notification to the user.
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

#pragma mark - Sounds

- (SystemSoundID)pigSoundID
{
    if (!_pigSoundID)
    {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"PigSnort" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:soundPath]), &_pigSoundID);
    }
    
    return _pigSoundID;
}

@end
