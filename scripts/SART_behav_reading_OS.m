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

clear all
close all

%% Preparation

addpath ..\raw_data\

subjects = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12','13','14','15','16','17','18', '19'};
blocks = {'01','02','03', '04', '05'};
format shortg 
%% import OpenSesame data

s=1;
for s = 1:length(subjects)
    
    loadpath = '..\raw_data\'
    filename = ['Subject', subjects{s}, '\Sub', subjects{s},'_data'];
    filename_sample = [loadpath, filename, '.xlsx'];
    
    % define variables
    correct_keyboard_response = [];
    correct_response = [];
    response_time = [];

    n = num2str(length(xlsread(filename_sample,'behav','Y:Y')) + 1);
    
    if strcmp(subjects{s}, '01') == 1
        [~, ~, raw0_0] = xlsread(filename_sample,'behav',['Y2:Y' n]); % accuracy
        [~, ~, raw0_1] = xlsread(filename_sample,'behav',['AA2:AA' n]); % correct answers
        [~, ~, raw0_2] = xlsread(filename_sample,'behav',['GI2:GI' n]); % RT
        [~, ~, raw0_3] = xlsread(filename_sample,'behav',['LM2:LM' n]); % distractor
        [~, ~, raw0_4] = xlsread(filename_sample,'behav',['LG2:LG' n]); % time trials
    
    else
        [~, ~, raw0_0] = xlsread(filename_sample,'behav',['Y2:Y' n]);
        [~, ~, raw0_1] = xlsread(filename_sample,'behav',['AA2:AA' n]);
        [~, ~, raw0_2] = xlsread(filename_sample,'behav',['GJ2:GJ' n]);
        [~, ~, raw0_3] = xlsread(filename_sample,'behav',['LO2:LO' n]);
        [~, ~, raw0_4] = xlsread(filename_sample,'behav',['LI2:LI' n]);
        
    end
 
    % replace 'None' with 0 and 'space' with 1
    
    for a = 1:length(raw0_1)

        c_answer = raw0_1{a};

        if strcmp(c_answer, 'None') == 1 % None = 3
            raw0_1(a)= {0}; 

        elseif strcmp(c_answer, 'space') == 1 % space = other number
            raw0_1(a) = {1}; 

        %else raw0_1{a} = {NaN}; % Replace non-numeric cells

        end
    end

    % define sound distractors
    newraw0_3 = raw0_3; % new array for distractors
    newraw0_3b = raw0_3; % new array for non distractors
    newraw0_3c = raw0_3; % new array for distractors + 3000
    newraw0_3d = raw0_3; % for visual
    
    for a = 1:length(raw0_3)

        c_answer = newraw0_3{a};

        if strcmp(c_answer, 'sound') == 1
            newraw0_3(a)= {1};
        elseif strcmp(c_answer, 'sound_opendoor') == 1
        newraw0_3(a)= {1}; 
        else newraw0_3(a)= {0}; 
        end
    end
   
   length_sounds = [1000, 1000, 1057, 5848, 1579, 1000, 3572, 1432, 3456];
   sound_beg = find(cell2mat(newraw0_3)); % index of sound beginning
   
   for i = 1:(length(raw0_4)-1) % trial length vector
    trial_length(i) = cell2mat(raw0_4(i+1)) - cell2mat(raw0_4(i));
   end
   
   trial_length(length(raw0_4)) = trial_length(length(raw0_4)-1);
   trial_length = trial_length';
   ntrials = [];
  
   % define ncell = number of trials for each sound
   for sd = 1:length(sound_beg)
       ncell = sound_beg(sd); % index of sound of interest
       mcell = ncell;
       loopcounter = 0;
       tl = trial_length(ncell);
       
       if tl < length_sounds(sd)
           while tl < length_sounds(sd)
               mcell = mcell + 1;
               tl = tl + trial_length(mcell);
               loopcounter = loopcounter + 1;
           end
       else loopcounter = 1;
       end
       
       ntrials = [ntrials, loopcounter];   
   end
   n_trials(s,:) = ntrials;

   % For DISTRACTOR column:
   % create array with index of position of "sound cells"
   
   sd_index = sound_beg;
   for lp = 1:length(ntrials)
       if ntrials(lp) == 1 continue
       else 
           temp = sound_beg(lp)+ 1;
           for x = 1:(ntrials(lp)-1)
               sd_index = [sd_index; temp];
               temp = temp + 1;
           end
       end
   end
   
   sd_index = sort(sd_index); % find sound intervals in order
      
   % insert 1s in all index cells. The other cells = 0
   for in = 1:length(sd_index)
       index = sd_index(in);
       newraw0_3(index) = {1};
   end
   
   %For DISTRACTOR INTERVAL -500 + 3000 column:
    % create array with index of position of "sound cells + 1"
   st = 0; 
   isd_index = sd_index;
   for i = 1:(length(sd_index)-1)
       if sd_index(i+1) ~= (sd_index(i)+1)
           post_stim = 3000;
           n = isd_index(i)+1;
           end_sound = cell2mat(raw0_4(n));
           post_sound = end_sound + post_stim;
           ex = n+1;
           extra_trial = cell2mat(raw0_4(ex));
           while extra_trial <= post_sound 
           extra = n;
           isd_index = [isd_index; extra];
           ex = ex + 1;
           extra_trial = cell2mat(raw0_4(ex));
           n = n+1;
           end
       else continue
       end
   end
   %%% last sound
   ls_index = sd_index(end);
   post_stim = 3000;
   n = ls_index +1;
   end_sound = cell2mat(raw0_4(n));
   post_sound = end_sound + post_stim;
   ex = n+1;
   extra_trial = cell2mat(raw0_4(ex));
   while extra_trial <= post_sound 
   extra = n;
   isd_index = [isd_index; extra];
   ex = ex + 1;
   extra_trial = cell2mat(raw0_4(ex));
   n = n+1;
   end
   %%%%%
   
   isd_index = sort(isd_index); % find sound intervals in order
      
   % insert 1s in all index cells. The other cells = 0
   for in = 1:length(isd_index)
       index = isd_index(in);
       newraw0_3c(index) = {1};
   end
   
   
   %For NON DISTRACTOR column:
    % create array with index of position of "sound cells + 1"
   
   nsd_index = sd_index;
   for i = 1:(length(sd_index)-1)
       if nsd_index(i+1) ~= (nsd_index(i)+1)
           extra = nsd_index(i)+1;
           nsd_index = [nsd_index; extra];
       else continue
       end
   end
   nsd_index = [nsd_index; (nsd_index(end)+1)];
   nsd_index = sort(nsd_index); % find sound intervals in order
      
   % insert 1s in all index cells. The other cells = 0
   for in = 1:length(nsd_index)
       index = nsd_index(in);
       newraw0_3b(index) = {1};
   end
   
    % define VISUAL DISTRACTORS
    
    for a = 1:length(raw0_3)

        c_answer = raw0_3{a};

        if strcmp(c_answer, 'visual') == 1
            newraw0_3(a) = {1}; 
            newraw0_3b(a) = {1};
            newraw0_3b(a+1) = {1};
            newraw0_3d(a) = {1};
        else newraw0_3d(a)= {0};
        end
    end
   
    index_vis = find(cell2mat(newraw0_3d));
    lv = length(index_vis);
   for i = 1:lv
       post_stim = 3000;
       n = index_vis(i)+1;
       end_vis = cell2mat(raw0_4(n));
       post_vis = end_vis + post_stim;
       ex = n+1;
       extra_trial = cell2mat(raw0_4(ex));
        while extra_trial <= post_vis 
           extra = n;
           index_vis = [index_vis; extra];
           ex = ex + 1;
           extra_trial = cell2mat(raw0_4(ex));
           n = n+1;
        end
   end
   
   index_vis = sort(index_vis); % find sound intervals in order
      
   % insert 1s in all index cells. The other cells = 0
   for in = 1:length(index_vis)
       index = index_vis(in);
       newraw0_3c(index) = {1};
   end
    
    
      
    
