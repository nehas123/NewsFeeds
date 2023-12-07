//
//  NewsFeedCell.h
//  NewsDemo
//
//  Created by Neha Salankar New on 07/12/23.
//


#import <UIKit/UIKit.h>

@interface NewsFeedCell: UITableViewCell 
    @property (strong, nonatomic) IBOutlet UIImageView* feedImageview;
    @property (strong, nonatomic) IBOutlet UILabel* titleLabel;
    @property (strong, nonatomic) IBOutlet UILabel* publishedDateLabel;
    @property (strong, nonatomic) IBOutlet UILabel* descriptionLabel;
@end
