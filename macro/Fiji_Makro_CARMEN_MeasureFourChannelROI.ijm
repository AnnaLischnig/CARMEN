// CARMEN_MeasureFourChannelROI
// Author: Anna Lischnig
// Description: 
// This macro processes calcium imaging stacks with four channels.
// It allows manual ROI selection, saves ROI sets, and measures mean intensity
// (and optionally integrated density and area) for each ROI per channel.
// Results are saved as CSVs, one per channel.


inputcalcium = getDirectory("Choose Data Directory ");         // Directory with calcium image stacks
ROI = getDirectory("Choose ROIset Directory");                 // Directory to save ROI sets
Results = getDirectory("Choose Results Directory ");           // Directory to save CSV results

listcalcium = getFileList(inputcalcium);                       // List of image files to process


for (i=0; i<listcalcium.length; i++) {
    showProgress(i+1, listcalcium.length);                     // Show progress bar
    
    // Open image and rename window
    open(inputcalcium+listcalcium[i]); 
 	filenamecalcium = getInfo("image.filename");
 	rename("calcium");
 	
 	// Prepare image for ROI selection
 	roiManager("show all");
	setTool("freehand");
	
	// Optional: use the following line for background subtraction
	//run("Subtract Background...", "rolling=100 stack");
	
	 // Create sum projection for easier ROI placement
	selectWindow("calcium");
	run("Duplicate...", "duplicate");
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	selectWindow("calcium-1");
	run("Z Project...", "projection=[Sum Slices]");
	// ROI can be placed in any of the three images that are open
	
	
	waitForUser("press 'live', select cells, add ROIs [T]"); // Pause for manual ROI selection
	
	roiManager('save', ROI + filenamecalcium +'-ROIset.zip'); // Save the ROIs for record keeping
	
	// Close composite and projection images
	selectWindow("calcium-1");	close();
	selectWindow("SUM_calcium-1");	close();
	
	// Split the stack into individual channels
	selectWindow("calcium");
	run("Split Channels");
	
	// Set measurement type. Here mean gray value
	run("Set Measurements...", "mean display redirect=None decimal=3");
	// Optional: use the following line instead to include area and integrated density
	//run("Set Measurements...", "area mean integrated display redirect=None decimal=3");
	
	// Measure and save intensity values for each channel
	selectWindow("C1-calcium");
	roiManager("multi-measure measure_all one append");
	path = Results+filenamecalcium+"_Intensity FP1.csv";
	selectWindow("Results");
   	saveAs("txt", path);
	run("Clear Results"); 
	
	selectWindow("C2-calcium");
	roiManager("multi-measure measure_all one append");
	path = Results+filenamecalcium+"_Intensity FP2.csv";
	selectWindow("Results");
   	saveAs("txt", path);
	run("Clear Results");
	
	selectWindow("C3-calcium");
	roiManager("multi-measure measure_all one append");
	path = Results+filenamecalcium+"_Intensity FP3.csv";
	selectWindow("Results");
   	saveAs("txt", path);
	run("Clear Results");
	
	selectWindow("C4-calcium");
	roiManager("multi-measure measure_all one append");
	path = Results+filenamecalcium+"_Intensity FP4.csv";
	selectWindow("Results");
   	saveAs("txt", path);
	run("Clear Results");
	
	
	// Clean up
	selectWindow("Results");
	run("Close");
	roiManager("deselect")
	roiManager("Delete");
	selectWindow("C1-calcium");
	close();
	selectWindow("C2-calcium");
	close();
	selectWindow("C3-calcium");
	close();
	selectWindow("C4-calcium");
	close();
	run("Collect Garbage"); // Free memory
}

