//
//  D2GHViewControllerMain.m
//  WorldOfDota2
//
//  Created by Andrei on 28/07/14.
//  Copyright (c) 2014 G6. All rights reserved.
//

#import "D2GHViewControllerMain.h"

@interface D2GHViewControllerMain ()

@end

@implementation D2GHViewControllerMain

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getAddress:(double)latitude Longitude:(double)longitude
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:2];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    NSString *url = [ NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude];


    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"REQUEST COMPLETED - %@", responseObject);
        NSArray *responseDictionary = [responseObject objectForKey:@"results"];
        for (  NSDictionary *newDic in responseDictionary) {
            NSString *streets =[newDic objectForKey:@"formatted_address"];
            streetLocation=[NSString stringWithString:streets];
            NSLog(@"%@",streetLocation);
            [self  setLocationTags];
            break;
        }
        NSLog(@"%lu",(unsigned long)responseDictionary.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"REQUEST FAILED.");
    }];


}

@end
