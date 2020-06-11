//
//  ViewController.m
//  PaytabsIntegrationObjectiveC
//
//  Created by gipl on 11/06/20.
//  Copyright © 2020 gipl. All rights reserved.
//

#import "ViewController.h"
#import <paytabs-iOS/paytabs_iOS.h>
#import "PaymentDetailController.h"
#import "Config.h"
#import "DetailModel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Checkout";

}

//MARK:- This function is used to send the payment related detail to payment gatway page
- (IBAction)checkOutButtonAction:(UIButton *)sender {
    
    NSString *message = @"";
       
       /*Validation for non empty fields
       */
       if ([self.nameTxtFld.text  isEqual: @""]) {
           message = @"Please enter name";
       } else if ([self.emailTxtFld.text  isEqual: @""]) {
           message = @"Please enter email";
       } else if ([self.phoneNumberTxtFld.text  isEqual: @""]) {
           message = @"Please enter phone number";
       } else if ([self.amountTxtFld.text  isEqual: @""]) {
           message = @"Please enter amount";
       } else if ([self.shippingAddressTxtView.text  isEqual: @""]) {
           message = @"Please enter shipping address";
       } else if ([self.shippingStateTxtFld.text  isEqual: @""]) {
           message = @"Please enter shipping state";
       } else if ([self.shippingCityTxtFld.text  isEqual: @""]) {
           message = @"Please enter shipping city";
       } else if ([self.billingAddressTxtView.text  isEqual: @""]) {
           message = @"Please enter billing address";
       } else if ([self.billingStateTxtFld.text  isEqual: @""]) {
           message = @"Please enter billing state";
       } else if ([self.billingCityTxtFld.text  isEqual: @""]) {
           message = @"Please enter billing city";
       }
       
       /*
        Showing the error message based on validation error
        */
       if (![message isEqual: @""]) {
           UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                      message: message
                                      preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action) {}];

           [alert addAction:dismissAction];
           [self presentViewController:alert animated:YES completion:nil];
           return;
       }
    
    
    //**Convert amount string in floating value
    NSString *inputString = self.amountTxtFld.text;
    float amount = [inputString floatValue];
    
    //*****Genrate random string for order_id
    NSString *orderId = [[NSString alloc] initWithFormat:@"%d", arc4random_uniform(900000) + 100000];
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"bundle"]];
    
    
    PTFWInitialSetupViewController *PaytabsPaymentController = [[PTFWInitialSetupViewController alloc]
                                                                initWithBundle:bundle
                                                                andWithViewFrame:self.view.frame
                                                                andWithAmount:amount
                                                                andWithCustomerTitle: self.nameTxtFld.text
                                                                andWithCurrencyCode:CurrencyCode
                                                                andWithTaxAmount:0.0
                                                                andWithSDKLanguage:SDKLanguage
                                                                andWithShippingAddress:self.shippingAddressTxtView.text
                                                                andWithShippingCity:self.shippingCityTxtFld.text
                                                                andWithShippingCountry: ShippingCountryISOCode
                                                                andWithShippingState: self.shippingStateTxtFld.text
                                                                andWithShippingZIPCode: ShippingZIPCode
                                                                andWithBillingAddress:self.billingAddressTxtView.text
                                                                andWithBillingCity:self.billingCityTxtFld.text
                                                                andWithBillingCountry:BillingCountryISOCode
                                                                andWithBillingState:self.billingStateTxtFld.text
                                                                andWithBillingZIPCode:BillingZIPCode
                                                                andWithOrderID:orderId
                                                                andWithPhoneNumber:self.phoneNumberTxtFld.text
                                                                andWithCustomerEmail: self.emailTxtFld.text
                                                                andIsTokenization:YES
                                                                andIsPreAuth:NO
                                                                andWithMerchantEmail:MerchantEmailID
                                                                andWithMerchantSecretKey:SecretKey
                                                                andWithAssigneeCode:AssigneeCode
                                                                andWithThemeColor:[UIColor redColor]
                                                                andIsThemeColorLight:YES
                                                                ];
    
    
    
    /*
     *  When user click on back button on payment gatway page then This is called
     */
    PaytabsPaymentController.didReceiveBackButtonCallback = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    
    /*
     * This is called when user press checkout button on checkout screen
     */
    PaytabsPaymentController.didStartPreparePaymentPage = ^{
        // Start Prepare Payment Page
        // Show loading indicator
    };
    
    /*
     * This is called when user moved on payment screen
     */
    PaytabsPaymentController.didFinishPreparePaymentPage = ^{
        // Finish Prepare Payment Page
        // Stop loading indicator
    };
    
    
    /*
     *method caaled when transaction is successfull
     */
    PaytabsPaymentController.didReceiveFinishTransactionCallback = ^(int responseCode, NSString * _Nonnull result, int transactionID, NSString * _Nonnull tokenizedCustomerEmail, NSString * _Nonnull tokenizedCustomerPassword, NSString * _Nonnull token, BOOL transactionState) {
        [self dismissViewControllerAnimated:true completion:^{
            
            NSLog(@"Response Code: %i", responseCode);
            NSLog(@"Response Result: %@", result);
            
            // In Case you are using tokenization
            NSLog(@"Tokenization Cutomer Email: %@", tokenizedCustomerEmail);
            NSLog(@"Tokenization Customer Password: %@", tokenizedCustomerPassword);
            NSLog(@"TOkenization Token: %@", token);
            
            if (responseCode == 100) { //Check response code for trasaction successfully done or not ( responseCode == 100 , Transaction successfully done)
                
                //Convert in to NSString
                NSString *tID = [[NSString alloc] initWithFormat:@"%d", transactionID];
                
                NSMutableArray *detailArray = [[NSMutableArray alloc] init];
                
                NSString *myString = [NSString stringWithFormat:@"%@ %@", self.amountTxtFld.text, CurrencyCode];
                
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Order ID:-"        andValue: orderId]];
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Transaction Id:-"  andValue: tID]];
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Token:-"           andValue: token]];
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Amount:-"          andValue: myString]];
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Transaction by:-"  andValue: self.nameTxtFld.text]];
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Email:-"           andValue: self.emailTxtFld.text]];
                [detailArray addObject:[[DetailModel alloc] initWithTitle:@"Number:-"          andValue: self.phoneNumberTxtFld.text]];
                
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                PaymentDetailController *vc = [sb instantiateViewControllerWithIdentifier: @"PaymentDetailController"];
                vc.detailArray = detailArray;
                [self presentViewController:vc animated:YES completion:nil];
                
                
                /*
                 * If there is any error occur during transaction process then error message will display in alert
                 */
            } else {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                               message: result
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                [alert addAction:dismissAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    };
    
    [self presentViewController:PaytabsPaymentController animated:true completion:nil]; //**Show payment gatway screen
}


@end
