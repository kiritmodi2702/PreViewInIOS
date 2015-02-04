//
//  ViewController.m
//  PreviewInIOS
//
//  Created by mspsys087 on 2/4/15.
//  Copyright (c) 2015 mspsys087. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickGo:(id)sender {
    
    [self.txtURL resignFirstResponder];
    
    
    if ([self validateUrl:self.txtURL.text])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        
        // http://api.embed.ly/1/oembed?key=9e262634b2954a64b86e5521e9041101&url=http://facebook.com&maxwidth=100&maxheight=100&format=json
        
        NSString *strUrl =  [NSString stringWithFormat:@"http://api.embed.ly/1/oembed?key=9e262634b2954a64b86e5521e9041101&url=%@&maxwidth=100&maxheight=100&format=json",self.txtURL.text];
        
        [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response data = %@",responseObject);
            
            NSLog(@"Response data = %@",[responseObject valueForKey:@"thumbnail_url"]);
            
            [self.imagethub setImageWithURL:[NSURL URLWithString:[responseObject valueForKey:@"thumbnail_url"]]];
            
            [self.labFirst setText:[responseObject valueForKey:@"provider_name"]];
            
            [self.labDis setText:[responseObject valueForKey:@"description"]];
            
            [self.txtView setText:[responseObject valueForKey:@"provider_url"]];
              
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            [[[UIAlertView alloc]initWithTitle:@"Preview" message:error.localizedDescription delegate:self cancelButtonTitle:@"OKq" otherButtonTitles:nil, nil] show];
        }];
        
    }
    else{
        
        [[[UIAlertView alloc]initWithTitle:@"Preview" message:@"Please enter valid URL." delegate:self cancelButtonTitle:@"OKq" otherButtonTitles:nil, nil] show];
    }
}
- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}


@end
