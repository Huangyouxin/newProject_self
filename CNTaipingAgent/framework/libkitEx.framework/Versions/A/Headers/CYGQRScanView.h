//
//  CYGQRScanView.h
//  framework
//
//  Created by 崔玉国 on 14-8-23.
//
//

#import <UIKit/UIKit.h>


/**  二维码扫描
 用法如：
 scanView = [[CYGQRScanView alloc] initWithFrame:self.view.bounds];
 scanView.frameView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 280, 280)];
 scanView.frameView.image = [UIImage imageNamed:@"pick_bg"];
 scanView.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
 scanView.lineView.image = [UIImage imageNamed:@"line"];
 [self.view addSubview:scanView];
 [scanView qrScanCompleted:^(NSString *result) {
      NSLog(@"---qr content string = %@", result);
 }];
*/

@interface CYGQRScanView : UIView
@property(nonatomic, strong)UIImageView* frameView;
@property(nonatomic, strong)UIImageView* lineView;
@property(nonatomic, readonly)UILabel *  introudctView;


- (void)qrScanCompleted:(void (^)(NSString* result))completion;

- (void)startScan;
- (void)stopScan;

@end
