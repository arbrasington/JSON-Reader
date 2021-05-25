function [global_struct,packets,names] = json_reader(filename, include_global)
%% Loads in JSON file created by neXtC.
%  Once loaded, each row in the arr variable contains 
%  all packet information for each packet.
%  Global data is stored in global_struct in the format of
%  a MATLAB data structure.
%  Packet data is stored in "packets" variable as an array, 
%  and keys from json file are stored in "names" variable.

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
    L = length(packet_ids)+1;  % length of array

    % find width of array here
    fn2 = packet_struct.(packet_ids{1});
    fn2_names = fieldnames(fn2);
    W = 0;
    names = {};
    for j=1:length(fn2_names)
        names(j) = {fn2_names{j}};
        W = W + length(fn2.(fn2_names{j}));
    end

    packets = zeros(L, W);  % initialize array

    %% Set data in the array
    for i=1:length(packet_ids)

        fn2 = packet_struct.(packet_ids{i});
        fn2_names = fieldnames(fn2);

        start = 1;
        for j=1:length(fn2_names)
            stop = start + length(fn2.(fn2_names{j}))-1;
            packets(i+1, start:stop)=fn2.(fn2_names{j}).';
            start = stop+1;
        end
    end
end