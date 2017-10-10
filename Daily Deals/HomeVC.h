//
//  HomeVC.h
//  Daily Deals
//
//  Created by Mac5 on 07/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseDealVC.h"
@interface HomeVC : UIViewController

- (IBAction)enterManuallyButtonAction:(id)sender;
- (IBAction)scanButtonAction:(id)sender;
@property NSUInteger newUserID;
@end
