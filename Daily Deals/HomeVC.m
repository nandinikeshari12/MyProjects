//
//  HomeVC.m
//  Daily Deals
//
//  Created by Mac5 on 07/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import "HomeVC.h"
#import "BarcodeScannerVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.enterManuallyBtn.layer.cornerRadius = self.enterManuallyBtn.frame.size.height/2;
     self.scanBtn.layer.cornerRadius = self.scanBtn.frame.size.height/2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return  true;
}

- (IBAction)enterManuallyButtonAction:(id)sender
{
    PurchaseDealVC *purchaseDealVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseDealVC"];
    purchaseDealVC.tempUserID = self.newUserID;
    [self.navigationController pushViewController:purchaseDealVC animated:true];
}

- (IBAction)scanButtonAction:(id)sender
{
    
    BarcodeScannerVC *purchaseDealVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BarcodeScannerVC"];
   // purchaseDealVC.tempUserID = self.newUserID;
    [self.navigationController pushViewController:purchaseDealVC animated:true];
    
}
@end
