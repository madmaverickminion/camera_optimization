rng default % For reproducibility
% make changes for 52 * 52 * 25 
% 24 cameras 
% camera placement only on two planes
    % 2 or 3
    % 1 or 3 
fun = @objective;
cameras=5;
lb=repmat([0,0,1,0,0],1,cameras);
ub=repmat([6,6,3,360,360],1,cameras);
options = optimoptions('ga','PlotFcn', @gaplotbestf, 'FunctionTolerance',1e-7);
x = ga(fun,5*cameras,[],[],[],[],lb,ub,[],1:5*cameras, options);

%% 
x=[ 0  ,   0 ,    3  , 216  , 225, 0  ,   0  ,   0 ,  144  , 225 ];
sz=length(x)/5;
num_param=5;
camera_rows=4;
rows=52;
cols=52;
pages=25;
final_matrix=zeros(cols,rows,pages);
for i =1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    theta_val=x(num_param*(i-1)+4);% angle from x-axis
    angle_val=x(num_param*(i-1)+5);% angle from y_axis
    pos_x_val=round(pos_x_val*((rows-1)/(camera_rows -1)));
    pos_y_val=round(pos_y_val*((rows-1)/(camera_rows -1)));
    pos_z_val=round(pos_z_val*((rows-1)/(camera_rows -1)));
    t=is_inside([pos_x_val,pos_y_val,pos_z_val],theta_val ,angle_val,rows,cols);
    final_matrix=cat(4,final_matrix,t);
end
final_matrix(:,:,:,1)=[];
plot_matrix=zeros(rows,rows,rows);
sz=size(final_matrix);
for i=1:sz(4)
    plot_matrix=plot_matrix+final_matrix(:,:,:,i);
    sum(plot_matrix,"all")
end
sz=size(plot_matrix);
matrix_final=[0,0,0,0];
for i=1:sz(1)
    for j=1:sz(2)
        for k=1:sz(3)
            matrix_final=[matrix_final;[i-1,j-1,k-1,plot_matrix(i,j,k)]];
        end
    end
end
matrix_final(1,:)=[];

scatter3(matrix_final(:,1),matrix_final(:,2),matrix_final(:,3),40,matrix_final(:,4),'filled');

cb = colorbar;

% for cuboid keep the camera grid same. only change the finer grid dimension in z
% direction