//
//  PurchaseDealVC.h
//  Daily Deals
//
//  Created by Mac5 on 09/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "Constant.h"

@interface PurchaseDealVC : UIViewController<UITextFieldDelegate,UIPickerViewDelegate>
{
    NSMutableDictionary *responseData;
     UIPickerView *pickerViewTemp;
    NSMutableArray *branchArray;
    NSUInteger branchID;
   
}
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *cashbackTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *hkTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *transactionTxtFld;
@property (strong, nonatomic) NSString *barcodeID;
@property(assign) BOOL isComingFromScanVC;
@property NSUInteger tempUserID;
@property (strong, nonatomic) IBOutlet UITextField *branchTxtFld;
- (IBAction)submitButtonAction:(id)sender;
- (IBAction)backButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *cashbackView;
@property (strong, nonatomic) IBOutlet UIView *purchaseAmountView;
@property (strong, nonatomic) IBOutlet UIView *transactionView;
@property (strong, nonatomic) IBOutlet UIView *branchView;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@end
