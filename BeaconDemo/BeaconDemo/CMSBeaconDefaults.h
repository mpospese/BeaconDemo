//
//  CMSBeaconDefaults.h
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMSBeacon.h"

@interface CMSBeaconDefaults : NSObject

+ (NSUUID *)defaultProximityUUID;

+ (NSUUID *)estimoteProximityUUID;

+ (NSUUID *)roximityProximityUUID;

+ (CLBeaconRegion *)baconRegion;
+ (CLBeaconRegion *)registrationRegion;
+ (CLBeaconRegion *)sessionRegion;

+ (CMSBeacon *)baconBeacon;
+ (CMSBeacon *)registrationBeacon;
+ (CMSBeacon *)sessionBeacon;

@end
