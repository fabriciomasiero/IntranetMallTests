//
//  AFIMOfficialListViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMOfficialListViewController.h"
#import "AFIMOfficialDetailViewController.h"

@interface AFIMOfficialListViewController ()

@end

@implementation AFIMOfficialListViewController


#pragma mark - Initial Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicMenuInitialization:@"officialListView"];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self callOfficials];
    [_viewButtonAddUser.layer setCornerCircle];
    [self setTitle:@"Funcionários"];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    _btnBarCloseSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgClose"] style:UIBarButtonItemStylePlain target:self action:@selector(closeSearchBar:)];
    
    [self.navigationItem setRightBarButtonItems:@[_btnBarSearch, _btnBarAction]];
    
    [self addRefreshControl];
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
    if ([_officialList count] > 0) {
        _officialList = [Official all];
        [self reloadData];
    }
}

#pragma mark - Add Refresh Control
- (void)addRefreshControl {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl setBackgroundColor:[UIColor colorWithHexString:@"E3E3E3"]];
    [_refreshControl setTintColor:[UIColor darkGrayColor]];
    [_refreshControl addTarget:self action:@selector(callOfficials) forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
}
- (void)reloadData {
    [_tblView reloadData];
    if (self.refreshControl) {
        
        NSString *title = [NSString stringWithFormat:@"Última atualização: %@", [NSString stringGetDateToShowMonth:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    
    [_refreshControl endRefreshing];
}


#pragma mark - Search In Context
- (void)searchInContext:(NSString *)context {
    NSArray *newResults;
    _officialList = nil;
    
    
    newResults = [[AFDatabaseManager sharedManager] searchOnOfficial:context];
    _officialList = [NSArray arrayWithArray:newResults];
    [_tblView reloadData];
}
#pragma mark - Hide & Show Search
- (void)hidesCloseSearchBarButton {
    [UIView animateWithDuration:.1f animations:^{
        if ([self.navigationItem.rightBarButtonItems count] != 1) {
            [self.navigationItem setRightBarButtonItem:nil];
            [self.navigationItem setRightBarButtonItems:@[_btnBarSearch, _btnBarAction]];
        }
    }];
}
- (void)showsCloseSearchBarButton {
    [UIView animateWithDuration:.1f animations:^{
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItem:_btnBarCloseSearch];
    }];
}
#pragma mark - Create Actions Sheet
- (void)createActions {
    NSArray *actions = @[@"Todos",
                         @"Aguardando aprovação do Depto. de S",
                         @"Aprovado. Aguardando emissão do Cra",
                         @"Cadastro reprovado pelo Depto. de Seg",
                         @"Crachá em emissão",
                         @"Crachá na ADM. Aguardando retirada",
                         @"Foto fora do padrão. Reenviar",
                         @"Funcionário Ativo",
                         @"Funcionário Inativo",
                         @"Novo Cadastro"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Ações"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    for (NSString *title in actions)  {
        [actionSheet addButtonWithTitle:title];
    }
    
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancelar"];
    
    [actionSheet showInView:self.view];
}

#pragma mark - API Callout
- (void)callOfficials {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (!_user) {
        [self getUserWithCompletion:^(AFIMUser *user) {
            self.user = user;
        }];
    }
    
    [AFIMOfficials getOfficialsWithUserId:_user.userId shoppingId:_user.shoppingId andCompletion:^(NSArray *officialList) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _officials = officialList;
        _officialList = officialList;
        [self reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (void)filterOfficials:(AFIMOfficialStatusType)type {
    
    if (type != AFIMOfficialStatusTypeAll) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"registerStatus == %@", @(type)];
        
        NSArray *newOfficials = [_officials filteredArrayUsingPredicate:predicate];
    
        if ([newOfficials count] == 0) {
            [self showDefaultAlertView:@"Atenção" andMessage:@"Não foram encontrados nenhum funcionário com este estado" completionAction:^(NSString *action) {
            
            }];
        }
    
    
        _officialList = newOfficials;
        [_tblView reloadData];
    } else {
        _officialList = _officials;
        [_tblView reloadData];
    }
}
#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_officialList count] > 0) {
        if ([_tblView.backgroundView isKindOfClass:[UILabel class]]) {
            [_tblView setBackgroundView:nil];
        }
        return 1;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
//        messageLabel.text = @"Nenhum funcionário encontrado.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        [messageLabel sizeToFit];
        
        _tblView.backgroundView = messageLabel;
//        _tblView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_officialList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMOfficialsCellTableViewCell *cell = (AFIMOfficialsCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMOfficialsCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Official *official = _officialList[indexPath.row];
    [cell.lblOfficialName setText:official.shopkeeperName];
    [cell.lblOfficialBirthDate setText:[NSString stringGetDayDateToShow:official.birthDate]];
    [cell.lblOfficialDocument setText:[official.documentIdentifier formatToDocumentIdentifier]];
    [cell.lblOfficialRegisterDate setText:[NSString stringGetDayDateToShow:official.registerDate]];
    [cell.lblStatus setText:official.registerStatusValue];
    [cell.imgOfficial setContentMode:UIViewContentModeScaleAspectFill];
    if (official.imgBase64.length > 3) {
        [cell.imgOfficial setImage:[UIImage imageWithData:[NSData getDataFromBase64:official.imgBase64]]];
    } else {
        [cell.imgOfficial setImage:[UIImage imageNamed:@"imgPlaceholderIntranetMall"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Official *official = _officialList[indexPath.row];
    [self performSegueWithIdentifier:@"showOfficialEdit" sender:official];
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
    [_searchBar resignFirstResponder];
    
}

#pragma mark - Search Bar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length == 0 && [searchText isEqualToString:@""]) {
        [self showsCloseSearchBarButton];
        [self searchInContext:searchText];
        return;
    }
    if (searchText.length > 2) {
        [self searchInContext:searchText];
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ((searchBar.text.length == 1 && [text isEqualToString:@""]) || (searchBar.text.length == 0 && [text isEqualToString:@""])) {
        [self showsCloseSearchBarButton];
    } else {
        [self hidesCloseSearchBarButton];
    }
    return YES;
}


#pragma mark - UIButtons Actions
- (IBAction)searchOnOfficials:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:.1f animations:^{
        if (!_searchBar) {
            _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.f, 0.f, 300.f, 44.f)];
        }
        [_searchBar setTintColor:[UIColor colorWithHexString:@"1FBBD4"]];
        [_searchBar setDelegate:self];
        self.navigationItem.titleView = nil;
        self.navigationItem.titleView = _searchBar;
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItem:_btnBarCloseSearch];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5f animations:^{
            [_searchBar becomeFirstResponder];
        }];
        
    }];
}
- (void)closeSearchBar:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:.2f animations:^{
        [self setTitle:@""];
        [_searchBar removeFromSuperview];
        [_searchBar setText:@""];
        self.navigationItem.titleView = nil;
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItems:@[_btnBarSearch, _btnBarAction]];
    } completion:^(BOOL finished) {
        [self setTitle:@"Funcionários"];
    }];
    
}
- (IBAction)actionList:(UIBarButtonItem *)sender {
    [self createActions];
}

