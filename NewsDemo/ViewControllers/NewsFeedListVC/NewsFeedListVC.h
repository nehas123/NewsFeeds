//
//  NewsFeedListVC.h
//  NewsDemo
//
//  Created by Neha Salankar New on 06/12/23.
//

#import <UIKit/UIKit.h>

@interface NewsFeedListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsFeedTableView;
@end

