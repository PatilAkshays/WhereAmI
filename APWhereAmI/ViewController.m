//
//  ViewController.m
//  APWhereAmI
//
//  Created by Mac on 20/07/1938 Saka.
//  Copyright © 1938 Saka Aashish Tamsya. All rights reserved.
//

#import "ViewController.h"

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

-(void)startLocating {
    
    myLocationManager = [[CLLocationManager alloc]init];
    
    myLocationManager.delegate = self;
    
    [myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [myLocationManager requestWhenInUseAuthorization];
    
    [myLocationManager startUpdatingLocation];
    
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations lastObject];
    
    _labelLatitude.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    
    _labelLongitude.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];

    _labelAltitude.text = [NSString stringWithFormat:@"%f",currentLocation.altitude];

    NSLog(@"latitude : %f",currentLocation.coordinate.latitude);
    
    NSLog(@"longitude : %f",currentLocation.coordinate.longitude);
    
    NSLog(@"altitude : %f",currentLocation.altitude);

    
    MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.001, 0.001);
    
    MKCoordinateRegion myRegion = MKCoordinateRegionMake(currentLocation.coordinate, mySpan);
    
    [self.mapView setRegion:myRegion animated:YES];
    
    if (currentLocation != nil) {
        [myLocationManager stopUpdatingLocation];
    }
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
    
}
- (IBAction)startDetectingLocationAction:(id)sender {
    [self startLocating];
    
}
@end
