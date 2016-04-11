//
//  SecondVC.h
//  FAQ
//
//  Created by jayaprada on 28/03/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myCustomeDelegate;

@protocol myCustomeDelegate <NSObject>

-(void)accessMyClassProtocolWithValue:(NSString *)vc;

@end

@interface SecondVC : UIViewController<myCustomeDelegate>
{
@public int myPublicVariable;
}
@property(nonatomic,weak)id<myCustomeDelegate>delegate;
 @end
