rng default % For reproducibility
fun = @objective;
lb=[0,0,0,0,0,0,0,0,0,0];
ub=[7,7,7,360,360,7,7,7,360,360];
options = optimoptions('ga','PlotFcn', @gaplotbestf, 'FunctionTolerance',1e-7);
x = ga(fun,10,[],[],[],[],lb,ub,[],[1,2,3,4,5,6,7,8,9,10], options);
%%
sz=length(x)/5;
num_param=5;
pos_bits=3;
rows=32;
cols=32;
final_matrix=zeros(rows,rows,rows);
for i =1:sz
    pos_x_val=x(num_param*(i-1)+1);
    pos_y_val=x(num_param*(i-1)+2);
    pos_z_val=x(num_param*(i-1)+3);
    theta_val=x(num_param*(i-1)+4);% angle from x-axis
    angle_val=x(num_param*(i-1)+5);% angle from y_axis
    pos_x_val=round(pos_x_val*((rows-1)/(2^pos_bits -1)));
    pos_y_val=round(pos_y_val*((rows-1)/(2^pos_bits -1)));
    pos_z_val=round(pos_z_val*((rows-1)/(2^pos_bits -1)));
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
plot_matrix;
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
scatter3([31;31],[31;0],[31;31],40,[10;10],'filled');

cb = colorbar;

