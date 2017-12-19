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

clear all;
close all;

%% Preparation

addpath ..\raw_data\

subjects = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12','13', '14', '15', '16', '17', '18', '19'};
blocks = {'01','02','03', '04', '05'};
format shortg 


%% import Eye-Tracker data

s = 1;
for s = 1:length(subjects)
 
% define variables  
time = [];
acc_x = [];
acc_y = [];
acc_z = [];
gyro_x = [];
gyro_y = [];
gyro_z = [];
gp_x = [];
gp_y = [];
gp3_x = [];
gp3_y = [];
gp3_z = [];
left_pc_x = [];
left_pc_y = [];
left_pc_z = [];
left_pd = [];
left_gd_x = [];
left_gd_y = [];
left_gd_z = [];
right_pc_x = [];
right_pc_y = [];
right_pc_z = [];
right_pd = [];
right_gd_x = [];
right_gd_y = [];
right_gd_z = [];
sound = [];
screen = [];

loadpath = '..\raw_data\'
filename = ['Subject', subjects{s}, '\Sub', subjects{s},'_data'];
filename_sample = [loadpath, filename, '.xlsx'];

% append blocks

for e = 1:length(blocks)
    
    n = num2str(length(xlsread(filename_sample,blocks{e},'A:A'))+1);
    
    [~, ~, raw0_1] = xlsread(filename_sample,blocks{e},['B2:B' n]); % acc_x
    [~, ~, raw0_2] = xlsread(filename_sample,blocks{e},['C2:C' n]); % acc_y
    [~, ~, raw0_3] = xlsread(filename_sample,blocks{e},['D2:D' n]); % acc_z
    [~, ~, raw0_4] = xlsread(filename_sample,blocks{e},['E2:E' n]); % gyro_x
    [~, ~, raw0_5] = xlsread(filename_sample,blocks{e},['F2:F' n]); % gyro_y
    [~, ~, raw0_6] = xlsread(filename_sample,blocks{e},['G2:G' n]); % gyro_z
    [~, ~, raw0_7] = xlsread(filename_sample,blocks{e},['H2:H' n]); % gp_x
    [~, ~, raw0_8] = xlsread(filename_sample,blocks{e},['I2:I' n]); % gp_y
    [~, ~, raw0_9] = xlsread(filename_sample,blocks{e},['J2:J' n]); % gp3_x
    [~, ~, raw0_10] = xlsread(filename_sample,blocks{e},['K2:K' n]); % gp3_y
    [~, ~, raw0_11] = xlsread(filename_sample,blocks{e},['L2:L' n]); % gp3_z
    [~, ~, raw0_12] = xlsread(filename_sample,blocks{e},['M2:M' n]); % left_pc_x
    [~, ~, raw0_13] = xlsread(filename_sample,blocks{e},['N2:N' n]); % left_pc_Y
    [~, ~, raw0_14] = xlsread(filename_sample,blocks{e},['O2:O' n]); % left_pc_Z
    [~, ~, raw0_15] = xlsread(filename_sample,blocks{e},['P2:P' n]); % left_pd
    [~, ~, raw0_16] = xlsread(filename_sample,blocks{e},['Q2:Q' n]); % left_gd_x
    [~, ~, raw0_17] = xlsread(filename_sample,blocks{e},['R2:R' n]); % left_gd_y
    [~, ~, raw0_18] = xlsread(filename_sample,blocks{e},['S2:S' n]); % left_gd_z
    [~, ~, raw0_19] = xlsread(filename_sample,blocks{e},['T2:T' n]); % right_pc_x
    [~, ~, raw0_20] = xlsread(filename_sample,blocks{e},['U2:U' n]); % right_pc_Y
    [~, ~, raw0_21] = xlsread(filename_sample,blocks{e},['V2:V' n]); % right_pc_Z
    [~, ~, raw0_22] = xlsread(filename_sample,blocks{e},['W2:W' n]); % right_pd
    [~, ~, raw0_23] = xlsread(filename_sample,blocks{e},['X2:X' n]); % right_gd_x
    [~, ~, raw0_24] = xlsread(filename_sample,blocks{e},['Y2:Y' n]); % right_gd_y
    [~, ~, raw0_25] = xlsread(filename_sample,blocks{e},['Z2:Z' n]); % right_gd_z
    [~, ~, raw0_26] = xlsread(filename_sample,blocks{e},['AA2:AA' n]); % sound
    [~, ~, raw0_27] = xlsread(filename_sample,blocks{e},['AB2:AB' n]); % screen
    
    acc_x = [acc_x; raw0_1];
    acc_y = [acc_y; raw0_2];
    acc_z = [acc_z; raw0_3];
    gyro_x = [gyro_x; raw0_4];
    gyro_y = [gyro_y; raw0_5];
    gyro_z = [gyro_z; raw0_6];  
    gp_x = [gp_x; raw0_7];
    gp_y = [gp_y; raw0_8];
    gp3_x = [gp3_x; raw0_9];
    gp3_y = [gp3_y; raw0_10];
    gp3_z = [gp3_z; raw0_11];
    left_pc_x = [left_pc_x; raw0_12];
    left_pc_y = [left_pc_y; raw0_13];
    left_pc_z = [left_pc_z; raw0_14];
    left_pd = [left_pd; raw0_15];
    left_gd_x = [left_gd_x; raw0_16];
    left_gd_y = [left_gd_y; raw0_17];
    left_gd_z = [left_gd_z; raw0_18];
    right_pc_x = [right_pc_x; raw0_19];
    right_pc_y = [right_pc_y; raw0_20];
    right_pc_z = [right_pc_z; raw0_21];
    right_pd = [right_pd; raw0_22];
    right_gd_x = [right_gd_x; raw0_23];
    right_gd_y = [right_gd_y; raw0_24];
    right_gd_z = [right_gd_z; raw0_25];
    sound = [sound; raw0_26];
    screen = [screen; raw0_27];
  
    
    clearvars n raw0_1 raw0_2 raw0_3 raw0_4 raw0_5 raw0_6 raw0_7 raw0_7 raw0_8 raw0_9 raw0_10 raw0_11 raw0_12 raw0_13 raw0_14 raw0_15 raw0_16 raw0_17 raw0_18 raw0_19 raw0_20 raw0_21 raw0_22 raw0_23 raw0_24 raw0_25 raw0_26 raw0_27;

