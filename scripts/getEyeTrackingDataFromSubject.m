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

function [data_mat, data_column_name] = getEyeTrackingDataFromSubject(subject_nr)

    audio_stim = [1, 3, 4, 5, 7, 8, 9];
    nst = [1, 2, 3, 10, 4, 5, 6, 7, 8, 11, 12, 9]; % order of presentation of #stimulus
    
    filename_et = num2str(subject_nr.','Full_ET_alldata_sub%02d.mat'); %load ET_alldata_sub and crop the columns of interest
    res_et = load(fullfile('..','filtered_data',filename_et)); 
    
    data_mat = res_et.Full_ET_alldata_sub(:,1:end - 9);
    data_column_name = {'ts' 'ac_x [m/s^2]' 'ac_y [m/s^2]' 'ac_z [m/s^2]' 'gy_x [°/s]' 'gy_y [°/s]' 'gy_z [°/s]' 'gp_x' 'gp_y' 'gp3_x [mm]' 'gp3_y [mm]' 'gp3_z [mm]' 'left_pc_x [mm]' 'left_pc_y [mm]' 'left_pc_z [mm]' 'left_pd [mm]' 'left_gd_x' 'left_gd_y' 'left_gd_z' 'right_pc_x [mm]' 'right_pc_y [mm]' 'right_pc_z [mm]' 'right_pd [mm]' 'right_gd_x' 'right_gd_y' 'right_gd_z'};
    
    % Eye vergence
    for i = 1:size(data_mat, 1)
        DIP = sqrt( (data_mat(i, 20) - data_mat(i, 13))^2 + (data_mat(i, 21) - data_mat(i, 14))^2 + (data_mat(i, 22) - data_mat(i, 15))^2);
        TargetPointDist = sqrt( data_mat(i, 10)^2 + data_mat(i, 11)^2 + data_mat(i, 12)^2);
        
        % Azimuth -- Horizontal component of the eye movement
        data_mat(i, length(data_column_name) + 7) = (180.0/pi)*atan(data_mat(i, 10)/data_mat(i, 12));
        
        % Elevation -- Vertical component of the eye movement
        data_mat(i, length(data_column_name) + 8) = (180.0/pi)*atan(data_mat(i, 11)/( sqrt(data_mat(i, 10)^2 + data_mat(i, 12)^2)));
        
        % Vergence -- Focalised distance 
        data_mat(i, length(data_column_name) + 9) = (180.0/pi)*atan(DIP/(2*TargetPointDist));
       
    end    
          
    % Normalization on the median
    data_mat(:,2:end) = data_mat(:,2:end) - median(data_mat(:,2:end)); 
      
    for i = 1:size(data_mat, 1)        
        data_mat(i, length(data_column_name)+ 1) = norm([data_mat(i, 2) data_mat(i, 3) data_mat(i, 4)]); % mag acc              
        data_mat(i, length(data_column_name)+ 2) = norm([data_mat(i, 5) data_mat(i, 6) data_mat(i, 7)]); % mag gy
        data_mat(i, length(data_column_name)+ 3) = norm([data_mat(i, 8) data_mat(i, 9)]); % mag gp
        data_mat(i, length(data_column_name)+ 4) = norm([data_mat(i, 10) data_mat(i, 11) data_mat(i, 12)]); %mag gp3
        data_mat(i, length(data_column_name)+ 5) = norm([data_mat(i, 13) data_mat(i, 14) data_mat(i, 15)]); %mag left_pc        
        data_mat(i, length(data_column_name)+ 6) = norm([data_mat(i, 20) data_mat(i, 21) data_mat(i, 22)]); %mag right_pc                
    end
    
    %Sum column 'sound_stim' and column 'screen_stim'    
    data_mat(:,length(data_column_name) + 10) = res_et.Full_ET_alldata_sub(:,length(data_column_name) + 1) + res_et.Full_ET_alldata_sub(:,length(data_column_name) + 9);
    
    
    stim = 0;
    j = 0;
    for i = 1:size(data_mat, 1)
        
        if data_mat(i,length(data_column_name) + 10) == 0 && stim ~= 0 %rename the stimuli according to the order of presentation
            stim = 0;
        elseif data_mat(i,length(data_column_name) + 10) == 1
            if stim == 0
                j = j + 1;
                stim = 1;
            end 
            
            if any(audio_stim(1,:) == nst(j)) == 1
                data_mat(i,length(data_column_name) + 10) = nst(j);
            end
        end
        
    end
    
    data_column_name = [data_column_name 'mag_acc' 'mag_gy', 'mag_gp', 'mag_gp3', 'mag_left_pc', 'mag_right_pc', 'azimuth [°]', 'elevation [°]', 'vergence [°]', 'simuli_index'];        
  
    
        
end