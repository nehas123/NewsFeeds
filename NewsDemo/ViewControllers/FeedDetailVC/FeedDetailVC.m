//
//  FeedDetailVC.m
//  NewsDemo
//
//  Created by Neha Salankar New on 07/12/23.
//

#import <Foundation/Foundation.h>
#import "FeedDetailVC.h"

@implementation FeedDetailVC
@synthesize newsInfo;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.newsInfo valueForKey:@"urlToImage"]]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            self.imageview.image = [UIImage imageWithData: data];
        });
    });
    
    _descriptionLabel.text = [newsInfo valueForKey:@"description"];
}

- (IBAction)viewMoreButtonAction:(id) sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[newsInfo valueForKey:@"url"]]];
}
@end
