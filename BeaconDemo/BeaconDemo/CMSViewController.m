//
//  CMSViewController.m
//  BeaconDemo
//
//  Created by Mark Pospesel on 5/8/14.
//  Copyright (c) 2014 Crazy Milk Software. All rights reserved.
//

#import "CMSViewController.h"
#import "CMSBeaconView.h"
#import "CMSBeacon.h"
#import "CMSBeaconDefaults.h"

const CGFloat kHeaderHeight = 40.f;

@interface CMSViewController ()<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic, weak) CMSBeaconView *baconView;
@property (nonatomic, weak) CMSBeaconView *registrationView;
@property (nonatomic, weak) CMSBeaconView *sessionView;

@end

@implementation CMSViewController

- (void)viewDidLoad
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithWhite:78/255.f alpha:1];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CMSBeacon *baconBeacon = [CMSBeaconDefaults baconBeacon];
    CMSBeaconView *baconView = [[CMSBeaconView alloc] initWithBeacon:baconBeacon];
    baconView.frame = CGRectMake(0, kHeaderHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 4 * (kHeaderHeight));
    baconView.backgroundColor = [UIColor colorWithRed:229/255.f green:104/255.f blue:96/255.f alpha:1];
    
    [self.view addSubview:baconView];
    self.baconView = baconView;
    
    CMSBeacon *registrationBeacon = [CMSBeaconDefaults registrationBeacon];
    CMSBeaconView *registrationView = [[CMSBeaconView alloc] initWithBeacon:registrationBeacon];
    registrationView.frame = CGRectMake(0, 2 * kHeaderHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - (4 * kHeaderHeight));
    registrationView.backgroundColor = [UIColor colorWithRed:46/255.f green:108/255.f blue:251/255.f alpha:1];
    
    [self.view addSubview:registrationView];
    self.registrationView = registrationView;
    
    CMSBeacon *sessionBeacon = [CMSBeaconDefaults sessionBeacon];
    CMSBeaconView *sessionView = [[CMSBeaconView alloc] initWithBeacon:sessionBeacon];
    sessionView.frame = CGRectMake(0, 3 * kHeaderHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - (4 * kHeaderHeight));
    sessionView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:241/255.f alpha:1];
    sessionView.textColor = [UIColor colorWithWhite:51/255.f alpha:1];
    
    [self.view addSubview:sessionView];
    self.sessionView = sessionView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSArray *regions = [CMSBeaconDefaults regions];
    for (CLBeaconRegion *region in regions)
    {
        [self.locationManager startRangingBeaconsInRegion:region];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSArray *regions = [CMSBeaconDefaults regions];
    for (CLBeaconRegion *region in regions)
    {
        [self.locationManager stopRangingBeaconsInRegion:region];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CMSBeacon *beacon = nil;
    
    if ([region.identifier isEqualToString:kBaconRegionIdentifier])
    {
        beacon = [CMSBeaconDefaults baconBeacon];
    }
    else if ([region.identifier isEqualToString:kRegistrationRegionIdentifier])
    {
        beacon = [CMSBeaconDefaults registrationBeacon];
    }
    else if ([region.identifier isEqualToString:kSessionRegionIdentifier])
    {
        beacon = [CMSBeaconDefaults sessionBeacon];
    }
    
    // There may be multiple beacons in this region,
    // we will report proximity as the closest of all reported beacons
    CLProximity closest = CLProximityUnknown;
    for (CLBeacon *beacon in beacons)
    {
        if (closest == CLProximityUnknown || (beacon.proximity != CLProximityUnknown && beacon.proximity < closest))
        {
            closest = beacon.proximity;
        }
    }
    
    [beacon setProximity:closest];
}

@end
