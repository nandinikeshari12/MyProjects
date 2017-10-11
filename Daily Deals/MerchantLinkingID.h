//
//  MerchantLinkingID.h
//  Daily Deals
//
//  Created by Mac5 on 07/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "Constant.h"
#import "HomeVC.h"


@interface MerchantLinkingID : UIViewController<UITextFieldDelegate>
{
    NSMutableDictionary *responseData;
    NSUInteger userID;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *merchantIDTxtFld;
@property (strong, nonatomic) IBOutlet UIButton *merchantIDBtn;
@property (strong, nonatomic) IBOutlet UIView *merchantIDView;

- (IBAction)activateButtonAction:(id)sender;
@end
