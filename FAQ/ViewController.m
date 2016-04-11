//
//  ViewController.m
//  FAQ
//
//  Created by Aravind on 29/01/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"
#import "DataModel.h"
#import "XMLParser.h"

#define jSon_URL_String  @"http://125.16.240.78:8080/patientCenter-1/v1/vhealth/getRoomType"

@interface ViewController ()<myCustomeDelegate,UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{
    NSInteger a;
    NSMutableArray *numbers;
    XMLParser *parser;
    
}
- (IBAction)nextButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation ViewController
-(void)ImageDownloadingWithURL:(NSURL *)url WithCompletionBlock:(void(^)(BOOL isSucceeded , UIImage *img))blockComplted{

//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//        //CurrentQueue:The operation queue that started the operation or nil if the queue could not be determined.
//        //mainQueue:Returns the operation queue associated with the main thread.The default operation queue bound to the main thread.
//    }];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            
            blockComplted(YES,img);
        }else{
            blockComplted(NO,nil);
        }
    }];
    [task resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *str1 =@"iOS";
    NSString *str2 = @"iOS";
    if (str1 == str2) {
        NSLog(@"Equal");
    } if ([str1 isEqualToString:str2]){
        NSLog(@"isEqualToString");
    }
    if ([str1 isEqual:str2]){
        NSLog(@"isEqual");
    }
    
//    parser = [[XMLParser alloc] init];
//    [parser startXML];
//     if (parser.dataArray.count>0) {
//        [self.myTableView reloadData];
//    }
    [self jSonData];
}

-(void)jSonData{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:jSon_URL_String]];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &connectionError];
            
            NSLog(@"Response %@",json);
            
        }else{
        
        
        }
    } ];

}
-(void)postRequest{
    NSDictionary *dict = nil;NSError *err;
    NSString *str = @"";
    //http body
    NSData *body = [str dataUsingEncoding:NSUTF8StringEncoding];
    //value
    NSString *contentType = @"application/json";
    
    //header
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:jSon_URL_String];
    [req setHTTPBody:body];
    [req setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [req setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
    }];
    
    NSURLConnection *conn =[[NSURLConnection alloc] initWithRequest:req delegate:self];
    
}

#pragma mark - UITABLEVIEW DATASOURCE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return parser.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    DataModel *model1 = [parser.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model1.itemtTitle;
    cell.detailTextLabel.text = model1.desc;
    if (model1.modelImg) {
        cell.imageView.image = model1.modelImg;
    }else{
    cell.imageView.image=[UIImage imageNamed:@"transparent"];
    [self ImageDownloadingWithURL:[NSURL URLWithString:model1.imgURLString] WithCompletionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            cell.imageView.image = image;
            model1.modelImg = image;
        }
    }];
    }
    return cell;
    
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
     
            completionBlock(YES,img);
        }else{
            completionBlock(NO,nil);
        }
    }];
 
}
// This returns the string of the characters encountered thus far. You may not necessarily get the longest character run. The parser reserves the right to hand these to the delegate as potentially many calls in a row to -parser:foundCharacters:
#pragma mark --
#pragma mark - Testing Methods
-(void)accessMyClassProtocolWithValue:(NSString *)vc{
    [self.myLabel setText:vc];
}
-(void)sampleCodeOne
{
    NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Debasis",@"firstName",@"Das",@"lastName", nil];
    
    
    
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    //Create nsoperation
    NSInvocationOperation *invocOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testMethodOne:) object:dataDict];
    [opQueue addOperation:invocOp];
    
}
-(void)testMethodOne:(id)obj
{
    NSLog(@"is testMethodOne running on main thread? ANS - %@",[NSThread isMainThread]? @"YES":@"NO");
    NSLog(@"obj %@",obj);
    
    //Do something using Obj or with Obj
}
-(void)sampleCodeTwo
{
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    NSBlockOperation *blockCompletionOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"The block operation ended, Do something such as show a successmessage etc");
        //This the completion block operation
    }];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        //This is the worker block operation
        [self methodOne];
    }];
    [blockCompletionOperation addDependency:blockOperation];
    [operationQueue addOperation:blockCompletionOperation];
    [operationQueue addOperation:blockOperation];
    
    
    
}

-(void)methodOne
{
    NSLog(@"is testMethodOne running on main thread? ANS - %@",[NSThread isMainThread]? @"YES":@"NO");
    for (int i = 0; i<5; i++)
    {
        NSLog(@"sleeps for 1 sec and i is %d",i);
        //        sleep(1);
    }
}

