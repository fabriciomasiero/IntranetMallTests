//
//  AFIMServiceOrderDetailViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 05/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderDetailViewController.h"
#import "AFIMLinkViewController.h"
#import "AFIMServiceOrderObservations.h"
#import "AFDatabaseManager.h"
#import "AFIMServiceOrderApproved.h"
#import "AFIMServiceOrderFile.h"
#import "AFIMServiceOrderApprovers.h"

@interface AFIMServiceOrderDetailViewController ()

@end

@implementation AFIMServiceOrderDetailViewController

#pragma mark - Did loads
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    if (_serviceOrder) {
        NSString *title = [NSString stringWithFormat:@"OS %d", _serviceOrder.serviceOrderId];
        
        [self setTitle:title];
    } else {
        NSString *title = [NSString stringWithFormat:@"OS %@", _serviceOrderConsult.serviceOrderId];
        
        [self setTitle:title];
    }
    
    [self getUserWithCompletion:^(AFIMUser *user) {
        _user = user;
        [self customOrganization];
        [self checkIfICanComment];
    }];
    
    
    
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [_tblView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)refreshAutoLayout:(UIView *)view {
    [view setNeedsLayout];
    [view layoutIfNeeded];
}
- (void)checkIfICanComment {
    _iCanComment = NO;
    for (ServiceOrderApprover *sApprover in _approvers) {
        if ([sApprover isKindOfClass:[ServiceOrderApprover class]]) {
            if (sApprover.userApproverId == [_user.userId intValue]) {
                _iCanComment = YES;
            }
        }
    }
}
- (void)customOrganization {
    [self prepareToOrganizeAuthorizedUsers];
    [self prepareToOrganizeApprovers];
    [self prepareToOrganizeObservations];
}

