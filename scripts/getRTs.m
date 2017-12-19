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

function [avg_rt_audio] = getRTs(subject_nr)

    audio_stimuli = [1 3 4 5 7 8 9];    
    nst = [1, 2, 3, 10, 4, 5, 6, 7, 8, 11, 12, 9];
       
    filename_os = num2str(subject_nr.','OS_alldata_sub%02d.mat'); %load OS_alldata_sub and crop the columns of interest
    res_os = load(fullfile('..','filtered_data',filename_os));
        
    nr_trials_before_stimuli = 1;
    nr_trials_during_stimuli = 1;
    nr_trials_after_stimuli = 1;    
                
    data_os = res_os.OS_alldata_sub(:,1:5) 
    stim = 0;
    j = 0;
    for i = 1:size(data_os, 1)
        
        if data_os(i,5) == 0 && stim ~= 0 %rename the stimuli according to the order of presentation
            stim = 0;
        elseif data_os(i,5) == 1
            if stim == 0
                j = j + 1;
                stim = 1;
            end            
            data_os(i,5) = nst(j);                        
        end 
        
        if data_os(i,1)*data_os(i,2) == 1
            filtered_data_os(i,:) = data_os(i,:);
        end
        
        
    end 
    
    filtered_data_os( ~any(filtered_data_os,2), : ) = [];
    
    avg_rt_audio = zeros(3, 1);
    

    
    for i = 1:size(audio_stimuli,2)        
        first_stimuli_index = find(filtered_data_os(:,5) == audio_stimuli(i),1,'first');
        last_stimuli_index = find(filtered_data_os(:,5) == audio_stimuli(i),1,'last');                
        
        rt_audio_before(i) = mean(filtered_data_os(first_stimuli_index-nr_trials_before_stimuli:first_stimuli_index-1, 3));
        rt_audio_during(i) = mean(filtered_data_os(first_stimuli_index:first_stimuli_index + nr_trials_during_stimuli, 3));
        rt_audio_after(i) = mean(filtered_data_os(last_stimuli_index+1:last_stimuli_index + nr_trials_after_stimuli, 3));                   
    end
    
    avg_rt_audio(1,1) = mean(rt_audio_before(~isnan(rt_audio_before)));
    avg_rt_audio(2,1) = mean(rt_audio_during(~isnan(rt_audio_during)));
    avg_rt_audio(3,1) = mean(rt_audio_after(~isnan(rt_audio_after)));
        
    clear first_stimuli_index;
    clear last_stimuli_index;
          
end