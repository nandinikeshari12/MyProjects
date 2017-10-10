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
   // branchArray = [[NSMutableArray alloc] init];
    NSDictionary *params = @{@"userId":[NSNumber numberWithInteger:self.tempUserID]};
    [self loadDataForBranchListing:params];
     [self doneButtonInNumberPad];
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
    else if(textField == self.transactionTxtFld)
    {
        [self.scrollView setContentOffset:CGPointMake(0,self.hkTxtFld.frame.origin.y-150)];

    }
    else
    {
        flag = 1;
       
        pickerViewTemp = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
        //[pickerViewTemp setDataSource: self];
        [pickerViewTemp setDelegate: self];
        pickerViewTemp.showsSelectionIndicator = YES;
        textField.inputView = pickerViewTemp;
        [self.scrollView setContentOffset:CGPointMake(0,self.hkTxtFld.frame.origin.y-150)];
    }
    
}

-(void)loadData
{
    
    NSDictionary *params = @{@"userId":[NSNumber numberWithInteger:self.tempUserID],
                             @"cardNo":self.cashbackTxtFld.text,
                             @"amount":self.hkTxtFld.text,
                             @"invoiceId":self.transactionTxtFld.text,
                             @"branch":self.branchTxtFld.text
                             };
    [self loadDataForListing:params];
    
}
-(void)loadDataForListing:(NSDictionary *)params
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/merchant-add-order-api",BASEURL];
    
    NSMutableURLRequest *request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            
        }
        else
        {
            responseData = [responseObject valueForKey:@"responseData"];
           
            [SVProgressHUD dismiss];
            
        }
    }];
    [dataTask resume];
}

-(void)loadDataForBranchListing:(NSDictionary *)params
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/get-branch",BASEURL];
    
    NSMutableURLRequest *request =  [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            
        }
        else
        {
            
            branchArray = [responseObject valueForKey:@"responseData"];
            [SVProgressHUD dismiss];
            
        }
    }];
    [dataTask resume];
}



#pragma - mark Validation Method

-(BOOL)validation
{
    
    BOOL isVerified=YES;
    
    if(self.cashbackTxtFld.text.length==0 || [[self.cashbackTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        [self displayAlertView:0];
        isVerified=NO;
    }
   else if(self.hkTxtFld.text.length==0 || [[self.hkTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        [self displayAlertView:1];
        isVerified=NO;
    }
   else if(self.transactionTxtFld.text.length==0 || [[self.transactionTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        [self displayAlertView:2];
        isVerified=NO;
    }
   else if(self.branchTxtFld.text.length==0 || [[self.branchTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        [self displayAlertView:3];
        isVerified=NO;
    }
    
    return isVerified;
}


#pragma - mark Alert View Method

-(void)displayAlertView:(NSInteger)index
{
    NSString *msg=@"";
    NSString *actionTitle=@"Cancel";
    switch (index)
    {
        case 0:
            msg=@"Please enter a Card No.";
            break;
        case 1:
            msg=@"Please enter  Purchase Amount.";
            break;
        case 2:
            msg=@"Please enter a Transaction ID.";
            break;
        case 3:
            msg=@"Please select a Branch.";
            break;
        
        default:
            break;
    }
    [self showAlertWithMessage:msg withAction:actionTitle];
}


-(void)showAlertWithMessage:(NSString *)msg withAction:(NSString *)actionTitle
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action)
                             {
                                 
                             }];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)submitButtonAction:(id)sender
{
    if ([self validation]) {
        [self loadData];
    }
}

#pragma - mark PickerView Delegate Methods

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return branchArray.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
        self.branchTxtFld.text = [[branchArray objectAtIndex:row] valueForKey:@"branchName"];

}

- (NSString *)pickerView:(UIPickerView *)pickerView  titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[branchArray objectAtIndex:row] valueForKey:@"branchName"];
    
}

#pragma - mark Return Button in Number Pad
-(void)doneButtonInNumberPad
{
    
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexible,doneButton, nil]];
    
    self.branchTxtFld.inputAccessoryView = keyboardDoneButtonView;
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.scrollView setContentOffset:CGPointMake(0,0)];
    [self.view endEditing:YES];
}


@end
