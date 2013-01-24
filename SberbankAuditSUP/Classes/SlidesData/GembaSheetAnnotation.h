//
//  GembaSheetAnnotation.h
//  SberbankAudit
//
//  Created by Артем Куликов on 23.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface GembaSheetAnnotation : MKAnnotationView

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end



