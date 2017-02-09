//
//  AFBaseViewController.m
//  PetIdealCliente
//
//  Created by Fabricio Masiero on 14/07/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import "AFBaseViewController.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AFBaseViewController () 



@end

@implementation AFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void)basicMenuInitialization:(NSString *)storyboardId {
    [[NSUserDefaults standardUserDefaults] setObject:storyboardId forKey:@"leftPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUserInstance:(AFIMUser *)user {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate setUser:user];
}
- (void)loggoutUser:(AFIMUser *)user {
    [AFIMLogin removeUserInfos];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate setUser:nil];
    [Circular deleteAll];
    [CircularReader deleteAll];
    [Official deleteAll];
    [ServiceOrder deleteAll];
    [ServiceOrderFile deleteAll];
    [ServiceOrderApprover deleteAll];
    [ServiceOrderAuthorizedUser deleteAll];
    [ServiceOrderDestinationUser deleteAll];
    [UserSector deleteAll];
    [UserServiceType deleteAll];
    
    
}
- (void)getUserWithCompletion:(void (^)(AFIMUser *user))completion {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.user) {
        completion(appDelegate.user);
    } else {
        NSDictionary *dic = [AFIMLogin userInfos];
        if (dic) {
            AFIMShoppings *shopping = [[AFIMShoppings alloc] initWithDictionary:dic];
            [AFIMLogin loginWithUserName:dic[@"login"] password:dic[@"password"] shopping:shopping andCompletion:^(AFIMUser *user) {
                [self saveUserInstance:user];
            } failure:^(NSError *error) {
            
            }];
        }
    }
}
- (void)showDefaultAlertView:(NSString *)title andMessage:(NSString *)message completionAction:(void (^)(NSString *action))completionHandler {
    
    if ([UIAlertController class]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
    
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            completionHandler(@"Return");
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
}
- (void)showTwoButtonsDefaultAlertView:(NSString *)title andMessage:(NSString *)message buttonTextCancel:(NSString *)textCancel buttonTextAccept:(NSString *)textAccept andCompletionAcceptAction:(void (^)(NSString *action))completionHandler {
    if ([UIAlertController class]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:textCancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:textAccept style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            completionHandler(@"Return");
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
}


#pragma mark - Get Latitude And Longitude
- (NSDictionary *)getLatitudeAndLongitude {
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER) {
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    float latitude = _locationManager.location.coordinate.latitude;
    float longitude = _locationManager.location.coordinate.longitude;
    [[NSUserDefaults standardUserDefaults] setFloat:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setFloat:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (latitude == 0.f || longitude == 0.f) {
        return @{@"latitude" : @(0), @"longitude" : @(0)};
    } else {
        return @{@"latitude" : @(latitude), @"longitude" : @(longitude)};
    }
}
@end