-(void)myTestingMethods{
    /****   NSOPERATION EXAMPLE *******/
    
    [self sampleCodeOne];
    
    [self sampleCodeTwo];
    
    
    
    NSLog(@"viewdidLoad");
    
    //*****     SORT AN ARRAY OF NUMBERS    *********//
    
    numbers = [NSMutableArray arrayWithObjects:@"23",@"121",@"12",@"340",@"0",@"2",nil];
    
    
    for (int i = 0; i < numbers.count; i++)
    {
        for ( int j = i ; j < numbers.count; ++j)
        {
            NSInteger iValue = [[numbers objectAtIndex:i] integerValue];
            NSInteger jValue = [[numbers objectAtIndex:j] integerValue];
            if (iValue > jValue)
            {
                a =  iValue;
                [numbers replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",(long)jValue]];
                [numbers replaceObjectAtIndex:j  withObject:[NSString stringWithFormat:@"%ld",(long)a]];
                //                NSLog(@"%@",numbers);
            }
        }
    }
    NSLog(@"%@",numbers);
    /*  END */
    
    /* FIBONACCI SERIES*/
    int no =6;
    int next,first=0,second = 1 ;
    
    for (int c = 0 ; c < no; c++ )
    {
        if ( c <= 1 )
            next = c;
        else
        {
            next = first + second;
            first = second;
            second = next;
        }
        printf("%d\n",next);
    }
    /*  END */
    
    
    /*  PALINDROM OF A STRING*/
    
    NSString *str = @"WOW";
    NSMutableString *copyStr = [[NSMutableString alloc] init];
    for (NSInteger i = str.length; i>0; i--) {
        NSString *lastStr = [str substringWithRange:NSMakeRange(i-1, 1)];
        [copyStr appendString:lastStr];
    }
    if ([str isEqualToString:copyStr]) {
        NSLog(@"Palidrom string");
    }else{
        NSLog(@" not Palidrom string");
    }
    /*  END */
    
    
    /*  Armstrong Number 153 = 1*1*1 + 5*5*5 + 3*3*3    */
    
    
    int n = 153, n1, rem, num=0;
    
    
    n1=n;
    while(n1!=0)
    {
        rem=n1%10;
        num+=rem*rem*rem;
        n1/=10;
    }
    if(num==n)
        printf("%d is an Armstrong number.",n);
    else
        printf("%d is not an Armstrong number.",n);
    /*  END */
    
    //    [self performSelector:@selector(mymethod) withObject:self afterDelay:10.f];
}
-(void)mymethod{
    [self.view removeFromSuperview];
    self.view = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (![self isViewLoaded]) {
        /* release your custom data which will be rebuilt in loadView or viewDidLoad */
    }
}
- (void)loadView{
    [super loadView];
    NSLog(@"loadView");
} // This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];NSLog(@"loadViewIfNeeded");
}//NS_AVAILABLE_IOS(9_0); // Loads the view controller's view if it has not already been set.
- (void)viewWillUnload{
    [super viewWillUnload];NSLog(@"viewWillUnload");
}// NS_DEPRECATED_IOS(5_0,6_0);
- (void)viewDidUnload{
    [super viewDidUnload];NSLog(@"viewDidUnload");
}// NS_DEPRECATED_IOS(3_0,6_0); // Called after the view controller's view is released and set to nil. For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.

//- (void)viewDidLoad{} // Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
- (void)viewWillAppear:(BOOL)animated{[super viewWillAppear:animated];    NSLog(@"viewWillAppear");
}   // Called when the view is about to made visible. Default does nothing
- (void)viewDidAppear:(BOOL)animated{  [super viewDidAppear:animated];  NSLog(@"viewDidAppear");
}     // Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewWillDisappear:(BOOL)animated{    NSLog(@"viewWillDisappear");
} // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated{    NSLog(@"viewDidDisappear");
}  // Called after the view was dismissed, covered or otherwise hidden. Default does nothing

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews{  [super viewWillLayoutSubviews];  NSLog(@"viewWillLayoutSubviews");
}// NS_AVAILABLE_IOS(5_0);
// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
    
}//NS_AVAILABLE_IOS(5_0);
- (IBAction)nextButtonTapped:(id)sender {
    SecondVC *secVc = [[SecondVC alloc] init];
    secVc.delegate  =self;
    secVc->myPublicVariable = 10;
    [self.navigationController pushViewController:secVc animated:YES];
}
@end
