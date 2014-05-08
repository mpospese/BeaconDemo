//
//  CMSBeacon.h
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMSBeacon : NSObject

@property (nonatomic, readonly) CLBeaconRegion *region;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign) CLRegionState state;
@property (nonatomic, assign) CLProximity proximity;
@property (nonatomic) NSDate *lastSeen;

- (instancetype)initWithName:(NSString *)name region:(CLBeaconRegion *)region;

@end
