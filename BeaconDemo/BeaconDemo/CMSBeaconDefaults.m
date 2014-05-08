//
//  CMSBeaconDefaults.m
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import "CMSBeaconDefaults.h"

@implementation CMSBeaconDefaults

+ (NSUUID *)defaultProximityUUID;
{
    static NSUUID *_defaultProximityUUID = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultProximityUUID = [[NSUUID alloc] initWithUUIDString:@"94711E57-F8A7-4A2E-A485-649898B9C14A"];
    });
    
    return _defaultProximityUUID;
}

+ (NSUUID *)estimoteProximityUUID;
{
    static NSUUID *_estimoteProximityUUID = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _estimoteProximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    });
    
    return _estimoteProximityUUID;
}

+ (NSUUID *)roximityProximityUUID;
{
    static NSUUID *_roximityProximityUUID = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _roximityProximityUUID = [[NSUUID alloc] initWithUUIDString:@"8DEEFBB9-F738-4297-8040-96668BB44281"];
    });
    
    return _roximityProximityUUID;
}

// The Bacon beacon is the Cocktail Mint-colored estimote (Major: 4, Minor: 8)
+ (CLBeaconRegion *)baconRegion;
{
    static CLBeaconRegion *_baconRegion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _baconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[self estimoteProximityUUID] major:4 minor:8 identifier:@"com.crazymilksoftware.baconRegion"];
    });
    
    return _baconRegion;
}

+ (CMSBeacon *)baconBeacon
{
    static CMSBeacon *_baconBeacon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _baconBeacon = [[CMSBeacon alloc] initWithName:@"Bacon" region:[self baconRegion]];
    });
    
    return _baconBeacon;
}

// The Registration beacon is the Cool Marshmallow-colored estimote (Major: 4, Minor: 9)
+ (CLBeaconRegion *)registrationRegion;
{
    static CLBeaconRegion *_registrationRegion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _registrationRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[self estimoteProximityUUID] major:4 minor:9 identifier:@"com.crazymilksoftware.registrationRegion"];
    });
    
    return _registrationRegion;
}

+ (CMSBeacon *)registrationBeacon
{
    static CMSBeacon *_registrationBeacon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _registrationBeacon = [[CMSBeacon alloc] initWithName:@"Registration Desk" region:[self registrationRegion]];
    });
    
    return _registrationBeacon;
}

// The Session beacons are 3 USB-powered Bleu station beacons (Major: 1, Minor: 1 – 3)
+ (CLBeaconRegion *)sessionRegion;
{
    static CLBeaconRegion *_sessionRegion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[self defaultProximityUUID] major:1 identifier:@"com.crazymilksoftware.sessionRegion"];
    });
    
    return _sessionRegion;
}

+ (CMSBeacon *)sessionBeacon
{
    static CMSBeacon *_sessionBeacon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionBeacon = [[CMSBeacon alloc] initWithName:@"Session: I, Beacon" region:[self sessionRegion]];
    });
    
    return _sessionBeacon;
}

@end
