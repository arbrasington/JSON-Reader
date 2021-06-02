% filename = 'C:\Users\arbra\OneDrive\Documents\GitHub\neXtC_ui\neXtC\assets\temp\data.json';
% [global_struct, packets, names] = json_reader(filename, true);


close all

coords = get_data_by_name(packets, names, 'Coordinates');  % coordinates
data = get_data_by_name(packets, names, 'Steering');
laps = get_data_by_name(packets, names, 'Overlaps');
gaps = get_data_by_name(packets, names, 'Gaps');
stacking = get_data_by_name(packets, names, 'LocalStacking');

laps(laps>0)=1;
gaps(gaps>0)=-1;

t = stacking+laps+gaps;
t = sum(t,2);
t(t<0)=0;

x = coords(:,1);
y = coords(:,2);
z = coords(:,3);

colormap jet
scatter(x,y,25,t,'filled')
cb = colorbar;
cb.Title.String = 'Ply Count';

if min(x) >= 0
    xlim([0 max(x)])
end
% 
if min(y) >= 0
    ylim([0, max(y)])
end
% 
% if min(z) >= 0
%     zlim([0, max(z)])
% end