#pragma mark - Organizing lists
- (void)prepareToOrganizeAuthorizedUsers {
    if (_serviceOrder) {
        if ([[_serviceOrder.authorizedUsers allObjects]  count] > 0) {
            NSMutableArray *mutableAuthorized = [[NSMutableArray alloc] init];
            [mutableAuthorized addObject:@"header"];
            [mutableAuthorized addObjectsFromArray:[_serviceOrder.authorizedUsers allObjects]];
            _authorizedUsers = [NSArray arrayWithArray:[mutableAuthorized mutableCopy]];
        }
    } else {
        if ([_serviceOrderConsult.authorizedUsers  count] > 0) {
            NSMutableArray *mutableAuthorized = [[NSMutableArray alloc] init];
            [mutableAuthorized addObject:@"header"];
            [mutableAuthorized addObjectsFromArray:_serviceOrderConsult.authorizedUsers];
            _authorizedUsers = [NSArray arrayWithArray:[mutableAuthorized mutableCopy]];
        }
    }
}
- (void)prepareToOrganizeApprovers {
    if (_serviceOrder) {
        if ([[_serviceOrder.approvers allObjects] count] > 0) {
            NSMutableArray *mutableApprovers = [[NSMutableArray alloc] init];
            [mutableApprovers addObject:@"header"];
            [mutableApprovers addObjectsFromArray:[_serviceOrder.approvers allObjects]];
            _approvers = [NSArray arrayWithArray:[mutableApprovers mutableCopy]];
        }
    } else {
        if ([_serviceOrderConsult.approvers count] > 0) {
            NSMutableArray *mutableApprovers = [[NSMutableArray alloc] init];
            [mutableApprovers addObject:@"header"];
            [mutableApprovers addObjectsFromArray:_serviceOrderConsult.approvers];
            _approvers = [NSArray arrayWithArray:[mutableApprovers mutableCopy]];
        }
    }
}
- (NSArray *)prepareToOrganizePhotos {
    NSMutableArray *mutablePhotos = [[NSMutableArray alloc] init];
    if (_serviceOrder) {
        for (ServiceOrderFile *f in [_serviceOrder.files allObjects]) {
            if ([f.fileExtension isEqualToString:@"jpg"] || [f.fileExtension isEqualToString:@"png"] ) {
                [mutablePhotos addObject:f.fileUrl];
            }
        }
    } else {
        for (AFIMServiceOrderFile *f in _serviceOrderConsult.files) {
            if ([f.fileExtension isEqualToString:@"jpg"] || [f.fileExtension isEqualToString:@"png"] ) {
                [mutablePhotos addObject:f.fileUrl];
            }
        }
    }
    NSArray *photos = [NSArray arrayWithArray:[mutablePhotos mutableCopy]];
    return photos;
}
- (void)prepareToOrganizeObservations {
    if (_serviceOrder) {
        
    
        if ([[_serviceOrder.observations allObjects] count] > 0) {
            NSMutableArray *mutableObservations = [[NSMutableArray alloc] init];
            [mutableObservations addObjectsFromArray:[_serviceOrder.observations allObjects]];
            
            
            NSArray *obs = [NSArray arrayWithArray:[mutableObservations mutableCopy]];
            NSSortDescriptor *sortTime = [NSSortDescriptor sortDescriptorWithKey:@"registerHour" ascending:YES];
            
            _observations = [obs sortedArrayUsingDescriptors:@[sortTime]];
        }
    } else {
        if ([_serviceOrderConsult.observations count] > 0) {
            NSMutableArray *mutableObservations = [[NSMutableArray alloc] init];
            [mutableObservations addObjectsFromArray:_serviceOrderConsult.observations];
            
            
            NSArray *obs = [NSArray arrayWithArray:[mutableObservations mutableCopy]];
            NSSortDescriptor *sortTime = [NSSortDescriptor sortDescriptorWithKey:@"registerHour" ascending:YES];
            
            _observations = [obs sortedArrayUsingDescriptors:@[sortTime]];
        }
    }
}
#pragma mark - Open PDF
- (void)openPdf:(NSString *)pdfUrl {
    [self performSegueWithIdentifier:@"showLink" sender:pdfUrl];
}
#pragma mark - Initialize Photo Brownser
- (void)initPhotoBrownserWith:(NSInteger)index {
    if (_serviceOrder) {
        ServiceOrderFile *f = [_serviceOrder.files allObjects][index];
        if ([f.fileExtension isEqualToString:@"pdf"]) {
            [self openPdf:f.fileUrl];
            return;
        }
    } else {
        AFIMServiceOrderFile *f = _serviceOrderConsult.files[index];
        if ([f.fileExtension isEqualToString:@"pdf"]) {
            [self openPdf:f.fileUrl];
            return;
        }
    }
    NSArray *phList = [self prepareToOrganizePhotos];
    
    for (NSString *s in phList) {
        [_photos addObject:[NSURL URLWithString:s]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    
    
    [browser setCurrentPhotoIndex:index];
    
    [self.navigationController pushViewController:browser animated:YES];
    
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    
    
}

//section expirado
//cell de nome - CellName
//cell de servico - CellService
//cell de detalhe de servico - CellServiceDetail
//cell de pessoa autorizada header - CellAuthorizedUsersHeader
//cell de pessoa autorizada - CellAuthorizedUsers
//cell de pessoa autorizada footer - CellAuthorizedUsersFooter
//cell de arquivos anexados - CellFiles
//cell de comentarios - CellServiceDetail
//cell de approver header - CellApproversHeader
//cell de approver - CellApprovers
//cell de approver footer - CellAuthorizedUsersFooter

#pragma mark - Organizing Cells EACH INDEX
#pragma mark - Organizing Cells EACH INDEX
- (AFIMServiceOrderDetailCellTableViewCell *)createCellNameWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellName";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *enterprise = @"";
    NSString *registerDate = @"";
    NSString *registerHour = @"";
    NSString *shopkeeperName = @"";
    NSString *phone = @"";
    NSString *requesterName = @"";
    if (_serviceOrder) {
        enterprise = _serviceOrder.enterprise;
        registerDate = [NSString stringGetDayDate:_serviceOrder.registerDate];
        registerHour = [NSString stringGetHourDate:_serviceOrder.registerHour];
        shopkeeperName = _serviceOrder.shopkeeperName;
        phone = _serviceOrder.phone;
        requesterName = _serviceOrder.requesterName;
    } else {
        enterprise = _serviceOrderConsult.enterprise;
        registerDate = [NSString stringGetDayDate:_serviceOrderConsult.registerDate];
        registerHour = [NSString stringGetHourDate:_serviceOrderConsult.registerHour];
        shopkeeperName = _serviceOrderConsult.shopkeeperName;
        phone = _serviceOrderConsult.phone;
        requesterName = _serviceOrderConsult.requesterName;
    }
    
    [cell.lblCellNameStoreName setText:enterprise];
    
    [cell.lblCellNameDate setText:registerDate];
    [cell.lblCellNameHour setText:registerHour];
    
    [cell.lblCellNameShopkeeperName setText:shopkeeperName];
    [cell.lblCellNamePhone setText:phone];
    [cell.lblCellNameRequester setText:requesterName];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.viewCellName.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    [self refreshAutoLayout:cell.viewCellName];
    
    
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellServiceWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellService";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    NSString *serviceType = @"";
    NSString *initialDate = @"";
    NSString *finalDate = @"";
    NSString *initialHour = @"";
    NSString *finalHour = @"";
    
    if (_serviceOrder) {
        serviceType = _serviceOrder.serviceType;
        initialDate = [NSString stringGetDayDate:_serviceOrder.initialDate];
        finalDate = [NSString stringGetDayDate:_serviceOrder.finalDate];
        initialHour = [NSString stringGetHourDate:_serviceOrder.initialHour];
        finalHour = [NSString stringGetHourDate:_serviceOrder.finalDate];
        
    } else {
        serviceType = _serviceOrderConsult.serviceType;
        initialDate = [NSString stringGetDayDate:_serviceOrderConsult.initialDate];
        finalDate = [NSString stringGetDayDate:_serviceOrderConsult.finalDate];
        initialHour = [NSString stringGetHourDate:_serviceOrderConsult.initialHour];
        finalHour = [NSString stringGetHourDate:_serviceOrderConsult.finalDate];

    }
    
    
    [cell.lblCellServiceServiceName setText:serviceType];
    
    [cell.lblCellServiceInitialDate setText:initialDate];
    [cell.lblCellServiceFinalDate setText:finalDate];
    [cell.lblCellServiceInitialHour setText:initialHour];
    [cell.lblCellServiceFinalHour setText:finalHour];
    [cell.viewCellService.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    
    [self refreshAutoLayout:cell.viewCellService];
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellServiceDetailWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView isDetails:(BOOL)details {
    static NSString *CellIdentifier = @"CellServiceDetail";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.lblCellServiceDetailInfo setNumberOfLines:0];
    
    [self refreshAutoLayout:cell.viewCellServiceDetail];
    if (details) {
        [cell.lblCellServiceDetailPlaceholder setText:@"DETALHES DO SERVIÇO"];
        if (_serviceOrder) {
            [cell.lblCellServiceDetailInfo setText:_serviceOrder.serviceOrderDescription];
        } else {
            [cell.lblCellServiceDetailInfo setText:_serviceOrderConsult.serviceOrderDescription];
        }
        [cell.lblCellServiceDetailInfo sizeToFit];
        [cell.lblCellServiceDetailInfo setBackgroundColor:[UIColor whiteColor]];
        
    } else {
        [cell.lblCellServiceDetailPlaceholder setText:@"OBSERVAÇÕES DO SERVIÇO"];
    }
    
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellObservationsWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellObservations";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (_serviceOrder) {
        
        if ([_observations[indexPath.row] isKindOfClass:[ServiceOrderObservations class]]) {
            ServiceOrderObservations *observation = _observations[indexPath.row];
            [cell.lblCellObservationsName setText:observation.userObservationName];
            [cell.lblCellObservationsObservation setText:observation.observation];
            [cell.lblCellObservationsDate setText:[NSString stringGetDateToShow:[NSDate dateComposeDate:observation.registerDate withHour:observation.registerHour]]];
            if ([observation.registerHour dateSinceFewMinutesAgo]) {
                [cell.viewCellObservationsStatus setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
            } else {
                [cell.viewCellObservationsStatus setBackgroundColor:[UIColor whiteColor]];
            }
        }
    } else {
        if ([_observations[indexPath.row] isKindOfClass:[AFIMServiceOrderObservations class]]) {
            AFIMServiceOrderObservations *observation = _observations[indexPath.row];
            [cell.lblCellObservationsName setText:observation.userObservationName];
            [cell.lblCellObservationsObservation setText:observation.observation];
            [cell.lblCellObservationsDate setText:[NSString stringGetDateToShow:[NSDate dateComposeDate:observation.registerDate withHour:observation.registerHour]]];
            if ([observation.registerHour dateSinceFewMinutesAgo]) {
                [cell.viewCellObservationsStatus setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
            } else {
                [cell.viewCellObservationsStatus setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellHeaderWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellAuthorizedUsersHeader";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section == 7) {
        [cell.lblCellAuthorizedUserHeaderTitle setText:@"COMENTÁRIOS"];
    }
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellApproverHeaderWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellApproversHeader";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellListWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView kindOfListAuthorized:(BOOL)authorized {
    
    if (authorized) {
        static NSString *CellIdentifier = @"CellAuthorizedUsers";
        
        AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (_serviceOrder) {
            if ([_authorizedUsers[indexPath.row] isKindOfClass:[ServiceOrderAuthorizedUser class]]) {
                ServiceOrderAuthorizedUser *authorizedUser = _authorizedUsers[indexPath.row];
                [cell.lblAuthorizedUserName setText:authorizedUser.name];
                [cell.lblAuthorizedUserNameEnterprise setText:authorizedUser.enterprise];
                [cell.lblAuthorizedUserDocumentInsideCountry setText:authorizedUser.documentInsideCountry];
                [cell.lblCellAuthorizedUserHeaderTitle setText:@"PESSOAS AUTORIZADAS"];
            }
        } else {
            if ([_authorizedUsers[indexPath.row] isKindOfClass:[AFIMServiceOrderAuthorizedUsers class]]) {
                AFIMServiceOrderAuthorizedUsers *authorizedUser = _authorizedUsers[indexPath.row];
                [cell.lblAuthorizedUserName setText:authorizedUser.name];
                [cell.lblAuthorizedUserNameEnterprise setText:authorizedUser.enterprise];
                [cell.lblAuthorizedUserDocumentInsideCountry setText:authorizedUser.documentInsideCountry];
                [cell.lblCellAuthorizedUserHeaderTitle setText:@"PESSOAS AUTORIZADAS"];
            }
        }
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"CellApprovers";
        
        AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (_serviceOrder) {
            if ([_approvers[indexPath.row] isKindOfClass:[ServiceOrderApprover class]]) {
                ServiceOrderApprover *approved = _approvers[indexPath.row];
                
                if (indexPath.row % 2) {
                    [cell.contentView setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
                } else {
                    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
                }
                [cell.viewCellApproversTypes setBackgroundColor:cell.contentView.backgroundColor];
                [cell.lblCellApproversStatus setBackgroundColor:cell.contentView.backgroundColor];
                
                
                
                [cell.lblCellApproversResponsible setText:approved.name];
                [cell.viewCellApproversTypes setHidden:YES];
                if (approved.action == 1 || approved.action == 3) {
                    [cell.lblCellApproversStatus setText:@"Aprovado"];
                } else if (approved.action == 2) {
                    [cell.viewCellApproversTypes setHidden:YES];
                    [cell.lblCellApproversStatus setText:@"Aguardando aprovação"];
                } else {
                    
                    if (approved.userApproverId == [_user.userId intValue]) {
                        [cell.viewCellApproversTypes setUserInteractionEnabled:YES];
                        [cell.viewCellApproversYes setUserInteractionEnabled:YES];
                        [cell.lblCellApproversYes setUserInteractionEnabled:YES];
                        
                        [cell.viewCellApproversNo setUserInteractionEnabled:YES];
                        [cell.lblCellApproversNo setUserInteractionEnabled:YES];
                        
                        [cell.viewCellApproversYes addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(approveOsButtonCell:)]];
                        [cell.lblCellApproversYes addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(approveOsButtonCell:)]];
                        
                        [cell.viewCellApproversNo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repproveOsButtonCell:)]];
                        [cell.lblCellApproversNo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repproveOsButtonCell:)]];
                        
                        
                        
                        [cell.viewCellApproversTypes setHidden:NO];
                        switch (_approvalStatus) {
                            case AFIMServiceOrderApprovalStatusApproved:
                                [cell.viewCellApproversYesStatus setHidden:NO];
                                [cell.viewCellApproversNoStatus setHidden:YES];
                                break;
                            case AFIMServiceOrderApprovalStatusRepproved:
                                [cell.viewCellApproversYesStatus setHidden:YES];
                                [cell.viewCellApproversNoStatus setHidden:NO];
                                break;
                            default:
                                [cell.viewCellApproversYesStatus setHidden:YES];
                                [cell.viewCellApproversNoStatus setHidden:YES];
                                
                                break;
                        }
                        [cell.lblCellApproversStatus setText:@"É você"];
                    }
                }
            } else {
                [cell.viewCellApproversTypes setHidden:YES];
            }
        } else {
            if ([_approvers[indexPath.row] isKindOfClass:[AFIMServiceOrderApprovers class]]) {
                AFIMServiceOrderApprovers *approved = _approvers[indexPath.row];
                
                if (indexPath.row % 2) {
                    [cell.contentView setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
                } else {
                    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
                }
                [cell.viewCellApproversTypes setBackgroundColor:cell.contentView.backgroundColor];
                [cell.lblCellApproversStatus setBackgroundColor:cell.contentView.backgroundColor];
                
                
                
                [cell.lblCellApproversResponsible setText:approved.name];
                [cell.viewCellApproversTypes setHidden:YES];
                if ([approved.action intValue] == 1 || [approved.action intValue] == 3) {
                    [cell.lblCellApproversStatus setText:@"Aprovado"];
                } else if ([approved.action intValue] == 2) {
                    [cell.viewCellApproversTypes setHidden:YES];
                    [cell.lblCellApproversStatus setText:@"Aguardando aprovação"];
                } else {
                    
                    if ([approved.userApproverId intValue] == [_user.userId intValue]) {
                        [cell.viewCellApproversTypes setUserInteractionEnabled:YES];
                        [cell.viewCellApproversYes setUserInteractionEnabled:YES];
                        [cell.lblCellApproversYes setUserInteractionEnabled:YES];
                        
                        [cell.viewCellApproversNo setUserInteractionEnabled:YES];
                        [cell.lblCellApproversNo setUserInteractionEnabled:YES];
                        
                        [cell.viewCellApproversYes addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(approveOsButtonCell:)]];
                        [cell.lblCellApproversYes addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(approveOsButtonCell:)]];
                        
                        [cell.viewCellApproversNo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repproveOsButtonCell:)]];
                        [cell.lblCellApproversNo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repproveOsButtonCell:)]];
                        
                        
                        
                        [cell.viewCellApproversTypes setHidden:NO];
                        switch (_approvalStatus) {
                            case AFIMServiceOrderApprovalStatusApproved:
                                [cell.viewCellApproversYesStatus setHidden:NO];
                                [cell.viewCellApproversNoStatus setHidden:YES];
                                break;
                            case AFIMServiceOrderApprovalStatusRepproved:
                                [cell.viewCellApproversYesStatus setHidden:YES];
                                [cell.viewCellApproversNoStatus setHidden:NO];
                                break;
                            default:
                                [cell.viewCellApproversYesStatus setHidden:YES];
                                [cell.viewCellApproversNoStatus setHidden:YES];
                                
                                break;
                        }
                        [cell.lblCellApproversStatus setText:@"É você"];
                    }
                }
            } else {
                [cell.viewCellApproversTypes setHidden:YES];
            }
        }
        return cell;
    }
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellFooterWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellAuthorizedUsersFooter";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.viewCellFooter.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    
    [self refreshAutoLayout:cell.viewCellFooter];
    return cell;
}
- (AFIMServiceOrderDetailCellTableViewCell *)createCellFilesWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellFiles";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (_serviceOrder) {
        NSArray *files = [_serviceOrder.files allObjects];
        for (int i = 0; i < [files count]; i++) {
            
            
            float size = 58.f;
            float spacementX = 10.f;
            float spacement = size + spacementX * i;
            
            if (i == 0) {
                spacement = 0.f;
            }
            
            UIView *subview = [[UIView alloc] init];
            
            [subview setFrame:CGRectMake(spacement, 0.f, size, size - 20.f)];
            
            
            ServiceOrderFile *file = files[i];
            
            UIImageView *imgSubview = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 5.f, size, size - 20.f)];
            //        [imgSubview setContentMode:UIViewContentModeScaleAspectFill];
            [imgSubview setContentMode:UIViewContentModeScaleAspectFit];
            
            NSURL *urlImg = [NSURL URLWithString:file.fileUrl];
            [imgSubview setUserInteractionEnabled:YES];
            [imgSubview setTag:i];
            [imgSubview.layer setMasksToBounds:YES];
            [imgSubview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAttachedFile:)]];
            [imgSubview sd_setImageWithURL:urlImg placeholderImage:[UIImage imageNamed:@"imgAttachedFilesPlaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            UILabel *lblType = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 34.f, 38.f, 16.f)];
            [lblType setText:[file.fileExtension uppercaseString]];
            [lblType setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.f]];
            [lblType setTextColor:[UIColor colorWithHexString:@"CA2B56"]];
            [lblType setTextAlignment:NSTextAlignmentRight];
            [subview addSubview:lblType];
            [subview addSubview:imgSubview];
            [cell.scrollViewAttachedArchives addSubview:subview];
            
        }
        
        [cell.scrollViewAttachedArchives setContentSize:CGSizeMake([[_serviceOrder.files allObjects] count] * 40.f, cell.scrollViewAttachedArchives.frame.size.height)];
    } else {
        NSArray *files = _serviceOrderConsult.files;
        for (int i = 0; i < [files count]; i++) {
            
            
            float size = 58.f;
            float spacementX = 10.f;
            float spacement = size + spacementX * i;
            
            if (i == 0) {
                spacement = 0.f;
            }
            
            UIView *subview = [[UIView alloc] init];
            
            [subview setFrame:CGRectMake(spacement, 0.f, size, size - 20.f)];
            
            
            AFIMServiceOrderFile *file = files[i];
            
            UIImageView *imgSubview = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 5.f, size, size - 20.f)];
            //        [imgSubview setContentMode:UIViewContentModeScaleAspectFill];
            [imgSubview setContentMode:UIViewContentModeScaleAspectFit];
            
            NSURL *urlImg = [NSURL URLWithString:file.fileUrl];
            [imgSubview setUserInteractionEnabled:YES];
            [imgSubview setTag:i];
            [imgSubview.layer setMasksToBounds:YES];
            [imgSubview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAttachedFile:)]];
            [imgSubview sd_setImageWithURL:urlImg placeholderImage:[UIImage imageNamed:@"imgAttachedFilesPlaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            UILabel *lblType = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 34.f, 38.f, 16.f)];
            [lblType setText:[file.fileExtension uppercaseString]];
            [lblType setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.f]];
            [lblType setTextColor:[UIColor colorWithHexString:@"CA2B56"]];
            [lblType setTextAlignment:NSTextAlignmentRight];
            [subview addSubview:lblType];
            [subview addSubview:imgSubview];
            [cell.scrollViewAttachedArchives addSubview:subview];
            
        }
        
        [cell.scrollViewAttachedArchives setContentSize:CGSizeMake([[_serviceOrder.files allObjects] count] * 40.f, cell.scrollViewAttachedArchives.frame.size.height)];
    }
    [cell.scrollViewAttachedArchives setScrollEnabled:YES];
    [cell.viewCellFiles.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    [self refreshAutoLayout:cell.viewCellFiles];
    return cell;
}

