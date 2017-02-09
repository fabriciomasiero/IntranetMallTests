//
//  AFJASidePanelsViewController.h
//  PetIdealCliente
//
//  Created by Fabricio Masiero on 14/07/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanels/JASidePanelController.h"
#import <AFPlatform/AFPlatform.h>

@interface AFJASidePanelsViewController : JASidePanelController

@property (strong, nonatomic) AFApplicationUser *user;


@end
