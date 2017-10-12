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
    responseData = [[NSMutableDictionary alloc]init];
    self.merchantIDView.layer.cornerRadius = self.merchantIDView.frame.size.height/2;
    self.merchantIDView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.merchantIDView.layer.borderWidth=1.0;
    self.activateBtn.layer.cornerRadius = self.activateBtn.frame.size.height/2;
    
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
    if ([self validation]) {
        [self loadData];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
//    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 650)];
 
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
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height+200)];

  [self.scrollView setContentOffset:CGPointMake(0,80)];
}


-(void)loadData
{
    
    NSDictionary *params = @{@"merchantId":self.merchantIDTxtFld.text};
    [self loadDataForListing:params];
    
}
-(void)loadDataForListing:(NSDictionary *)params
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/merchant-activate",BASEURL];
    
    NSMutableURLRequest *request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            
        }
        else
        {
            responseData = [responseObject valueForKey:@"responseData"];
            userID = [[responseData valueForKey:@"userId"] integerValue];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)userID] forKey:@"UserID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            HomeVC *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            //homeVC.newUserID = userID;
            [self.navigationController pushViewController:homeVC animated:YES];
            [SVProgressHUD dismiss];
            
        }
    }];
    [dataTask resume];
}

#pragma - mark Validation Method

-(BOOL)validation
{
    
    BOOL isVerified=YES;
    
    if(self.merchantIDTxtFld.text.length==0 || [[self.merchantIDTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        [self displayAlertView:0];
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
            msg=@"Please enter a Merchant ID.";
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

@end
