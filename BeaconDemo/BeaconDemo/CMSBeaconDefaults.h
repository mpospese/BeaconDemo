//
//  CMSBeaconDefaults.h
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMSBeacon.h"

extern NSString * const kBaconRegionIdentifier;
extern NSString * const kRegistrationRegionIdentifier;
extern NSString * const kSessionRegionIdentifier;

@interface CMSBeaconDefaults : NSObject

+ (NSUUID *)defaultProximityUUID;

+ (NSUUID *)estimoteProximityUUID;

+ (NSUUID *)roximityProximityUUID;

+ (CLBeaconRegion *)baconRegion;
+ (CLBeaconRegion *)registrationRegion;
+ (CLBeaconRegion *)sessionRegion;
+ (NSArray *)regions;

+ (CMSBeacon *)baconBeacon;
+ (CMSBeacon *)registrationBeacon;
+ (CMSBeacon *)sessionBeacon;

@end
