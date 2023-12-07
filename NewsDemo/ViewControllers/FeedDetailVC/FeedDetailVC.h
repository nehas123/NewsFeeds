//
//  FeedDetailVC.h
//  NewsDemo
//
//  Created by Neha Salankar New on 07/12/23.
//

#import <UIKit/UIKit.h>

@interface FeedDetailVC : UIViewController
@property (strong, nonatomic) NSDictionary *newsInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@end
