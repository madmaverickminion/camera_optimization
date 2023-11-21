function inside = is_inside(p,th,phi,rows,cols,pages)
% p camera coordinates
% q points coordinates
% th angle from x axis towards y
% phi angle from z axis towards y
% change the unit vec \/
unit_vec=[sin(phi*0.0174533)*cos(th*0.0174533),sin(phi*0.0174533)*sin(th*0.0174533), cos(phi*0.0174533)];
%q_p=q-p;
qi=meshgrid(0:rows-1,0:cols-1);
qj=meshgrid(0:cols-1,0:rows-1)';
temp_k=zeros(cols,rows);
qk_3d=zeros(cols,rows);
qi_3d=meshgrid(0:rows-1,0:cols-1);
qj_3d=meshgrid(0:cols-1,0:rows-1)';

for i = 1:pages-1
    qi_3d=cat(3,qi_3d,qi);
    qj_3d=cat(3,qj_3d,qj);
    temp_k=temp_k+1;
    qk_3d=cat(3,qk_3d,temp_k);
end
% qk_3d
% qi_3d
% qj_3d

q_p_i=qi_3d-p(1);
q_p_j=qj_3d-p(2);
q_p_k=qk_3d-p(3);
cos_theta=cos(30*0.0174533);
mod_q_p= sqrt(q_p_i.^2+q_p_j.^2+q_p_k.^2);
%``lhs=dot(q_p,unit_vec);
lhs=q_p_i*unit_vec(1)+q_p_j*unit_vec(2)+q_p_k*unit_vec(3);
rhs=mod_q_p*cos_theta;
inside=lhs>=rhs;
end