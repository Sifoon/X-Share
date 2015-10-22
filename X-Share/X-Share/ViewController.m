//
//  ViewController.m
//  X-Share
//
//  Created by Sifon on 10/02/2015.
//  Copyright (c) 2015 4sim3. All rights reserved.
//

#import "ViewController.h"
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "GMImagePickerController.h"
#import <UIKit/UIKit.h>
#import "GCDWebServerRequest.h"
#import "UIImage+MDQRCode.h"
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>



@interface ViewController () <UIImagePickerControllerDelegate,MPMediaPickerControllerDelegate ,UIDocumentPickerDelegate>

@property (strong,nonatomic) NSData *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _image.image=[UIImage imageNamed:@"1.jpg"];
    
    
    
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)test:(id)sender {
    
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _davServer = [[GCDWebDAVServer alloc]  initWithUploadDirectory:documentsPath];
    [_davServer start];
    NSLog(@"Visit %@ in your WebDAV client", _davServer.serverURL);
}

- (IBAction)SendButton:(id)sender {
   // GMImagePickerController *picker = [[GMImagePickerController alloc] init];
  //  picker.delegate = self;
  //  [self presentViewController:picker animated:YES completion:nil];
    UIImagePickerController *pickerr = [[UIImagePickerController alloc] init];
    pickerr.delegate = self;
    pickerr.allowsEditing = YES;
   

    pickerr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerr animated:YES completion:NULL];

 
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.image.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    NSData* pictureData = UIImagePNGRepresentation(_image.image);
    NSLog(@"====%@",pictureData);
    //NSString *st= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    _webServer = [[GCDWebServer alloc] init];
    
    //Add a handler to respond to GET requests on any URL
    [_webServer addDefaultHandlerForMethod:@"GET"
                              requestClass:[GCDWebServerRequest class]
                              processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                  
                                  return [GCDWebServerDataResponse responseWithData:pictureData contentType:@"image/jpeg" ];
                                  
                              }];
    
    
    // [_webServer addGETHandlerForPath:@"/image" staticData:data contentType:@"image/jpg" cacheAge:23];
    //  GCDWebServerRequest *re= [[GCDWebServerRequest alloc]init ];
    
    
    
    // Start server on port 8080
    [_webServer startWithPort:8081 bonjourName:nil];
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
    

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)MusicPicker:(id)sender {
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    [picker setDelegate:self];
    [picker setAllowsPickingMultipleItems: NO];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)PDFPicker:(id)sender {
    
    NSArray *UTIs = @[@"public.text"];
    
    UIDocumentMenuViewController *importMenu = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:UTIs inMode:UIDocumentPickerModeImport];
  //  importMenu.delegate = self;
    [self presentViewController:importMenu animated:YES completion:nil];
    //pickerr.allowsEditing = YES;
    
    
   
}
#pragma mark - Media Picker Delegate

/*
 * This method is called when the user chooses something from the media picker screen. It dismisses the media picker screen
 * and plays the selected song.
 */
- (void)mediaPicker:(MPMediaPickerController *) mediaPicker didPickMediaItems:(MPMediaItemCollection *) collection {
    
    // remove the media picker screen
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    // grab the first selection (media picker is capable of returning more than one selected item,
    // but this app only deals with one song at a time)
    MPMediaItem *item = [[collection items] objectAtIndex:0];
    NSString *title = [item valueForProperty:MPMediaItemPropertyTitle];
   // [_navBar.topItem setTitle:title];
    
    // get a URL reference to the selected item
    NSURL *url = [item valueForProperty:MPMediaItemPropertyAssetURL];
    
    NSString *myString = [url absoluteString];
    
    
   // NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _davServer = [[GCDWebDAVServer alloc]  initWithUploadDirectory:myString];
    [_davServer start];
    NSLog(@"Visit %@ in your WebDAV client", _davServer.serverURL);
  
    
//    
//    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: url options:nil];
//    
//    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset
//                                                                      presetName:AVAssetExportPresetAppleM4A];
//    
//    exporter.outputFileType =   @"com.apple.m4a-audio";
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * myDocumentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
//    
//    [[NSDate date] timeIntervalSince1970];
//    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
//    NSString *intervalSeconds = [NSString stringWithFormat:@"%0.0f",seconds];
//    
//    NSString * fileName = [NSString stringWithFormat:@"%@.m4a",intervalSeconds];
//    
//    NSString *exportFile = [myDocumentsDirectory stringByAppendingPathComponent:fileName];
//    
//    
//    
//    
//    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
//    exporter.outputURL = exportURL;
//    
//    // do the export
//    // (completion handler block omitted)
//    [exporter exportAsynchronouslyWithCompletionHandler:
//     ^{
//         int exportStatus = exporter.status;
//         
//         switch (exportStatus)
//         {
//             case AVAssetExportSessionStatusFailed:
//             {
//                 NSError *exportError = exporter.error;
//                 NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
//                 break;
//             }
//             case AVAssetExportSessionStatusCompleted:
//             {
//                 NSLog (@"AVAssetExportSessionStatusCompleted");
//                 
//                _data = [NSData dataWithContentsOfFile: [myDocumentsDirectory
//                                                                 stringByAppendingPathComponent:fileName]];
//                 
//                 //DLog(@"Data %@",data);
//                 ///NSLog(@"aaaaaa%@",_data);
//                 
//                 //NSString *st= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                 
//                 if (_data)
//                 {
//                     
//                     _webServer = [[GCDWebServer alloc] init];
//                     
//                     
//                     
//                     //Add a handler to respond to GET requests on any URL
//                     [_webServer addDefaultHandlerForMethod:@"GET"
//                                               requestClass:[GCDWebServerRequest class]
//                                               processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
//                                                   
//                                                   return [GCDWebServerDataResponse responseWithData:_data contentType:@"audio/x-m4a" ];
//                                                   
//                                               }];
//                     
//                     
//                     // [_webServer addGETHandlerForPath:@"/image" staticData:data contentType:@"image/jpg" cacheAge:23];
//                     //  GCDWebServerRequest *re= [[GCDWebServerRequest alloc]init ];
//                     
//                     
//                     
//                     // Start server on port 8080
//                     [_webServer startWithPort:8082 bonjourName:nil];
//                     NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
//                     
//                     
//                 }
//                 
//
//                // _data = nil;
//                 
//                 break;
//             }
//             case AVAssetExportSessionStatusUnknown:
//             {
//                 NSLog (@"AVAssetExportSessionStatusUnknown"); break;
//             }
//             case AVAssetExportSessionStatusExporting:
//             {
//                 NSLog (@"AVAssetExportSessionStatusExporting"); break;
//             }
//             case AVAssetExportSessionStatusCancelled:
//             {
//                 NSLog (@"AVAssetExportSessionStatusCancelled"); break;
//             }
//             case AVAssetExportSessionStatusWaiting:
//             {
//                 NSLog (@"AVAssetExportSessionStatusWaiting"); break;
//             }
//             default:
//             {
//                 NSLog (@"didn't get export status"); break;
//             }
//         }
//     }];
//
//    
//    

    
    

   
    
    // pass the URL to playURL:, defined earlier in this file
   // [self playURL:url];
}

/*
 * This method is called when the user cancels out of the media picker. It just dismisses the media picker screen.
 */
- (void)mediaPickerDidCancel:(MPMediaPickerController *) mediaPicker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
