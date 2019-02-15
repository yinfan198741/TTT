
//
//  ImageHeaderViewController.m
//  TT
//
//  Created by 尹凡 on 1/21/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "ImageHeaderViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
//#import <Photos/Photos.h>

@interface _ImagePickerViewController: UIImagePickerController

@end
@implementation _ImagePickerViewController
- (void)setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
  [super setDelegate:delegate];
}
- (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
  return [super delegate];
}

@end

@interface ImageHeaderViewController ()
@property(nonatomic , strong)UIImageView *imageView;
@property(nonatomic , strong)UIImagePickerController *pickerController;
@end

@implementation ImageHeaderViewController
//@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
  
  UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
  [button setTitle:@"选图" forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.redColor];
  [button addTarget:self action:@selector(chooseIMG) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 200, 200)];
  [self.view addSubview:self.imageView];
  
    // Do any additional setup after loading the view.
}

-(void)dealloc {
//  [super dealloc];
  NSLog(@"dealloc");
}

-(void)chooseIMG {
  NSLog(@"chooseIMG");
//  UIImagePickerController* pic = [[UIImagePickerController alloc] init];
//  pic.editing = YES;
//  pic.delegate = self;
//  pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
////   [self presentViewController:pic animated:YES completion:nil];
//  [self presentViewController:pic animated:true completion:nil];
  
//  UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
////  self.pickerController = [[UIImagePickerController alloc] init];
//  pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//  pickerController.allowsEditing = YES;
//  pickerController.delegate = self;
//  pickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//  [self presentViewController:pickerController animated:YES completion:NULL];

  _pickerController = [[_ImagePickerViewController alloc] init];
  if ([_ImagePickerViewController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
    _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _pickerController.allowsEditing = YES;
    _pickerController.delegate = self;
    [self presentViewController:_pickerController animated:YES completion:NULL];
  }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
  NSLog(@"didFinishPickingMediaWithInfo");
  
//  [picker dismissViewControllerAnimated:YES completion:NULL];
  
//  UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//  if (image == nil)
//    image = [info objectForKey:UIImagePickerControllerOriginalImage];
//
//  // Do something with the image
//  [self.imageView setImage:image];
  
  ////  dismiss(animated: true, completion: nil)
  //
  ////  [self dismissViewControllerAnimated:YES completion:NULL];
  //
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
  
    // Do something with the image
    [self.imageView setImage:image];
  
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:false completion:nil];
//    [self dismissViewControllerAnimated:false completion:nil];
  //
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  NSLog(@"%@", NSStringFromClass([navigationController class]));
  NSLog(@"%@", navigationController.delegate);
  NSLog(@"%s", _cmd);
  NSLog(@"%@", NSStringFromClass([viewController class]));
}

@end
