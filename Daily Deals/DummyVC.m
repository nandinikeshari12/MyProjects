
//  DummyVC.m
//  Daily Deals
//  Created by Mac5 on 10/10/17.
//  Copyright © 2017 Mac5. All rights reserved.

#import "DummyVC.h"
#import "MerchantLinkingID.h"
#import "HomeVC.h"

@interface DummyVC ()

@end

@implementation DummyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"])
    {
        [self moveToHomeVC];
    }
    else
    {
        [self moveToMerchantVC];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)moveToMerchantVC
{
    MerchantLinkingID *tempVC=[self.storyboard instantiateViewControllerWithIdentifier:@"MerchantLinkingID"];
    [self.navigationController pushViewController:tempVC animated:NO];
}

-(void)moveToHomeVC
{
    HomeVC *tempVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:tempVC animated:NO];

}


@end
