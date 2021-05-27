function [global_struct,packets,names] = json_reader(filename, include_global)
%% Loads in JSON file created by neXtC.
%  Once loaded, each row in the arr variable contains 
%  all packet information for each packet.
%  Global data is stored in global_struct in the format of
%  a MATLAB data structure.
%  Packet data is stored in "packets" variable as an array, 
%  and keys from json file are stored in an array matrix under
%  the "names" variable. This contains the names in the first column
%  and their asscociated number of columns of data.

    %%  Open file and parse JSON data
    fid = fopen(filename); 
    raw = fread(fid,inf);
    str = char(raw'); 
    fclose(fid); 
    val = jsondecode(str);  % decoded data

    %% Get global data if any
    if include_global == true
        global_struct = val{1,1}.Global;  % global data structure
    else
        global_struct = [];
    end

    %% Begin data extraction
    packet_struct = val{2,1};  % packet data structure
    packet_ids = fieldnames(packet_struct);
    L = length(packet_ids);  % length of array

    % find width of array here
    fn2 = packet_struct.(packet_ids{1});
    fn2_names = fieldnames(fn2);
    W = 0;  % initialize array width
    names = [];  % initialize array of names
    for j=1:length(fn2_names)
        name = convertCharsToStrings(fn2_names{j});
        len =  length(fn2.(fn2_names{j}));
        names = [names; [name, len]];  % add name and length of data
        W = W + len;
    end
    
    packets = zeros(L, W);  % initialize array

    %% Set data in the array
    for i=1:length(packet_ids)

        fn2 = packet_struct.(packet_ids{i});
        fn2_names = fieldnames(fn2);

        start = 1;
        for j=1:length(fn2_names)
            stop = start + length(fn2.(fn2_names{j}))-1;
            packets(i, start:stop)=fn2.(fn2_names{j}).';
            start = stop+1;
        end
    end
end