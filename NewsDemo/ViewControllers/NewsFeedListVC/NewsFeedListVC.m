//
//  ViewController.m
//  NewsDemo
//
//  Created by Neha Salankar New on 06/12/23.
//

#import "NewsFeedListVC.h"
#import "NewsFeedCell.h"
#import "FeedDetailVc.h"

@interface NewsFeedListVC ()
{
    NSArray* newsFeedArray;
}
- (void)callAPI:(NSString*)url res:(void (^)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler;
@end

@implementation NewsFeedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"News";
    [self getNewsFeedsFromLocalJsonFile];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";

    NewsFeedCell *cell = (NewsFeedCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.feedImageview.image = [UIImage imageNamed: @"default_image.png"];
    NSDictionary* newsFeedDict = newsFeedArray[indexPath.row];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [newsFeedDict valueForKey:@"urlToImage"]]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.feedImageview.image = [UIImage imageWithData: data];
        });
    });
    cell.titleLabel.text = [newsFeedDict valueForKey:@"title"];
    cell.publishedDateLabel.text = [newsFeedDict valueForKey:@"publishedAt"];
    cell.descriptionLabel.text = [newsFeedDict valueForKey:@"description"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedDetailVC* controller = (FeedDetailVC* )[storyboard instantiateViewControllerWithIdentifier:@"FeedDetailVc"];
    NSDictionary* newsFeedDict = newsFeedArray[indexPath.row];
    controller.newsInfo = newsFeedDict;
    [self presentViewController:controller animated:YES completion:nil];
}

//Code to get data from locally saved file
- (void)getNewsFeedsFromLocalJsonFile {
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"NewsFeeds" ofType:@"json"];
     NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
     NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
     NSError* error1;
     NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error1];
     newsFeedArray = [jsonDict valueForKey:@"articles"];
}

//Code to get data from API
- (void)getNewsFeedsFromAPI {
    NSString *urlString = @"https://newsapi.org/v2/everything?q=tesla&from=2023-11-06&sortBy=publishedAt&apiKey=b1b3f3f0499a42dfa5234e7a6f3a419f";

    [self callAPI:urlString res:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
           NSLog(@"res %@, err %@", json, error);
       }];
}

- (void)callAPI:(NSString*)url res:(void (^)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler {
    [self callAPI:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSError* error1;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error1];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(json, error1);
        });
    }];
}

- (void)callAPI:(NSString*)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[defaultSession dataTaskWithRequest:urlRequest
                       completionHandler:completionHandler] resume];
}
@end