- (IBAction)addUser:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showOfficialEdit" sender:nil];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger type = 0;
    
    switch (buttonIndex) {
        case 0://todos
            type = AFIMOfficialStatusTypeAll;
            break;
        case 1://aguardando aprov
            type = AFIMOfficialStatusTypeWaitingApproval;
            break;
        case 2://aprovado
            type = AFIMOfficialStatusTypeApproved;
            break;
        case 3://cadastro reprovado
            type = AFIMOfficialStatusTypeRepproved;
            break;
        case 4://cracha em emissao
            type = AFIMOfficialStatusTypeBadgeInEmission;
            break;
        case 5://cracha na adm
            type = AFIMOfficialStatusTypeBadgeInAdm;
            break;
        case 6://foto fora do padrao
            type = AFIMOfficialStatusTypeNonStandardPicture;
            break;
        case 7://funcionario ativo
            type = AFIMOfficialStatusTypeActiveOfficial;
            break;
        case 8://funcionario inativo
            type = AFIMOfficialStatusTypeInactiveOfficial;
            break;
        case 9://novo cadastro
            type = AFIMOfficialStatusTypeNewOfficial;
            break;
            
        default:
            break;
    }
    [self filterOfficials:type];
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showOfficialEdit"]) {
        AFIMOfficialDetailViewController *dVc = [segue destinationViewController];
        if ([sender isKindOfClass:[Official class]]) {
            [dVc setOfficial:sender];
        }
    }
}


@end
