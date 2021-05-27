function [data] = get_data_by_name(array,names,getter)
%% GET DATA FROM PARSED JSON ARRAY
%   Use this function to get data from the parsed JSON array,
%   by passing in the name of the data you want. The "array" variable
%   should be the parsed array, "names" should be the names array
%   returned from the JSON parser, and "getter" should be the name to 
%   get from the array.

labels = names(:,1);  % list of labels
idxs = str2double(names(:,2));  % indexs from each label

if any(labels == getter) == 0
    error('Invalid name, could not find key')  % can't find the key
end

idx = find(labels == getter, 1);  % index of getter

% get and return data from array
if idx == 1
    data = array(:,1:idxs(idx));
else
    start = sum(idxs(1:idx-1))+1;
    stop = idxs(idx) - 1 + start;
    
    data = array(:,start:stop);
end

end