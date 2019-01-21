//
//  HashViewController.m
//  TT
//
//  Created by 尹凡 on 11/29/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "HashViewController.h"
#import <CommonCrypto/CommonDigest.h>
//#import "GTMBase64.h"
@interface HashViewController ()

@end

//inbons-MacBook-Pro:erpretail.app yinfan$ shasum AppIcon29x29@2x.png
//d8ec2d2003419f1cfc082285ce6ac9ae17a5ae04  AppIcon29x29@2x.png
//inbons-MacBook-Pro:erpretail.app yinfan$ echo "2OwtIANBnxz8CCKFzmrJrhelrgQ=" | base64 -D | xxd -p
//d8ec2d2003419f1cfc082285ce6ac9ae17a5ae04
//inbons-MacBook-Pro:erpretail.app yinfan$ MD5 AppIcon29x29\@2x.png
//MD5 (AppIcon29x29@2x.png) = a05f4508dc3a0ef0ff2fcac0a1270b58

// echo "d8ec2d2003419f1cfc082285ce6ac9ae17a5ae04" |xxd -r -p | base64

@implementation HashViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  self.title = @"HASH";
  NSLog(@"path = %@",[HashViewController filePath]);
//  UILabel* label = [[UILabel alloc] ini]
  NSLog(@"codeSignFile cityHash = %@",[HashViewController codeSignFilePath]);
  NSLog(@"sha1_base64 = %@",[HashViewController sha1_base64]);
  NSLog(@"sha1 = %@",[HashViewController sha1]);
//  NSLog(@"MD5 = %@",[HashViewController md5]);
}


+ (NSString*)sha1_base64 {
  
  NSData *data = [HashViewController getFileData];
  //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];
  //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
  CC_SHA1(data.bytes, data.length, digest);
  
  NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
//  base64 = [GTMBase64 encodeData:base64];
//  NSString * output1 = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
  
//  NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//  for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
//  [output appendFormat:@"%02x", digest[i]];
  return @"";
//  return output1;
}
+ (NSString*)sha1
{
//010
//0,1,0
//0,10
  NSData *data = [HashViewController getFileData];
  //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];
  //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
  CC_SHA1(data.bytes, data.length, digest);
  
//  NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
//  base64 = [GTMBase64 encodeData:base64];
//  NSString * output1 = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];

  NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
  for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
  [output appendFormat:@"%02x", digest[i]];
  
  return output;
}

+(NSString *)md5
{
//  NSData *data = [HashViewController getFileData];
//  unsigned char digest[CC_MD5_DIGEST_LENGTH];
//  CC_MD5( data.bytes,  (CC_LONG)data.length, digest );

  NSData *data = [HashViewController getFileData];
  const char *cStr = (unsigned char *)[data bytes];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5( cStr, (CC_LONG)data.length, digest );
  
  NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
  [output appendFormat:@"%02x", digest[i]];
  
  return output;
}



+ (NSString*)filePath {
  id mb = [NSBundle mainBundle];
  NSString* rootPath = (NSString*)[mb resourcePath];
  NSString* pngPath =  [NSString stringWithFormat:@"%@/citydata.plist",rootPath];
  return pngPath;
}

+ (NSString*)codeSignFilePath {
  id mb = [NSBundle mainBundle];
  NSString* rootPath = (NSString*)[mb resourcePath];
//  /_CodeSignature/CodeResources
  NSString* pngPath =  [NSString stringWithFormat:@"%@/_CodeSignature/CodeResources",rootPath];
//  NSString* filePath = [HashViewController filePath];
  NSDictionary* dic = [[NSDictionary alloc] initWithContentsOfFile:pngPath];
//  NSData* _data = [NSData dataWithContentsOfFile:filePath];
//  NSLog(_data);
  NSString* cityHash = [[[dic objectForKey:@"files2"] objectForKey:@"citydata.plist"] objectForKey:@"hash"];
  return cityHash;
}

+ (NSData*)getFileData {
  NSString* filePath = [HashViewController filePath];
  NSData* _data = [NSData dataWithContentsOfFile:filePath];
  return _data;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