end

% define time
time = [0 + (0:length(acc_x)-1)*10]'; % in ms

% replace non-numeric values

for a = 1:length(sound)
    
    c_value = sound{a};
    d_value = screen{a};

    if strcmp(c_value, ' None') == 1 && strcmp(d_value, ' None ') == 1
        sound(a) = {0};
        screen(a) = {0};
    
    elseif strcmp(c_value, ' None') == 1
        sound(a) = {0};
    
    elseif strcmp(d_value, ' None ') == 1
        screen(a) = {0};

    elseif strcmp(d_value, ' RED ') == 1
        screen(a) = {1}; 
    
    elseif strcmp(d_value, ' BLUE ') == 1
        screen(a) = {1}; 
    
    elseif d_value == 10
        screen(a) = {1};
        
    elseif d_value == 20
        screen(a) = {1};
    
    end

end

% define sound length
% sounds are:
% {'knock_right','metal_bar_JP','phone_rightback','venetian_blind_right','interference_left_long','glass_right','steps_door'}
length_sounds = [1000, 1057, 5848, 1579, 3572, 1432, 3456]; % in ms
allsounds = zeros(length(sound),1); % define vector that will have 1s when any sound is present and 0s otherwise

for num = 1:length(length_sounds)
    
    newsound = zeros(length(sound), 1);
    
    % find sound starting point and set that cell to 1 and the following
    % ones to 0
    for l = 2:length(newsound)
        
        e_value = sound{l};
        f_value = sound{l-1};
        
        if e_value == num && f_value ~= num
            newsound(l) = 1;
        end
    end
    
   ncells = round(length_sounds(num)/10); % time stamp every 10ms (defines number of cells in which the sound is present)
   index = find(newsound); % returns array with index of non zero elements
   
   for in = 1:length(index)
       newsound(index(in):index(in)+ncells) = 1; % for the length of the sound each cell = 1
   end
   
   % save new sound in a column of a new 'sound matrix' - at the end one
   % column per sound
   newsounds(:,num) = newsound; % one column per sound
   allsounds = allsounds + newsound; % one column with all sounds
   clear newsound
   
end


    % Create matrix with a different measure per row (like the excel sheet)

    Full_ET_alldata_sub = [time, cell2mat(acc_x), cell2mat(acc_y), cell2mat(acc_z), cell2mat(gyro_x), cell2mat(gyro_y), cell2mat(gyro_z), cell2mat(gp_x), cell2mat(gp_y), cell2mat(gp3_x), cell2mat(gp3_y), cell2mat(gp3_z), cell2mat(left_pc_x), cell2mat(left_pc_y), cell2mat(left_pc_z),cell2mat(left_pd), cell2mat(left_gd_x), cell2mat(left_gd_y), cell2mat(left_gd_z), cell2mat(right_pc_x), cell2mat(right_pc_y), cell2mat(right_pc_z),cell2mat(right_pd), cell2mat(right_gd_x), cell2mat(right_gd_y), cell2mat(right_gd_z), allsounds, newsounds, cell2mat(screen)];    

    % save subject data

    savename = ['Full_ET_alldata_sub',subjects{s}];
    save(['..\filtered_data\', savename],'Full_ET_alldata_sub');
    disp(['ET file subject ',subjects{s},' has been saved'])    

    % Clear temporary variables
    clear c_value d_value ET_alldata_sub newsounds message time acc_x acc_y acc_z gyro_x gyro_y gyro_z gp_x	gp_y gp3_x gp3_y gp3_z left_pc_x left_pc_y left_pc_z left_pd left_gd_x left_gd_y left_gd_z right_pc_x right_pc_y right_pc_z right_pd right_gd_x	right_gd_y right_gd_z sound screen allsounds;
        
end