//
//  AFIMServiceOrderConsultListViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 03/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderConsultListViewController.h"
#import "AFIMServiceOrder.h"
#import "AFIMServiceOrderDetailViewController.h"

@interface AFIMServiceOrderConsultListViewController ()

@end

@implementation AFIMServiceOrderConsultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setTitle:@"OS"];
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
    [_tblView reloadData];
}
#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_serviceOrdersList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMServiceOrdersCellTableViewCell *cell = (AFIMServiceOrdersCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrdersCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    AFIMServiceOrder *serviceOrder = _serviceOrdersList[indexPath.row];
    [cell.lblServiceOrderNumber setText:[NSString stringWithFormat:@"OS %ld", (long)[serviceOrder.serviceOrderId integerValue]]];
    [cell.lblDate setText:[NSString stringGetDayDate:serviceOrder.initialDate]];
    
    [cell.lblServiceOrderType setText:serviceOrder.serviceType];
    [cell.lblRequester setText:serviceOrder.requesterName];
    [cell.lblEmail setText:serviceOrder.email];
    
    [cell.lblDescription setText:serviceOrder.serviceOrderDescription];
    cell.lblDescription.contentInset = UIEdgeInsetsMake(-7.0,0.0,0,0.0);
    
    [cell.imgStatus setImage:[UIImage imageNamed:serviceOrder.imgNameStatus]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AFIMServiceOrder *serviceOrder = _serviceOrdersList[indexPath.row];
    [self performSegueWithIdentifier:@"showServiceOrdeDetail" sender:serviceOrder];
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

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showServiceOrdeDetail"]) {
        AFIMServiceOrderDetailViewController *dVc = [segue destinationViewController];
//        if ([sender isKindOfClass:[ServiceOrder class]]) {
            [dVc setServiceOrderConsult:sender];
//        } else if ([sender isKindOfClass:[AFIMServiceOrder class]]) {
        
//        }
    }
}


@end
