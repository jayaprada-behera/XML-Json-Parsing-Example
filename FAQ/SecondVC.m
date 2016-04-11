//
//  SecondVC.m
//  FAQ
//
//  Created by jayaprada on 28/03/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()
- (IBAction)buttonTapped:(id)sender;

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       //Do Background task
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update UI
        });
    });
    NSLog(@"%d",myPublicVariable);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonTapped:(id)sender {
    if([self.delegate respondsToSelector:@selector(accessMyClassProtocolWithValue:)]){
        [self.delegate accessMyClassProtocolWithValue:@"LipiTipi"];
    }
     [self.navigationController popViewControllerAnimated:YES];
}
@end
