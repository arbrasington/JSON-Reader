% [global_struct, packets, names] = json_reader('data2.json', true);


close all

coords = get_data_by_name(packets, names, 'Coordinates');  % coordinates
data = get_data_by_name(packets, names, 'Overlaps');  % overlap data

x = coords(:,1);
y = coords(:,2);
z = coords(:,3);

colormap jet
scatter3(x,y,z,10,data(:,1))
colorbar

if min(x) >= 0
    xlim([0 max(x)])
end

if min(y) >= 0
    ylim([0, max(y)])
end

if min(z) >= 0
    zlim([0, max(z)])
end