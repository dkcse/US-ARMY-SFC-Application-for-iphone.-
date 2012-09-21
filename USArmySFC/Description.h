//
//  Description.h
//  USArmySFC
//
//  Created by Deepak Kumar on 21/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Description : NSManagedObject

@property (nonatomic, retain) NSString * serial;
@property (nonatomic, retain) NSString * sfc_name;
@property (nonatomic, retain) NSString * product_title;
@property (nonatomic, retain) NSString * slogan;
@property (nonatomic, retain) NSString * sfc_main_title;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * medevac;
@property (nonatomic, retain) NSString * hazardous_material_and_pol;
@property (nonatomic, retain) NSString * sfc_subtitle;
@property (nonatomic, retain) NSString * vehicle_movement;
@property (nonatomic, retain) NSString * wassrack_procedures;
@property (nonatomic, retain) NSString * training_area_dos_and_donts;
@property (nonatomic, retain) NSString * fire_prevention;
@property (nonatomic, retain) NSString * wildlife;
@property (nonatomic, retain) NSString * policing_training_areas;
@property (nonatomic, retain) NSString * ied_uxo_report;
@property (nonatomic, retain) NSString * camouflage;
@property (nonatomic, retain) NSString * weather;
@property (nonatomic, retain) NSString * legal;
@property (nonatomic, retain) NSString * medvac_to_hospital_instruction;
@property (nonatomic, retain) NSString * driving_directions;
@property (nonatomic, retain) NSString * environmental_services;
@property (nonatomic, retain) NSString * accidents_damages;
@property (nonatomic, retain) NSString * jmrc_hohenhels_sfc;
@property (nonatomic, retain) NSString * general_info;
@property (nonatomic, retain) Product *productDescription;

@end
