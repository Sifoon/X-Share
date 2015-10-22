//
//  DownloadingViewController.m
//  X-Share
//
//  Created by Sifon on 10/02/2015.
//  Copyright (c) 2015 4sim3. All rights reserved.
//

#import "DownloadingViewController.h"
#import "SingletonClass.h"
#import "BDMultiDownloader.h"
#import "SCLAlertView.h"

@interface DownloadingViewController ()

@end

@implementation DownloadingViewController


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.progressBar = nil;
    self.imageView = nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    SingletonClass* sharedSingleton = [SingletonClass sharedURL];
    NSString *pathimage = [sharedSingleton url];
    NSLog(@"%@ ttttttttttt",pathimage);
    
    [_SaveButton setHidden:YES];
    
    
    //configure the BDMutliDownloader to update the progressView
    [BDMultiDownloader shared].onDownloadProgressWithProgressAndSuggestedFilename = ^(double progress, NSString *filename){
        if ([[pathimage lastPathComponent] isEqualToString:filename]) {
            [self.progressBar setProgress:progress animated:YES];
        }else{
           // [self.progressBar2 setProgress:progress animated:YES];
        }
    };
    
    
    
    
    
    //StartDownloading image
    
    //reset all images and UIProgressViews
    self.progressBar.progress = 0;
    self.imageView.image = nil;
    
    
    //launch downloading of large images
    [[BDMultiDownloader shared] imageWithPath:pathimage
                                   completion:^(UIImage * image, BOOL fromCache) {
                                       self.imageView.image = image;
                                       [_SaveButton setHidden:NO];

                                       
                                       NSLog(@"Image 1 is from cache: %@", fromCache?@"YES":@"NO");
                                   }];
    
//    [[BDMultiDownloader shared] imageWithPath:kPathImage2
//                                   completion:^(UIImage * image, BOOL fromCache) {
//                                       self.imageView2.image = image;
//                                       if (self.imageView.image!=nil) {
//                                           self.startButton.enabled = YES;
//                                       }
//                                       NSLog(@"Image 2 is from cache: %@", fromCache?@"YES":@"NO");
//                                   }];
//    

    

    
    // Do any additional setup after loading the view.
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

- (IBAction)SaveButtonClicked:(id)sender {
    UIImage* imageToSave = self.imageView.image; // alternatively, imageView.image
    
    // Save it to the camera roll / saved photo album
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    
    _SaveButton.enabled=NO;
    SCLAlertView *alert1 = [[SCLAlertView alloc] init];
    
    [alert1 showNotice:self title:@"Picture Saved" subTitle:@"" closeButtonTitle:nil duration:1.0f];
    
}
@synthesize progressBar;
@synthesize imageView;

@end
