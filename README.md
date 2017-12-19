### Cross-modal attentional capture with naturalistic sound distractors ###


RTs_PDs_Attentional_Capture.xlsx is the file containing data used for the analyses.
This file was extracted from raw data with Matlab, according to the following procedure:

A. Preparation (Manual):
1. For each subject, raw data recorded during the experiment were merged into a single .xlsx file. Then, these files were moved to a different folder, named after the number of the specific subject ;
2. A folder named "raw_data" was created, and all subjects' folders were moved inside of it;

B. Extraction (Matlab):
1. Data of interest (eye tracker data and reaction times) were imported in Matlab separately; specifically, "SART_behav_reading_ET.m" (for eye tracking data) and "SART_behav_reading_OS.m" (for OpenSesame data) allowed us to transform "raw_data" from .xls to .m format. New matrices were saved into the folder "filtered data";
2. For each subject, data were centered on the respective median value, using "SART_behav_reading_ET.m" and ""SART_behav_reading_ET.m". These scripts recall respectively "getRTs.m" and "extractRTs.m" and "getEyeTrackingDataFromSubjects.m" and "extractETs.m".. After centering procedure, these scripts saved data in two separate matrices: "ETs.mat" and "RTs.mat". 

How to read "ETs.mat"
- Column 1: Number of the Subject
- Column 2: Stimulus Number
- Column 45: Data of Left Pupil Diameter Before the distractor onset
- Column 46: Data of Left Pupil Diameter During the distractor presentation
- Column 47: Data of Left Pupil Diameter After the distractor offset
- Column 66: Data of Right Pupil Diameter Before the distractor onset
- Column 67: Data of Right Pupil Diameter During the distractor presentation
- Column 68: Data of Right Pupil Diameter After the distractor offset


How to read "RTs.mat"
- Column 1: Number of the Subject
- Column 2: Data of Reaction Time one trial Before the distractor onset
- Column 3: Data of Reaction Time one trial During the distractor presentation
- Column 4: Data of Reaction Time one trial After the distractor offset