% define new variables
% names similar to the ones in the .csv file generated by OpenSesame:
% [correct_keyboard_response_exp, correct_response, response_time_keyboard_response_exp]

correct_keyboard_response = raw0_0; % 1 if correct and 0 if incorrect answer (answer subjects' should be giving))
correct_response = raw0_1; % 0 if right answer was None and 1 if correct answer was other number (answer subjects' gave)
response_time = raw0_2; % reaction times
trial_time = cell2mat(raw0_4) - cell2mat(raw0_4(1));
distractor = newraw0_3; % sound/screen
nondistractor = newraw0_3b; % sound/screen + 1
distractor_3000 = newraw0_3c; % sound/screen + 3000
nondistractor_3000 = 1-cell2mat(newraw0_3c);
% create matrix for each subject

OS_alldata_sub = [cell2mat(correct_keyboard_response), cell2mat(correct_response), cell2mat(response_time),trial_time,cell2mat(distractor),cell2mat(nondistractor),cell2mat(distractor_3000),nondistractor_3000];

% save subject data
savename = ['OS_alldata_sub',subjects{s}];
save(['..\filtered_data\', savename], 'OS_alldata_sub');
disp(['OS file subject ',subjects{s},' has been saved'])
    

% Clear temporary variables
clearvars raw0_0 raw0_1 raw0_2 message OS_alldata_sub c_answer correct_keyboard_response correct_response response_time;

end
