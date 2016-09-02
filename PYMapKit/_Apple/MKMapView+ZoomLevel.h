//
// MKMapView+ZoomLevel.h
//
//  Created by YR on 15/9/18.
//  Copyright © 2015年 YR. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
    zoomLevel:(NSUInteger)zoomLevel
    animated:(BOOL)animated;

-(MKCoordinateRegion)coordinateRegionWithMapView:(MKMapView *)mapView
                                centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
								andZoomLevel:(NSUInteger)zoomLevel;
- (NSUInteger) zoomLevel;

@end
