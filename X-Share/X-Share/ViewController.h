//
//  ViewController.h
//  X-Share
//
//  Created by Sifon on 10/02/2015.
//  Copyright (c) 2015 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDWebServer.h"
#import "GCDWebDAVServer.h"
#import "GCDWebServerDataResponse.h"
#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
{
    GCDWebServer* _webServer;
    GCDWebDAVServer* _davServer;

}


- (IBAction)test:(id)sender;


- (IBAction)SendButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *image;
- (IBAction)MusicPicker:(id)sender;

- (IBAction)PDFPicker:(id)sender;

@end

