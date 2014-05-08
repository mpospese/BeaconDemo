//
//  CMSBeaconView.h
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMSBeacon.h"

@interface CMSBeaconView : UIView

- (instancetype)initWithBeacon:(CMSBeacon *)beacon;

@property (nonatomic, readonly) CMSBeacon *beacon;
@property (nonatomic) UIColor *textColor;

@end
