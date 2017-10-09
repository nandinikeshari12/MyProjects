//
//  PurchaseDealVC.m
//  Daily Deals
//
//  Created by Mac5 on 09/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import "PurchaseDealVC.h"

@interface PurchaseDealVC ()

@end

@implementation PurchaseDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return  true;
}

#pragma - mark TextView Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.scrollView setContentOffset:CGPointMake(0,0)];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.cashbackTxtFld) {
         [self.scrollView setContentOffset:CGPointMake(0,self.cashbackTxtFld.frame.origin.y-150)];
    }
    else if(textField == self.hkTxtFld)
    {
        [self.scrollView setContentOffset:CGPointMake(0,self.hkTxtFld.frame.origin.y-150)];
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(0,self.hkTxtFld.frame.origin.y-150)];

    }
}

@end
