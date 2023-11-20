function val = objective(x)
% camera grid 4X4X4
% mesh grid 250X250X250
num_param=5;
sz=length(x)/5;
camera_rows=4;
camera_cols=4;
rows=250;
cols=250;

final_matrix=zeros(rows,rows,rows);
for i = 1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    for j= i+1:sz
        curr_pos_x=x(num_param*(j-1)+1);
        curr_pos_y=x(num_param*(j-1)+2);
        curr_pos_z=x(num_param*(j-1)+3);
        if pos_x_val == curr_pos_x && pos_y_val == curr_pos_y && pos_z_val == curr_pos_z
            val=1000000;
            return;
        end
    end

end
for i = 1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    theta_val=x(num_param*(i-1)+4);% angle from x-axis
    angle_val=x(num_param*(i-1)+5);% angle from y_axis
    pos_x_val=round(pos_x_val*((rows-1)/(camera_rows -1)));
    pos_y_val=round(pos_y_val*((rows-1)/(camera_cols -1)));
    pos_z_val=round(pos_z_val*((rows-1)/(camera_cols -1)));
    if (pos_x_val==0) || (pos_x_val==rows-1) || (pos_y_val==0) || (pos_y_val==cols-1) || (pos_z_val==rows-1)        
        % t=is_inside([pos_x_val,pos_y_val],angle_val,rows,cols);
        
    else
        val = 1000000;
        return;
    end
    t=is_inside([pos_x_val,pos_y_val,pos_z_val],theta_val ,angle_val,rows,cols);
    final_matrix=cat(4,final_matrix,t);

end

final_matrix(:,:,:,1)=[];
sz=size(final_matrix,4);

val=-sum(final_matrix,"all");

end