//
//  MerchantLinkingID.m
//  Daily Deals
//
//  Created by Mac5 on 07/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import "MerchantLinkingID.h"

@interface MerchantLinkingID ()

@end

@implementation MerchantLinkingID

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 600)];
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

- (IBAction)activateButtonAction:(id)sender
{
    
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
  [self.scrollView setContentOffset:CGPointMake(0,self.merchantIDTxtFld.frame.origin.y+150)];
}

@end
