//
//  ReceiveViewController.m
//  X-Share
//
//  Created by Sifon on 10/02/2015.
//  Copyright (c) 2015 4sim3. All rights reserved.
//

#import "ReceiveViewController.h"
#import "WECodeScannerView.h"
#import "WESoundHelper.h"
#import "SingletonClass.h"

@interface ReceiveViewController ()<WECodeScannerViewDelegate>
@property (nonatomic, strong) WECodeScannerView *codeScannerView;
@property (nonatomic, strong) UILabel *codeLabel;
@end

@implementation ReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"seifiiiiii");

    CGFloat labelHeight = 60.0f;
    
    self.codeScannerView = [[WECodeScannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - labelHeight)];
    
    self.codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.codeScannerView.frame.size.height, self.view.bounds.size.width - 10, labelHeight)];
    
    self.codeLabel.backgroundColor = [UIColor redColor];
    self.codeLabel.textColor = [UIColor blackColor];
    self.codeLabel.font = [UIFont boldSystemFontOfSize:17.0];
    self.codeLabel.numberOfLines = 2;
    self.codeLabel.textAlignment = NSTextAlignmentCenter;
    self.codeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    NSLog(@"seifiiiiii");

    self.codeScannerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.codeScannerView.delegate = self;
    [self.view addSubview:self.codeScannerView];
    [self.view addSubview:self.codeLabel];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.codeScannerView stop];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.codeScannerView start];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - WECodeScannerViewDelegate

- (void)scannerView:(WECodeScannerView *)scannerView didReadCode:(NSString*)code {
    NSLog(@"Scanned code: %@", code);
    self.codeLabel.text = [NSString stringWithFormat:@"Scanned code: %@", code];
    
    
    
    
    [self performSelector:@selector(beep) withObject:nil afterDelay:0.1];
    
    
    NSString *UrlScanned = code;
    SingletonClass* sharedURL = [SingletonClass sharedURL];
    [sharedURL setUrl:UrlScanned];
    
    
    
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DownloadViewController"];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)scannerViewDidStartScanning:(WECodeScannerView *)scannerView {
    self.codeLabel.text = @"Scanning...";
}

- (void)scannerViewDidStopScanning:(WECodeScannerView *)scannerView {
    
}

#pragma mark - Private

- (void)beep {
    [WESoundHelper playSoundFromFile:@"right_answer.mp3" fromBundle:[NSBundle mainBundle] asAlert:YES];
}



@end
