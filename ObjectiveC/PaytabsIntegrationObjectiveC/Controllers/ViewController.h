//
//  ViewController.h
//  PaytabsIntegrationObjectiveC
//
//  Created by gipl on 11/06/20.
//  Copyright © 2020 gipl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ViewController : UIViewController


/*******Outlets for checkout screen**************/

@property (weak, nonatomic) IBOutlet UITextField *nameTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *amountTxtFld;

/********** Shipping Address Outlet*******/
@property (weak, nonatomic) IBOutlet UITextField *shippingStateTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *shippingCityTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *shippingCountryTxtFld;
@property (weak, nonatomic) IBOutlet IQTextView  *shippingAddressTxtView;

/**************Billing address Outlet*************/
@property (weak, nonatomic) IBOutlet IQTextView  *billingAddressTxtView;
@property (weak, nonatomic) IBOutlet UITextField *billingStateTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *billingCityTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *billingcountryTxtFld;


/******** CheckOut Button Outlet*******/
@property (weak, nonatomic) IBOutlet UIButton *checkoutButtonAction;


@end

