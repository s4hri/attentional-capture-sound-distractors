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

function [table, feature_names]  = extractRTs()

    subjects_nr = 19;        
    table = zeros(subjects_nr,4);
    feature_names = {'subject_nr', 'avg_rt_before_audio', 'avg_rt_during_audio', 'avg_rt_after_audio'};

    for subject_i = 1:subjects_nr
                
        table(subject_i, 1) = subject_i;
        [avg_audio] = getRTs(subject_i);
        
        table(subject_i, 2) = avg_audio(1);
        table(subject_i, 3) = avg_audio(2);
        table(subject_i, 4) = avg_audio(3);
    end
    
end