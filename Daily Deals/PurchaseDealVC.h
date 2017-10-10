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
    NSUInteger flag;
   
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *cashbackTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *hkTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *transactionTxtFld;
@property NSUInteger tempUserID;
@property (strong, nonatomic) IBOutlet UITextField *branchTxtFld;
- (IBAction)submitButtonAction:(id)sender;
@end
