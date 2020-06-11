//
//  PaymentDetailController.h
//  PaytabsIntegrationObjectiveC
//
//  Created by gipl on 11/06/20.
//  Copyright © 2020 gipl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSString *orderId;
@property (nonatomic, retain) NSString *transactionID;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *customerName;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *phoneNumber;

@property (nonatomic, retain) NSMutableArray *detailArray;

@end

NS_ASSUME_NONNULL_END
