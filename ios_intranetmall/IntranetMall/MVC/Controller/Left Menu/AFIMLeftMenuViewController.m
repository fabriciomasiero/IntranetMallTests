//
//  AFIMLeftMenuViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMLeftMenuViewController.h"
#import "AFIMUser.h"
#import "AFMenuItem.h"

@interface AFIMLeftMenuViewController ()

@end

@implementation AFIMLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getUserWithCompletion:^(AFIMUser *user) {
        _infos = @[@{@"section" : user,
                     @"itens" : @[[AFMenuItem itemWithTitle:@"Home" icon:[UIImage imageNamed:@"imgHomeMenu"] tag:0],
                                  [AFMenuItem itemWithTitle:@"Circular" icon:[UIImage imageNamed:@"imgCircularMenu"] tag:1],
                                  [AFMenuItem itemWithTitle:@"Funcionário" icon:[UIImage imageNamed:@"imgUserMenu"] tag:2],
                                  [AFMenuItem itemWithTitle:@"Ordem de Serviço" icon:[UIImage imageNamed:@"imgServiceOrderMenu"] tag:3]]
                     }, @{@"section" : @"Aplicativo",
                          @"itens" : @[[AFMenuItem itemWithTitle:@"Sobre" icon:[UIImage imageNamed:@"imgSOMenu"] tag:4],
                                       [AFMenuItem itemWithTitle:@"Logout" icon:[UIImage imageNamed:@"imgLogoutMenu"] tag:5]]}];
        [_tblView reloadData];
        
        [_imgShopping setImage:[UIImage imageWithData:[NSData getDataFromBase64:user.shopData64]]];
    }];
    
    
//    _infos = @[@{@""}@"Home", @"Circular", @"Funcionário", @"Ordem de Serviço", ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    
    
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_infos count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = _infos[section];
    NSArray *itens = dic[@"itens"];
    return [itens count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = _infos[section];
    if ([dic[@"section"] isKindOfClass:[AFIMUser class]]) {
        AFIMUser *u = (AFIMUser *)dic[@"section"];
        return u.shoppingName;
    } else {
        return dic[@"section"];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = _infos[section];
    if (section == 0) {
        
        AFIMUser *u = (AFIMUser *)dic[@"section"];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 50.f)];
        [view setBackgroundColor:[UIColor colorWithHexString:@"686868"]];
        
        UILabel *lblUser = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 8.f, self.view.frame.size.width - 20.f, 18.f)];
        [lblUser setText:u.username];
        [lblUser setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.f]];
        [lblUser setTextColor:[UIColor colorWithHexString:@"1FBBD4"]];
        
        
        UILabel *lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(10.f, lblUser.frame.size.height + lblUser.frame.origin.y + 4.f, self.view.frame.size.width - 20.f, 16.f)];
        [lblEmail setText:u.email];
        [lblEmail setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.f]];
        [lblEmail setTextColor:[UIColor whiteColor]];
        
        [view addSubview:lblUser];
        [view addSubview:lblEmail];
        
        
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 30.f)];
        [view setBackgroundColor:[UIColor colorWithHexString:@"686868"]];
        
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, self.view.frame.size.width - 20.f, 30.f)];
        [lblText setText:dic[@"section"]];
        [lblText setTextColor:[UIColor colorWithHexString:@"1FBBD4"]];
        
        [view addSubview:lblText];
        
        return view;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50.f;
    } else {
        return 30.f;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMLeftMenuCellTableViewCell *cell = (AFIMLeftMenuCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMLeftMenuCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dic = _infos[indexPath.section];
    NSArray *itens = dic[@"itens"];
    AFMenuItem *item = itens[indexPath.row];
    
    
    [cell.imgView setContentMode:UIViewContentModeScaleAspectFit];
    [cell.imgView setImage:item.icon];
    [cell.lblTitle setText:item.title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = _infos[indexPath.section];
    NSArray *itens = dic[@"itens"];
    AFMenuItem *item = itens[indexPath.row];
    
    
    switch (item.tag) {
        case 0:
            [self pushDynamicSegue:@"homeView"];
            break;
        case 1:
            [self pushDynamicSegue:@"circularListView"];
            break;
        case 2:
            [self pushDynamicSegue:@"officialListView"];
            break;
        case 3:
            [self pushDynamicSegue:@"serviceOrderView"];
            break;
        case 4:
            [self showVersionMessage];
            break;
        case 5:
            [self logout];
            break;
        default:
            break;
    }
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
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 82.f;
//}

- (void)pushDynamicSegue:(NSString *)segue {
    NSString *pageSaved = [[NSUserDefaults standardUserDefaults] objectForKey:@"leftPage"];
    if ([segue isEqualToString:pageSaved]) {
        [self.sidePanelController showCenterPanelAnimated:YES];
    } else {
        [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:segue]];
    }
}
- (void)showVersionMessage {
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] year]];
    NSString *appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *message = [NSString stringWithFormat:@"Aplicativo Intranet Mall %@ \n Versão %@ \n\n\n http://intranetmall.com.br \n", year, appVersionString];
    
    [self showDefaultAlertView:@"Intranet Mall" andMessage:message completionAction:^(NSString *action) {
        
    }];
}

- (void)logout {
    [self loggoutUser:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
