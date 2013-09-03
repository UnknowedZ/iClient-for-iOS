//
//  FirstViewController.m
//  mapwithmarker
//
//  Created by iclient on 13-9-3.
//  Copyright (c) 2013年 iclient. All rights reserved.
//

#import "FirstViewController.h"

#import "RMMarker.h"
#import "RMMarkerManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize mapView,calloutView;
- (void)loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    [self setMapView:[[RMMapView alloc] initWithFrame:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)] ];
    self.view = mapView;
       
    RMProjectedPoint prjPnt = (RMProjectedPoint){12969236.42061722,4863568.820204712};
    [self setMapCenter:prjPnt];
    mapView.contents.zoom = 14;
    // Your own code
    
    UIImage *image = [UIImage imageNamed:@"mylocation.png"];
    RMMarker *newMarker = [[RMMarker alloc] initWithUIImage:image anchorPoint:CGPointMake(0.5, 0.5)];
    [mapView.contents.markerManager addMarker:newMarker atProjectedPoint:prjPnt];
    mapView.delegate = self;
    calloutView = [[SMCalloutView alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMapCenter:(RMProjectedPoint) prjPnt
{
    [mapView.contents setCenterProjectedPoint:prjPnt];
}

- (void) singleTapOnMap:(RMMapView *)map At:(CGPoint)point
{
    
    if (calloutView.window){
        [calloutView performSelector:@selector(dismissCalloutAnimated:) withObject:nil afterDelay:1.0/3.0];
    }
}
-(void)beforeMapMove:(RMMapView *)map
{
    if (calloutView.window){
        [calloutView performSelector:@selector(dismissCalloutAnimated:) withObject:nil afterDelay:1.0/3.0];
    }
}
- (void) tapOnMarker: (RMMarker*) marker onMap: (RMMapView*) map
{
    if (calloutView.window){
        [calloutView performSelector:@selector(dismissCalloutAnimated:) withObject:nil afterDelay:1.0/3.0];
    }
    else
    {        
        calloutView.titleView.text = @"SuperMap";
        calloutView.subtitleView.text = @"北京超图软件股份有限公司";
        [calloutView presentCalloutFromRect:marker.frame
                                     inView:mapView
                          constrainedToView:mapView
                   permittedArrowDirections:SMCalloutArrowDirectionDown
                                   animated:YES];
    }
}

@end
