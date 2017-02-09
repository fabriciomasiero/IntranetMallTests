//
//  AFBaseViewController.h
//  PetIdealCliente
//
//  Created by Fabricio Masiero on 14/07/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import <BALoadingView/BALoadingView.h>
#import <AFPlatform/AFPlatform.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <VMaskTextField/VMaskTextField.h>
#import <HexColors/HexColors.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

#import <TPKeyboardAvoiding/TPKeyboardAvoidingScrollView.h>

#pragma mark - Categories
#import "NSDate+Extras.h"
#import "NSString+Extras.h"
#import "NSData+Extras.h"
#import "UIImage+Extras.h"
#import "CALayer+Extras.h"
#import "UIButton+Extras.h"
//#import "UITextField+Extras.h"

//#import "UIImage+Extras.h"
//#import "CALayer+Extras.h"

#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "AFIMLogin.h"

#import "AFIMUser.h"

#import "Circular+CoreDataClass.h"
#import "CircularReader+CoreDataClass.h"
#import "Official+CoreDataClass.h"
#import "ServiceOrder+CoreDataClass.h"
#import "ServiceOrderDestinationUser+CoreDataClass.h"
#import "ServiceOrderFile+CoreDataClass.h"
#import "ServiceOrderAuthorizedUser+CoreDataClass.h"
#import "ServiceOrderApprover+CoreDataClass.h"
#import "UserSector+CoreDataClass.h"
#import "UserServiceType+CoreDataClass.h"
#import "ServiceOrderObservations+CoreDataClass.h"

#import <TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h>
#import <ObjectiveRecord/ObjectiveRecord.h>

#import <AFNetworking/AFNetworking.h>

#import <NSDate+DateTools.h>



@interface AFBaseViewController : UIViewController <CLLocationManagerDelegate, UIAlertViewDelegate>



- (void)saveUserInstance:(AFIMUser *)user;
- (void)loggoutUser:(AFIMUser *)user;
- (void)getUserWithCompletion:(void (^)(AFIMUser *user))completion;

- (void)basicMenuInitialization:(NSString *)storyboardId;

@property (strong, nonatomic) CLLocationManager *locationManager;


#pragma mark - Get Latitude And Longitude
- (NSDictionary *)getLatitudeAndLongitude;

- (void)showDefaultAlertView:(NSString *)title andMessage:(NSString *)message completionAction:(void (^)(NSString *action))completionHandler;
- (void)showTwoButtonsDefaultAlertView:(NSString *)title andMessage:(NSString *)message buttonTextCancel:(NSString *)textCancel buttonTextAccept:(NSString *)textAccept andCompletionAcceptAction:(void (^)(NSString *action))completionHandler;



@end
