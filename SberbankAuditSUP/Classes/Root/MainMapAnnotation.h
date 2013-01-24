//
//  MainMapAnnotation.h
//  SberbankAudit
//
//  Created by Артем Куликов on 06.06.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MainMapAnnotation : MKAnnotationView

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
