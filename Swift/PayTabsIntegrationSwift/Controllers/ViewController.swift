
import UIKit
import IQKeyboardManager

class ViewController: UIViewController {
    
    var paytabsPayementGatewayVC: PTFWInitialSetupViewController!
    
    //MARK:- IBOutlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var shippingAddressTextView: IQTextView!
    @IBOutlet weak var shippingCountryField: UITextField!
    @IBOutlet weak var shippingStateField: UITextField!
    @IBOutlet weak var shippingCityField: UITextField!
    
    @IBOutlet weak var billingAddressTextView: IQTextView!
    @IBOutlet weak var billingCountryField: UITextField!
    @IBOutlet weak var billingStateField: UITextField!
    @IBOutlet weak var billingCityField: UITextField!
    
    
    //MARK:- ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- IBActions
    @IBAction func checkoutButtonAction(_ sender: UIButton) {
        
        makePayment()
    }
    
    func makePayment() {
        
        let order_id = random(digits: 5)
        
        if ValidationClass().blankValidationOnCheckoutForm(self) {
            let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
            self.paytabsPayementGatewayVC = PTFWInitialSetupViewController.init(
                bundle                   : bundle,
                andWithViewFrame         : self.view.frame,
                andWithAmount            : Float(amountField.text!)!,
                andWithCustomerTitle     : nameField.text!,
                andWithCurrencyCode      : Config.shared.CURRENCY_CODE,
                andWithTaxAmount         : 0.0,
                andWithSDKLanguage       : Config.shared.LANGUAGE,
                andWithShippingAddress   : shippingAddressTextView.text!,
                andWithShippingCity      : shippingCityField.text!,
                andWithShippingCountry   : Config.shared.COUNTRY_BILLING,
                andWithShippingState     : shippingStateField.text!,
                andWithShippingZIPCode   : Config.shared.POSTAL_CODE,
                andWithBillingAddress    : billingAddressTextView.text!,
                andWithBillingCity       : billingCityField.text!,
                andWithBillingCountry    : Config.shared.COUNTRY_BILLING,
                andWithBillingState      : billingStateField.text!,
                andWithBillingZIPCode    : Config.shared.POSTAL_CODE,
                andWithOrderID           : order_id,
                andWithPhoneNumber       : phoneNumberField.text!,
                andWithCustomerEmail     : emailField.text!,
                andIsTokenization        : true,
                andIsPreAuth             : false,
                andWithMerchantEmail     : Config.shared.MERCHANT_EMAIL,
                andWithMerchantSecretKey : Config.shared.SECRET_KEY,
                andWithAssigneeCode      : Config.shared.ASSIGNEE_CODE ,
                andWithThemeColor        : .red,
                andIsThemeColorLight     : false)
            
            
            self.paytabsPayementGatewayVC.didReceiveBackButtonCallback = {
            }
            
            
            /*
             * This is called when user press checkout  button on checkout screen
             */
            self.paytabsPayementGatewayVC.didStartPreparePaymentPage = {
                
            }
            
            /*
             * This is called when user moved on payment screen
             */
            self.paytabsPayementGatewayVC.didFinishPreparePaymentPage = {
                
            }
            
            
            /*
             * This is called when user complete their trasaction
             * In this we can get payment deatil  or transaction detail done by user
             */
            self.paytabsPayementGatewayVC.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
                
                print("Response Code: \(responseCode)")
                print("Response Result: \(result)")
                
                /* responseCode == 100  (The transaction is successful.)
                 * Checked whether the trasaction is success or not
                 */
                
                if responseCode == 100 { // rThe transaction is successful.
                    
                    var detailData = [CommonModel]()
                    detailData.append(CommonModel(title: "Order ID:-"       , value: order_id))
                    detailData.append(CommonModel(title: "Transaction Id:-" , value: "\(transactionID)"))
                    detailData.append(CommonModel(title: "Token:-"          , value: token))
                    detailData.append(CommonModel(title: "Amount:-"         , value: self.amountField.text! + " " + Config.shared.CURRENCY_CODE))
                    detailData.append(CommonModel(title: "Transaction by:-" , value: self.nameField.text!))
                    detailData.append(CommonModel(title: "Email:-"          , value: tokenizedCustomerEmail))
                    detailData.append(CommonModel(title: "Number:-"         , value: self.phoneNumberField.text!))
                    
                    /* When  Transaction is successfull blank all the field on checkout screen */
                    self.nameField.text             = ""
                    self.emailField.text            = ""
                    self.phoneNumberField.text      = ""
                    self.amountField.text           = ""
                    self.shippingAddressTextView.text = ""
                    self.shippingStateField.text    = ""
                    self.shippingCityField.text     = ""
                    self.shippingCountryField.text  = ""
                    self.billingAddressTextView.text = ""
                    self.billingStateField.text     = ""
                    self.billingCityField.text      = ""
                    self.billingCountryField.text   = ""
                    
                    /*******************************/
                    
                    /* Redirect user on payment detail screnn after sussccesfully payment done */
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailController") as! PaymentDetailController
                    vc.detailData = detailData
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                } else {
                    self.view.makeToast(message: result)
                }
            }
            
            
            /*
             * Add payment gatway screen on current screen
             */
            
            self.view.addSubview(paytabsPayementGatewayVC.view)
            self.addChild(paytabsPayementGatewayVC)
            paytabsPayementGatewayVC.didMove(toParent: self)
        }
    }
}
