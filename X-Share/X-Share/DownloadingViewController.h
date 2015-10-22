//
//  DownloadingViewController.h
//  X-Share
//
//  Created by Sifon on 10/02/2015.
//  Copyright (c) 2015 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *SaveButton;
- (IBAction)SaveButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

@end
