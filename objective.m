function val = objective(x)
pos_bits=3;
num_param=5;
sz=length(x)/5;

rows=32;
cols=32;

final_matrix=zeros(rows,rows,rows);

for i = 1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    theta_val=x(num_param*(i-1)+4);% angle from x-axis
    angle_val=x(num_param*(i-1)+5);% angle from y_axis
    pos_x_val=round(pos_x_val*((rows-1)/(2^pos_bits -1)));
    pos_y_val=round(pos_y_val*((rows-1)/(2^pos_bits -1)));
    pos_z_val=round(pos_z_val*((rows-1)/(2^pos_bits -1)));
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