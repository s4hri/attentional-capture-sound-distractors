 % Copyright (C) 2017  Lorenza Zaira Curetti, Davide De Tommaso
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>


function [table, feature_names]  = extractETs()

    subjects_nr = 19;
    audio_stim = [1, 3, 4, 5, 7, 8, 9];
  
    features_nr = 34; % nr measures of interest (i.e. acc_x_before, acc_x_stim,...) 
    
    time_window = 1000;
    
    table = zeros(length(audio_stim)*subjects_nr,features_nr*3 + 2);    
    feature_names = {'subject_nr', 'stim_nr'};           

    for subject_i = 1:subjects_nr
        
        k = (1 + (length(audio_stim)*(subject_i-1)));
        table( k:length(audio_stim)*subject_i, 1) = subject_i;
        [rawData, column_names] = getEyeTrackingDataFromSubject(subject_i);
                       
        m = 0;
        for stimulus_i = audio_stim
            
            m = m+1;
            table(k-1+m,2) = stimulus_i;                                   
            submat_stim =  rawData( rawData(:,features_nr + 2) == stimulus_i,:); % rawData sub-matrix of all the samples during the stimulus i
            submat_before_stim = rawData( (rawData(:,1) >= submat_stim(1,1) - time_window - 10 & rawData(:,1) < submat_stim(1,1)), :);
            submat_after_stim = rawData( (rawData(:,1) > submat_stim(end,1) & rawData(:,1) <= submat_stim(end,1) + time_window + 10), :);                                                
            
                  
            j = 2;
            
            for feature_i = 1:features_nr                               
                table(k-1+m,j + 1) = mean( submat_before_stim(:,feature_i + 1 ) );                
                table(k-1+m,j + 2) = mean( submat_stim(:,feature_i+ 1 ) );
                table(k-1+m,j + 3) = mean( submat_after_stim(:,feature_i + 1) );                
                j = j + 3;                
            end
                                                            
        end
        
    end
    
    for feature_i = 1:features_nr
        feature_names = [feature_names strcat(column_names(feature_i + 1),'_before')];
        feature_names = [feature_names strcat(column_names(feature_i + 1),'_during')];
        feature_names = [feature_names strcat(column_names(feature_i + 1),'_after')];
    end        
    
end