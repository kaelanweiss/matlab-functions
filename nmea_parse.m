function data = nmea_parse(sentence)
% Function to parse various types of NMEA gps data sentences.
% 
    if ~strcmp(sentence(1),'$')
        data = NaN;
        fprintf('Error: incorrect gps sentence format\n');
        return
    end
    
    tag = sentence(4:6);
    s = sentence(8:end);
    
    switch tag
        case 'RMC'
            data.tag = tag;
            C = strsplit(s,',','CollapseDelimiters',false);
            if length(C)<8
                fprintf('Bad line:\n%s\n',sentence)
                data = [];
                return
            end
            data.time = datenum(strjoin(C([1 9])),'HHMMSS.FFF ddmmyy');
            data.status = C{2};
            if strcmp(data.status,'A') % check if active
                data.lat = nmea2dd(C{3});
                if strcmp(C{4},'S')
                    data.lat = -data.lat;
                end
                data.lon = nmea2dd(C{5});
                if strcmp(C{6},'W')
                    data.lon = -data.lon;
                end
                data.vel = str2double(C{7});
                data.trackAngle = str2double(C{8});
            end
        
        % case 'GGA'
            
            
        otherwise
            %fprintf('NMEA parse not (yet) defined for type: %s\n',tag);
            data = [];
    end

end
