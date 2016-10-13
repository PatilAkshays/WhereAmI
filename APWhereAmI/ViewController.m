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
    
    self.startDetectingLocation.layer.borderWidth=2;
    
    self.startDetectingLocation.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    [self startDetectingLocation];

    
    UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    
    longPress.minimumPressDuration = 2;
    
    [self.mapView addGestureRecognizer:longPress];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    
    CLLocationCoordinate2D pressedCoordinate;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint pressLocation = [gesture locationInView:gesture.view];
        
        pressedCoordinate = [self.mapView convertPoint:pressLocation toCoordinateFromView:gesture.view];
        
        MKPointAnnotation *myAnnotation =[[MKPointAnnotation alloc]init];
        
        myAnnotation.coordinate = pressedCoordinate;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:pressedCoordinate.latitude longitude:pressedCoordinate.longitude];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            
            if (error) {
                NSLog(@"%@",error.localizedDescription);
                
                myAnnotation.title = @"Unknown Place";
                
                [self.mapView addAnnotation:myAnnotation];
            }
            else{
                
                
                if (placemarks.count > 0) {
                    
                    CLPlacemark *myPlacemark = placemarks.lastObject;
                    
                    NSString *title =  [myPlacemark.subThoroughfare stringByAppendingString:myPlacemark.thoroughfare];
                    
                    NSString *subTitle = myPlacemark.locality;
                    
                    myAnnotation.title = title;
                    
                    myAnnotation.subtitle = subTitle;
                    
                    _labelAddress.text = [NSString stringWithFormat:@"%@",myPlacemark.locality];

                    
                    [self.mapView addAnnotation:myAnnotation];
                }
                else{
                    
                    myAnnotation.title = @"Unknown Place";
                    
                    [self.mapView addAnnotation:myAnnotation];
                }
                
            }
        }];
    }
    
    else if (gesture.state == UIGestureRecognizerStateEnded){
        
        
      //  NSLog(@"Gesture Recognizer End");
    }
    
}


//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
//{
//    MKPinAnnotationView *annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
//    annotationView.pinTintColor = [UIColor blackColor];
//    
//    annotationView.canShowCallout = YES;
//    
//    return annotationView;
//}






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
    
    _labelSpeed.text = [NSString stringWithFormat:@"%f",currentLocation.speed];

//    _labelAltitude.text = [NSString stringWithFormat:@"%f",currentLocation.];

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


- (IBAction)mapViewType:(id)sender {
    
    UISegmentedControl *localSegment =sender;
    
    if (localSegment.selectedSegmentIndex == 0) {
        
        [self.mapView setMapType:MKMapTypeStandard];
    }
    else if (localSegment.selectedSegmentIndex == 1) {
        
        [self.mapView setMapType:MKMapTypeSatellite];
    }
    else if (localSegment.selectedSegmentIndex == 2) {
        
        [self.mapView setMapType:MKMapTypeHybrid];
    }

    
    
}
@end
