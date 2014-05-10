//
//  CMSBeaconView.m
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import "CMSBeaconView.h"
#import <QuartzCore/QuartzCore.h>

@interface CMSBeaconView()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UILabel *proximityLabel;
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation CMSBeaconView

//static int _KVOStateContext;
static int _KVOProximityContext;
static int _KVOLastSeenContext;

static NSDateFormatter *_timeFormatter;

- (instancetype)initWithBeacon:(CMSBeacon *)beacon;
{
    self = [super init];
    if (self) {
        // Initialization code
        _beacon = beacon;
        _textColor = [UIColor whiteColor];
        [self loadContentView];
        
        //[beacon addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:&_KVOStateContext];
        [beacon addObserver:self forKeyPath:@"proximity" options:NSKeyValueObservingOptionNew context:&_KVOProximityContext];
        [beacon addObserver:self forKeyPath:@"lastSeen" options:NSKeyValueObservingOptionNew context:&_KVOLastSeenContext];
    }
    return self;
}

- (void)dealloc
{
    //[_beacon removeObserver:self forKeyPath:@"state" context:&_KVOStateContext];
    [_beacon removeObserver:self forKeyPath:@"proximity" context:&_KVOProximityContext];
    [_beacon removeObserver:self forKeyPath:@"lastSeen" context:&_KVOLastSeenContext];
}

+ (void)load
{
    _timeFormatter = [NSDateFormatter new];
    [_timeFormatter setDateStyle:NSDateFormatterShortStyle];
    [_timeFormatter setTimeStyle:NSDateFormatterShortStyle];
}

- (void)updateState
{
    switch (self.beacon.state) {
        case CLRegionStateInside:
            self.stateLabel.text = @"Inside";
            break;
            
        case CLRegionStateOutside:
            self.stateLabel.text = @"Outside";
            break;
            
        case CLRegionStateUnknown:
            self.stateLabel.text = @"Unknown";
            break;
            
        default:
            self.stateLabel.text = @"None";
            break;
    }
}

- (void)updateTime
{
    if (!self.beacon.lastSeen)
        self.timeLabel.text = @"Never";
    else
        self.timeLabel.text = [_timeFormatter stringFromDate:self.beacon.lastSeen];
}

- (void)updateProximity
{
    switch (self.beacon.proximity) {
        case CLProximityUnknown:
            self.proximityLabel.text = @"Unknown";
            break;
            
        case CLProximityFar:
            self.proximityLabel.text = @"Far";
            break;
            
        case CLProximityImmediate:
            self.proximityLabel.text = @"Immedidate";
            break;
            
        case CLProximityNear:
            self.proximityLabel.text = @"Near";
            break;
            
        default:
            self.proximityLabel.text = nil;
            break;
    }
}

#pragma mark - Properties

- (void)setTextColor:(UIColor *)textColor
{
    if ([_textColor isEqual:textColor])
        return;
    
    _textColor = textColor;
    self.nameLabel.textColor = textColor;
    self.stateLabel.textColor = textColor;
    self.proximityLabel.textColor = textColor;
    self.timeLabel.textColor = textColor;
}

#pragma mark - Subviews

- (void)loadContentView
{
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor redColor];
    
    [self loadNameLabel];
    [self loadStateLabel];
    [self loadProximityLabel];
    [self loadTimeLabel];
    
    [self loadConstraints];
    
    [self updateState];
    [self updateTime];
}

- (void)loadNameLabel
{
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = self.beacon.name;
    nameLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
    nameLabel.textColor = self.textColor;
    
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)loadStateLabel
{
    UILabel *stateLabel = [UILabel new];
    stateLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    stateLabel.textColor = self.textColor;
    stateLabel.hidden = YES;
    
    [self addSubview:stateLabel];
    self.stateLabel = stateLabel;
}

- (void)loadProximityLabel
{
    UILabel *proximityLabel = [UILabel new];
    proximityLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    proximityLabel.textColor = self.textColor;
    
    [self addSubview:proximityLabel];
    self.proximityLabel = proximityLabel;
}

- (void)loadTimeLabel
{
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    timeLabel.textColor = self.textColor;
    
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

- (void)loadConstraints
{
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:
     @[
       [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:15],
       [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:20],
       [NSLayoutConstraint constraintWithItem:self.stateLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-15],
       [NSLayoutConstraint constraintWithItem:self.stateLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:12],
       [NSLayoutConstraint constraintWithItem:self.proximityLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-15],
       [NSLayoutConstraint constraintWithItem:self.proximityLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:12],
       [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-15],
       [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:28],
       ]
     ];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /*if ([keyPath isEqualToString:@"state"] && context == & _KVOStateContext) {
        //only show the table view once we have data to show.
        [self updateState];
    }*/
    if ([keyPath isEqualToString:@"proximity"] && context == & _KVOProximityContext) {
        //only show the table view once we have data to show.
        [self updateProximity];
    }
    else if ([keyPath isEqualToString:@"lastSeen"] && context == & _KVOLastSeenContext) {
        //only show the table view once we have data to show.
        [self updateTime];
    }
}

@end
