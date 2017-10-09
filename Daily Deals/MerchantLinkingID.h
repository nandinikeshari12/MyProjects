//
//  MerchantLinkingID.h
//  Daily Deals
//
//  Created by Mac5 on 07/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantLinkingID : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *merchantIDTxtFld;

- (IBAction)activateButtonAction:(id)sender;
@end
