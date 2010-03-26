//
//  MakeCallsController.m
//  DNC
//
//  Created by krader on 3/25/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "MakeCallsController.h"


@implementation MakeCallsController

@synthesize supporters;
@synthesize candidateSelection;

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
	supporters=[[NSMutableArray alloc] initWithObjects:nil];
	NSMutableArray *names = [[NSMutableArray alloc] init];
	[supporters addObject:names];
	NSMutableArray *ids = [[NSMutableArray alloc] init];
	[supporters addObject:ids];
	NSMutableArray *phones = [[NSMutableArray alloc] init];
	[supporters addObject:phones];
	[self xmlParser];
	[table reloadData];
	[names release];
	[ids release];
	[phones release];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
	[table release];
	[supporters release];
	[activityIndicator release];
    [super dealloc];
}

-(void)xmlParser{
	
	NSURL *url = [NSURL URLWithString:@"http://10.101.3.25/~ThoughtWorks/phoneList.xml"];
	parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[[supporters objectAtIndex:0] removeAllObjects];
	[[supporters objectAtIndex:1] removeAllObjects];
	[[supporters objectAtIndex:2] removeAllObjects];
	[parser parse];
	[url release];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	currentElement = [elementName copy];
	
	if ([elementName isEqualToString:@"user"]) {
		name = [[NSMutableString alloc] init];
		phone = [[NSMutableString alloc] init];
		supporterId = [[NSMutableString alloc] init];
		candidateId = [[NSMutableString alloc] init];
		candidateResponse = [[NSMutableString alloc] init];
	}
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:@"name"]) {
		[name appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"phone"]) {
		[phone appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"id"]) {
		[supporterId appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"candidateId"] && [string isEqualToString: self.candidateSelection]) {
		[candidateId appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
	else if ([currentElement isEqualToString:@"response"] && [candidateId length] != 0 && [candidateResponse length] == 0) {
		[candidateResponse appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	if ([elementName isEqualToString:@"user"]) {
		NSLog(candidateResponse);
		if([candidateResponse isEqualToString: @"NotYet"]){
			[[supporters objectAtIndex:0] addObject:name];
			[[supporters objectAtIndex:1] addObject:supporterId];
			[[supporters objectAtIndex:2] addObject:phone];
		}
	}
}


- (NSInteger) numberOfSelectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [[supporters objectAtIndex:0] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.textLabel.text=[[supporters objectAtIndex:0] objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	MakeCallsController *newPage = [[MakeCallsController alloc] initWithNibName:@"PlaceCall" bundle:nil];
	newPage.title=@"Place Call";
	[super.navigationController pushViewController:newPage animated:YES];
	[newPage release];
}



@end