//
//  PurchaseDealVC.m
//  Daily Deals
//
//  Created by Mac5 on 09/10/17.
//  Copyright © 2017 Mac5. All rights reserved.
//

#import "PurchaseDealVC.h"
#import "HomeVC.h"

@interface PurchaseDealVC ()
{
    UIToolbar *datePickerToolbar;
}

@end

@implementation PurchaseDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
   // branchArray = [[NSMutableArray alloc] init];
    NSDictionary *params = @{@"userId":[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]};
    
    [self setBorderAndCornerRadius:self.cashbackView];
    [self setBorderAndCornerRadius:self.transactionView];
    [self setBorderAndCornerRadius:self.branchView];
    [self setBorderAndCornerRadius:self.purchaseAmountView];
    
    [self loadDataForBranchListing:params];
     [self doneButtonInNumberPad];
    
    if(self.isComingFromScanVC)
    {
        _cashbackTxtFld.text=self.barcodeID;
    }
    
    self.submitBtn.layer.cornerRadius = self.submitBtn.frame.size.height/2;
}

-(void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return  true;
}

-(void)setBorderAndCornerRadius:(UIView *)tempView
{
    tempView.layer.borderWidth = 1.0f;
    tempView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tempView.layer.cornerRadius = tempView.frame.size.height/2;
}

#pragma  - mark Button Action

- (IBAction)submitButtonAction:(id)sender
{
    [self.view layoutIfNeeded];
    if ([self validation])
    {
        [self loadData];
    }
}

- (IBAction)backButtonAction:(id)sender
{
    if(self.isComingFromScanVC)
    {
        NSArray *array = [self.navigationController viewControllers];
        
        for(UIViewController *tempVC in array)
        {
            if([tempVC isKindOfClass:[HomeVC class]])
            {
                [self.navigationController popToViewController:tempVC animated:YES];
                break;
            }
        }
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma - mark TextView Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.scrollView setContentOffset:CGPointMake(0,0)];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height+200)];
    if (textField == self.cashbackTxtFld)
    {
        // [self.scrollView setContentOffset:CGPointMake(0,self.cashbackTxtFld.frame.origin.y-100)];
    }
    else if(textField == self.hkTxtFld)
    {
        [self.scrollView setContentOffset:CGPointMake(0,80)];
    }
    else if(textField == self.transactionTxtFld)
    {
        [self.scrollView setContentOffset:CGPointMake(0,130)];

    }
    else
    {
        pickerViewTemp = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 200)];
        [pickerViewTemp setDelegate: self];
        pickerViewTemp.showsSelectionIndicator = YES;
        pickerViewTemp.backgroundColor = [UIColor whiteColor];
        textField.inputView = pickerViewTemp;
        [self.scrollView setContentOffset:CGPointMake(0,150)];
    }
    
}

-(void)loadData
{
    
    NSDictionary *params = @{@"userId":[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"],
                             @"cardNo":self.cashbackTxtFld.text,
                             @"amount":self.hkTxtFld.text,
                             @"invoiceId":self.transactionTxtFld.text,
                             @"branch":[NSString stringWithFormat:@"%lu",(unsigned long)branchID]
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
            if ([[responseObject valueForKey:@"responseCode"] integerValue]==0) {
                NSString *actionTitle=@"OK";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[responseObject valueForKey:@"responseText"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action)
                                     {
                                        
                                     }];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                NSString *actionTitle=@"OK";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[responseObject valueForKey:@"responseText"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action)
                                     {
                                         if(self.isComingFromScanVC)
                                         {
                                             NSArray *array = [self.navigationController viewControllers];
                                             
                                             for(UIViewController *tempVC in array)
                                             {
                                                 if([tempVC isKindOfClass:[HomeVC class]])
                                                 {
                                                     [self.navigationController popToViewController:tempVC animated:YES];
                                                     break;
                                                 }
                                             }
                                             
                                         }
                                         else
                                         {
                                             [self.navigationController popViewControllerAnimated:YES];
                                         }
                                     }];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
           
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
    
    NSMutableURLRequest *request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            
        }
        else
        {
           
            branchArray =[NSMutableArray arrayWithArray: [responseObject valueForKey:@"responseData"]];
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"BranchID"])
            {
                for(NSDictionary *tempDic in branchArray)
                {
                    if([[NSString stringWithFormat:@"%@",[tempDic valueForKey:@"branchId"]]isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"BranchID"]])
                    {
                        _branchTxtFld.text=[tempDic valueForKey:@"branchName"];
                        break;
                    }
                }
            }
            
            
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
        branchID = [[[branchArray objectAtIndex:row] valueForKey:@"branchId"] integerValue];
      [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)branchID] forKey:@"BranchID"];
      [[NSUserDefaults standardUserDefaults] synchronize];
        self.branchTxtFld.text = [[branchArray objectAtIndex:row] valueForKey:@"branchName"];

}

- (NSString *)pickerView:(UIPickerView *)pickerView  titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[branchArray objectAtIndex:row] valueForKey:@"branchName"];
    
}

#pragma - mark Return Button in Number Pad
-(void)doneButtonInNumberPad
{
    
    
    [self createCancelToolBar];
    
    self.branchTxtFld.inputAccessoryView = datePickerToolbar;
    self.hkTxtFld.inputAccessoryView = datePickerToolbar;
}

-(void)createCancelToolBar
{
    datePickerToolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    datePickerToolbar.barStyle = UIBarStyleDefault;
    datePickerToolbar.tintColor=[UIColor whiteColor];
    datePickerToolbar.barTintColor=[UIColor darkGrayColor];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)];
    [barItems addObject:cancelBtn];
    
    [datePickerToolbar setItems:[barItems copy] animated:YES];
    [datePickerToolbar sizeToFit];
    
}

- (void)doneClicked
{
    NSLog(@"Done Clicked.");
    [self.scrollView setContentOffset:CGPointMake(0,0)];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.view endEditing:YES];
}


@end