- (AFIMServiceOrderDetailCellTableViewCell *)createCellObservationsTextWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CellObservationText";
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.txtViewCellObservationText setDelegate:self];
    [cell.txtViewCellObservationText setText:@"Escreva um comentário aqui..."];
    [cell.txtViewCellObservationText setTextColor:[UIColor lightGrayColor]];
    [cell.txtViewCellObservationText.layer addAllBorderWithColor:[UIColor darkGrayColor] andWidht:0.0];
    [cell.txtViewCellObservationText.layer setCornerRadius:4.f andMaskToBounds:YES];
    [cell.txtViewCellObservationText setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
    
    [cell.btnCellObservationText addTarget:self action:@selector(updateServiceOrderObs:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCellObservationText.layer setCornerRadius:4.f andMaskToBounds:YES];
    [cell.btnCellObservationText.layer addAllBorderWithColor:[UIColor darkGrayColor] andWidht:.5f];
    [cell.btnCellObservationText setTag:indexPath.section];
    
    return cell;
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_serviceOrder) {
        if (_serviceOrder.statusId == AFIMServiceOrderStatusTypeExpired || _serviceOrder.statusId == AFIMServiceOrderStatusTypeApproved || _serviceOrder.statusId == AFIMServiceOrderStatusTypeConcluded || _serviceOrder.statusId == AFIMServiceOrderStatusTypeInExecution || _serviceOrder.statusId == AFIMServiceOrderStatusTypeNotAuthorized) {
            return 13.;
        } else {
            return 12.;
        }
    } else {
        if ([_serviceOrderConsult.statusId intValue] == AFIMServiceOrderStatusTypeExpired || [_serviceOrderConsult.statusId intValue] == AFIMServiceOrderStatusTypeApproved || [_serviceOrderConsult.statusId intValue] == AFIMServiceOrderStatusTypeConcluded || [_serviceOrderConsult.statusId intValue] == AFIMServiceOrderStatusTypeInExecution || [_serviceOrderConsult.statusId intValue] == AFIMServiceOrderStatusTypeNotAuthorized) {
            return 13.;
        } else {
            return 12.;
        }
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 54.f)];
        //        [view setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(4.f, 6.f, self.view.frame.size.width - (4.f*2.f), 54.f - (6.f * 2.f))];
        [viewBackground setBackgroundColor:[UIColor whiteColor]];
        
        
        UILabel *lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(4.f, 2.f, viewBackground.frame.size.width - (4.f*2.f), 18.f)];
        [lblStatus setText:@"Status"];
        [lblStatus setTextColor:[UIColor darkGrayColor]];
        [lblStatus setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.f]];
        
        UIImageView *imgStatus = [[UIImageView alloc] initWithFrame:CGRectMake(4.f, lblStatus.frame.size.height + 2.f, 20.f, 20.f)];
        if (_serviceOrder) {
            [imgStatus setImage:[UIImage imageNamed:_serviceOrder.imgStatus]];
        } else {
            [imgStatus setImage:[UIImage imageNamed:_serviceOrderConsult.imgNameStatus]];
        }
        
        UILabel *lblStatusName = [[UILabel alloc] initWithFrame:CGRectMake(imgStatus.frame.size.width + 10.f, imgStatus.frame.origin.y, 200.f, 20.f)];
        [lblStatusName setTextColor:[UIColor darkGrayColor]];
        [lblStatusName setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.f]];
        
        if (_serviceOrder) {
            [lblStatusName setText:_serviceOrder.status];
        } else {
            [lblStatusName setText:_serviceOrderConsult.status];
        }
        
        
        
        [viewBackground addSubview:lblStatus];
        [viewBackground addSubview:imgStatus];
        [viewBackground addSubview:lblStatusName];
        [view.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
        [view addSubview:viewBackground];
        
        
        return view;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 54.f;
    }
    return 0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    static NSString *CellIdentifier = @"CellServiceDetail";
    AFIMServiceOrderDetailCellTableViewCell *cell;
    if (indexPath.section == 2) {
        cell = (AFIMServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    //    NSInteger row = indexPath.row;
    CGFloat size = 0;
    switch (section) {
        case 0:
            size = 140.f;
            break;
        case 1:
            size = 140.f;
            break;
        case 2:
            //details
            if (_serviceOrder) {
                [cell.lblCellServiceDetailInfo setText:_serviceOrder.serviceOrderDescription];
            } else {
                [cell.lblCellServiceDetailInfo setText:_serviceOrderConsult.serviceOrderDescription];
            }
            
            [cell.lblCellServiceDetailInfo sizeToFit];
            float sizeToBe = cell.lblCellServiceDetailInfo.frame.size.height - 40;
            size = 88.f + sizeToBe;
            [self refreshAutoLayout:cell.viewCellServiceDetail];
            [self refreshAutoLayout:cell.lblCellServiceDetailInfo];
            break;
        case 3:
            //header
            
            if ([_authorizedUsers count] > 0) {
                size = 44.f;
            } else {
                size = 0.f;
            }
            break;
        case 4:
            //list
            if ([_authorizedUsers count] > 0) {
                size = 30.f;
            } else {
                size = 0.f;
            }
            break;
        case 5:
            //footer
            if ([_authorizedUsers count] > 0) {
                size = 10.f;
            } else {
                size = 0.f;
            }
            break;
        case 6:
            //files
            if ([[_serviceOrder.files allObjects] count] > 0) {
                size = 100.f;
            } else {
                size = 0.f;
            }
            break;
        case 7:
            //obs header
            if ([_observations count] > 0) {
                size = 30.f;
            } else {
                size = 0.f;
            }
        case 8:
            //observations
            if (_serviceOrder) {
                if ([[_serviceOrder.observations allObjects] count] > 0) {
                    size = 70.f;
                } else {
                    size = 0.f;
                }
            } else {
                if ([_serviceOrderConsult.observations count] > 0) {
                    size = 70.f;
                } else {
                    size = 0.f;
                }
            }
            
            break;
        case 9:
            //header
            if ([_approvers count] > 0) {
                size = 44.f;
            } else {
                size = 0.f;
            }
            break;
        case 10:
            //list
            if ([_approvers count] > 0) {
                size = 30.f;
            } else {
                size = 0.f;
            }
            break;
        case 11:
            //footer
            if ([_approvers count] > 0) {
                size = 10.f;
            } else {
                size = 0.f;
            }
            break;
        case 12:
            //comentario
            if (_iCanComment) {
                size = 88.f;
            } else {
                size = 0.f;
            }
        default:
            break;
    }
    return size;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 1;
    switch (section) {
        case 4:
            rows = [_authorizedUsers count];
            break;
        case 8:
            rows = [_observations count];
            break;
        case 10:
            rows = [_approvers count];
            break;
        default:
            rows = 1;
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self createCellNameWithIndexPath:indexPath andTableView:tableView];
    } else if (indexPath.section == 1) {
        return [self createCellServiceWithIndexPath:indexPath andTableView:tableView];
    } else if (indexPath.section == 2) {
        return [self createCellServiceDetailWithIndexPath:indexPath andTableView:tableView isDetails:YES];
    } else if (indexPath.section == 3) {
        return [self createCellHeaderWithIndexPath:indexPath andTableView:tableView];
    } else if (indexPath.section == 4) {
        return [self createCellListWithIndexPath:indexPath andTableView:tableView kindOfListAuthorized:YES];
    } else if (indexPath.section == 5) {
        return [self createCellFooterWithIndexPath:indexPath andTableView:tableView];
    } else if (indexPath.section == 6) {
        return [self createCellFilesWithIndexPath:indexPath andTableView:tableView];
    } else if (indexPath.section == 7) {
        return [self createCellHeaderWithIndexPath:indexPath andTableView:tableView];
    } else if (indexPath.section == 8) {
        return [self createCellObservationsWithIndexPath:indexPath andTableView:tableView];
        
    } else if (indexPath.section == 9) {
        return [self createCellApproverHeaderWithIndexPath:indexPath andTableView:tableView];
        
    } else if (indexPath.section == 10) {
        return [self createCellListWithIndexPath:indexPath andTableView:tableView kindOfListAuthorized:NO];
        
    } else if (indexPath.section == 11) {
        return [self createCellFooterWithIndexPath:indexPath andTableView:tableView];
        
    } else if (indexPath.section == 12) {
        return [self createCellObservationsTextWithIndexPath:indexPath andTableView:tableView];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    Official *official = _officialList[indexPath.row];
    //    [self performSegueWithIdentifier:@"showOfficialEdit" sender:official];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    //    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    //        [cell setSeparatorInset:UIEdgeInsetsZero];
    //    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self.view endEditing:YES];
    
}

#pragma mark - UIButtons & Gesture actions
- (void)showAttachedFile:(UITapGestureRecognizer *)sender {
    [self initPhotoBrownserWith:sender.view.tag];
}
- (void)updateServiceOrderObs:(UIButton *)sender {
    [self.view endEditing:YES];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    
    AFIMServiceOrderDetailCellTableViewCell *cell = (AFIMServiceOrderDetailCellTableViewCell *)[_tblView cellForRowAtIndexPath:indexPath];
    
    NSString *obsComment = cell.txtViewCellObservationText.text;
    
    
    if (obsComment.length > 2 && ![obsComment isEqualToString:@"Escreva um comentário aqui..."]) {
        
        [self showTwoButtonsDefaultAlertView:@"Atenção" andMessage:@"Deseja mesmo adicionar um comentário a essa OS?" buttonTextCancel:@"Cancelar" buttonTextAccept:@"Sim" andCompletionAcceptAction:^(NSString *action) {
            
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            
            [AFIMServiceOrder approveServiceOrder:_serviceOrder user:_user observationText:obsComment approvalStatus:_approvalStatus andCompletion:^(AFIMServiceOrderApproved *serviceOrderApproved) {
                AFIMServiceOrderObservations *serviceOrderObs = [[AFIMServiceOrderObservations alloc] init];
                
                
                [serviceOrderObs setServiceOrderId:@(_serviceOrder.serviceOrderId)];
                [serviceOrderObs setObservation:obsComment];
                [serviceOrderObs setUserId:_user.userId];
                [serviceOrderObs setRegisterDate:serviceOrderApproved.registerDate];
                [serviceOrderObs setRegisterHour:serviceOrderApproved.registerHour];
                [serviceOrderObs setObservationId:serviceOrderApproved.commentId];
                
                
                [serviceOrderObs setUserObservationId:_user.userId];
                [serviceOrderObs setUserObservationName:_user.username];
                [serviceOrderObs setUserObservationEnterprise:_user.company];
                [serviceOrderObs setUserObservationEmail:_user.email];
                [serviceOrderObs setUserObservationPhone:_user.phone];
                [serviceOrderObs setUserObservationDate:[NSDate date]];
                
                [[AFDatabaseManager sharedManager] insertObservationsInto:_serviceOrder withObservation:serviceOrderObs];
                _serviceOrder = [ServiceOrder find:@"serviceOrderId == %i", _serviceOrder.serviceOrderId];
                [self prepareToReload];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                
            } failure:^(NSError *error) {
                [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
                    
                }];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
            
        }];
    } else {
        [self showDefaultAlertView:@"Atenção" andMessage:@"É necessário adicionar um comentário." completionAction:^(NSString *action) {
            
        }];
    }
    
}

- (void)prepareToReload {
    [self customOrganization];
    [_tblView reloadData];
}

- (void)approveOsButtonCell:(UITapGestureRecognizer *)sender {
    _approvalStatus = AFIMServiceOrderApprovalStatusApproved;
    [self customOrganization];
    [_tblView reloadData];
    
}
- (void)repproveOsButtonCell:(UITapGestureRecognizer *)sender {
    _approvalStatus = AFIMServiceOrderApprovalStatusRepproved;
    [self customOrganization];
    [_tblView reloadData];
}

#pragma mark - DELEGATES
#pragma mark - MWPhotoBrownser Delegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

#pragma mark - UITextView Delegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Escreva um comentário aqui...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Escreva um comentário aqui..."]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor]; //optional
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showLink"]) {
        AFIMLinkViewController *lVc = [segue destinationViewController];
        [lVc setFileUrl:sender];
    }
}

@end
