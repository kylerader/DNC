//
//  findCandidateController.m
//  DNC
//
//  Created by krader on 3/24/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "findCandidateController.h"
#import "MakeCallsController.h"


@implementation findCandidateController

@synthesize currentLatitude, currentLongitude;
@synthesize candidates;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	candidates=[[NSMutableArray alloc] initWithObjects:nil];
	NSMutableArray *names = [[NSMutableArray alloc] init];
	[candidates addObject:names];
	NSMutableArray *ids = [[NSMutableArray alloc] init];
	[candidates addObject:ids];
	[table reloadData];
	locationController = [[CLController alloc] init];
	locationController.delegate = self;
	[locationController.locationManager startUpdatingLocation];
	[names release];
	[ids release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[locationController release];
	[table release];
	[activityIndicator release];
	[candidates release];
	[name release];
	[candidateId release];
	[latitude release];
	[longitude release];
	[currentLatitude release];
	[currentLongitude release];
	[currentElement release];
    [super dealloc];
}

-(void)xmlParser{
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://10.101.3.65/~ThoughtWorks/candidates.xml"]];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[[candidates objectAtIndex:0] removeAllObjects];
	[[candidates objectAtIndex:1] removeAllObjects];
	[parser parse];
	[table reloadData];
	[parser release];
}

- (void)locationUpdate:(CLLocation *)location {
	
	[self setCurrentLatitude:[NSString stringWithFormat:@"%lf",location.coordinate.latitude]];
	[self setCurrentLongitude:[NSString stringWithFormat:@"%lf",location.coordinate.longitude]];
	[self xmlParser];
	[activityIndicator stopAnimating];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	[currentElement release];
	currentElement = [elementName copy];
	
	if ([elementName isEqualToString:@"user"]) {
		[name release];
		name = [[NSMutableString alloc] init];
		[candidateId release];
		candidateId = [[NSMutableString alloc] init];
		[latitude release];
		latitude = [[NSMutableString alloc] init];
		[longitude release];
		longitude = [[NSMutableString alloc] init];
	}
	//[currentElement autorelease];
}

- (float)findDistance:(float)latitudeCurrent :(float)longitudeCurrent :(float)latitudeCandidate :(float)longitudeCandidate{
	
	return sqrt(pow((latitudeCurrent-latitudeCandidate),2)+pow((longitudeCurrent-longitudeCandidate),2));
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	if ([elementName isEqualToString:@"user"]) {
		
		if([self findDistance:[[self currentLatitude] floatValue] :[[self currentLongitude] floatValue] :[latitude floatValue] :[longitude floatValue]]<1){
			[[candidates objectAtIndex:0] addObject:name];
			[[candidates objectAtIndex:1] addObject:candidateId];
		}
	}
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"Nearby Candidates";
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:@"name"]) {
		[name appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"id"]) {
		[candidateId appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"latitude"]) {
		[latitude appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"longitude"]) {
		[longitude appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
}

- (NSInteger) numberOfSelectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [[candidates objectAtIndex:0] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.textLabel.text=[[candidates objectAtIndex:0] objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	MakeCallsController *newPage = [[MakeCallsController alloc] initWithNibName:@"MakeCalls" bundle:nil];
	newPage.title=@"Make Calls";
	newPage.candidateSelection=[[candidates objectAtIndex:1] objectAtIndex:indexPath.row];
	newPage.candidateName=[[candidates objectAtIndex:0] objectAtIndex:indexPath.row];
	[super.navigationController pushViewController:newPage animated:YES];
	[newPage release];
}

- (void)locationError:(NSError *)error {
	
	NSLog([error description]);
}

@end
