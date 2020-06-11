//
//  PaymentDetailController.m
//  PaytabsIntegrationObjectiveC
//
//  Created by gipl on 11/06/20.
//  Copyright © 2020 gipl. All rights reserved.
//

#import "PaymentDetailController.h"
#import "DetailModel.h"

@interface PaymentDetailController ()

@end

@implementation PaymentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"Payment Detail";
}

//MARK:- TableView delegate and datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.detailArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: @"cell"];;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.numberOfLines = 0;
    
    DetailModel *dict = [self.detailArray objectAtIndex:indexPath.row]; //*******Retrive data from detail model
    
    cell.textLabel.text = dict.title;
    cell.detailTextLabel.text = dict.value;
    return cell;
}

@end
