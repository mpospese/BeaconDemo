//
//  CMSBeacon.m
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import "CMSBeacon.h"

@implementation CMSBeacon

- (instancetype)initWithName:(NSString *)name region:(CLBeaconRegion *)region;
{
    self = [super init];
    if (self)
    {
        _name = [name copy];
        _region = region;
        _state = CLRegionStateUnknown;
        _proximity = CLProximityUnknown;
    }
    return self;
}

- (void)setProximity:(CLProximity)proximity
{
    if (_proximity == proximity)
        return;
    
    _proximity = proximity;
    [self setLastSeen:[NSDate date]];
}

- (void)setState:(CLRegionState)state
{
    if (_state == state)
        return;
    
    _state = state;
    [self setLastSeen:[NSDate date]];
}

@end
