//
//  ViewController.h
//  APWhereAmI
//
//  Created by Mac on 20/07/1938 Saka.
//  Copyright © 1938 Saka Aashish Tamsya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    
    CLLocationManager *myLocationManager;
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UILabel *labelLatitude;

@property (strong, nonatomic) IBOutlet UILabel *labelLongitude;

@property (strong, nonatomic) IBOutlet UILabel *labelAltitude;

@property (strong, nonatomic) IBOutlet UILabel *labelSpeed;

@property (strong, nonatomic) IBOutlet UILabel *labelAddress;

- (IBAction)startDetectingLocationAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *startDetectingLocation;

- (IBAction)mapViewType:(id)sender;



@end

