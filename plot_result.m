function flag= plot_result(x,camera_rows,camera_cols,camera_pages,rows,cols,pages)
num_param=5;
sz=length(x)/5;
final_matrix=zeros(cols,rows,pages);
matrix_final=[0,0,0,0];
for i =1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    theta_val=x(num_param*(i-1)+4);% angle from x-axis
    angle_val=x(num_param*(i-1)+5);% angle from y_axis
    pos_x_val=round(pos_x_val*((rows-1)/(camera_rows -1)));
    pos_y_val=round(pos_y_val*((cols-1)/(camera_cols-1)));
    pos_z_val=round(pos_z_val*((pages-1)/(camera_pages-1)));
    t=is_inside([pos_x_val,pos_y_val,pos_z_val],theta_val ,angle_val,rows,cols,pages);
    
    final_matrix=cat(4,final_matrix,t);
end

final_matrix(:,:,:,1)=[];
plot_matrix=zeros(cols,rows,pages);
sz=size(final_matrix);
for i=1:sz(4)
    plot_matrix=plot_matrix+final_matrix(:,:,:,i);
    % sum(plot_matrix,"all")
end
sz=size(plot_matrix);

for i=1:sz(1)
    for j=1:sz(2)
        for k=1:sz(3)
            matrix_final=[matrix_final;[i-1,j-1,k-1,plot_matrix(j,i,k)]];
        end
    end
end
sz=length(x)/5;
for i =1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    pos_x_val=round(pos_x_val*((rows-1)/(camera_rows -1)));
    pos_y_val=round(pos_y_val*((cols-1)/(camera_cols-1)));
    pos_z_val=round(pos_z_val*((pages-1)/(camera_pages-1)));
    matrix_final=[matrix_final;[pos_x_val,pos_y_val,pos_z_val,20]]
    pos_x_val
    pos_y_val
    pos_z_val
end
matrix_final(1,:)=[];

scatter3([matrix_final(:,1)],matrix_final(:,2),matrix_final(:,3),40,matrix_final(:,4),'filled');
cb=colorbar;
flag=1;
end
