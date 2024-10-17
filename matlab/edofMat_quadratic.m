function [edofMat] = edofMat_quadratic(nele,nelx,nely,nelz)

% Nodes identification
first_node = [];
ninth_node = [];
last_node = [];

% First node for element 1 to nelxnely
for j = 1:nelx
    for i = 1:nely
        first_node = [first_node; (j-1)*(3*nely + 2) + 2*i + 1];
    end
end

% For element nelxnely + 1 to the last one
fn_mat = zeros(nely*nelx, nelz);
fn_mat(:,1) = first_node;
clear i; 
for i = 1:nelz-1
    fn_mat(:,i+1) = fn_mat(:,1) + i*((nelx+1)*(2*nely+1) + nelx*(nely + 1) + (nelx + 1)*(nely + 1));
end
fn_mat = fn_mat(:);

% Ninth node
clear i j
for k = 1:nelz
    for j = 1:nelx
        for i = 1:nely
            ninth_node = [ninth_node; (k-1)*((nelx+1)*(nely+1) + (nelx+1)*(2*nely+1) + nelx*(nely+1)) + j*(2*nely+1) + (j-1)*(nely+1) + i + 1];
        end
    end
end

% Last node
clear i j k
for k = 1:nelz 
    for j = 1:nelx
        for i = 1:nely
            last_node = [last_node; k*((nelx+1)*(2*nely+1) + nelx*(nely+1)) + (k-1)*(nelx+1)*(nely+1) + i + (j-1)*(nely+1)];
        end
    end
end


% Indices matrix
indices_mat = zeros(nele,20);
clear i
for i = 1:nele
    indices_mat(i,:) = [fn_mat(i) ... 
        fn_mat(i)+(3*nely+2) ...
        fn_mat(i)+3*nely ... 
        fn_mat(i)-2 ... 
        fn_mat(i) + (nely+1)*(nelx+1) + nelx*(nely+1) + (nelx+1)*(2*nely+1) ...
        fn_mat(i) + (nely+1)*(nelx+1) + (nelx+1)*(nely+1) + (nelx+2)*(2*nely+1) ...
        fn_mat(i) + (nely+1)*(nelx+1) + (nelx+1)*(nely+1) + (nelx+2)*(2*nely+1) - 2 ...
        fn_mat(i) + (nely+1)*(nelx+1) + nelx*(nely+1) + (nelx+1)*(2*nely+1) - 2 ... 
        ninth_node(i) ... 
        fn_mat(i)+(3*nely+2) - 1 ...
        ninth_node(i) - 1 ... 
        fn_mat(i) - 1 ... 
        ninth_node(i) + (nelx+1)*(nely+1) + (nelx+1)*(2*nely+1) + nelx*(nely+1) ... 
        fn_mat(i) + (nely+1)*(nelx+1) + (nelx+1)*(nely+1) + (nelx+2)*(2*nely+1) - 1 ... 
        ninth_node(i) + (nelx+1)*(nely+1) + (nelx+1)*(2*nely+1) + nelx*(nely+1) - 1 ... 
        fn_mat(i) + (nely+1)*(nelx+1) + nelx*(nely+1) + (nelx+1)*(2*nely+1) - 1 ... 
        last_node(i) + 1 ... 
        last_node(i) + (nely + 1) + 1 ... 
        last_node(i) + (nely + 1) ... 
        last_node(i)];
end

Node1 = [3*indices_mat(:,1)-2, 3*indices_mat(:,1)-1, 3*indices_mat(:,1)];
Node2 = [3*indices_mat(:,2)-2, 3*indices_mat(:,2)-1, 3*indices_mat(:,2)];
Node3 = [3*indices_mat(:,3)-2, 3*indices_mat(:,3)-1, 3*indices_mat(:,3)];
Node4 = [3*indices_mat(:,4)-2, 3*indices_mat(:,4)-1, 3*indices_mat(:,4)];
Node5 = [3*indices_mat(:,5)-2, 3*indices_mat(:,5)-1, 3*indices_mat(:,5)];
Node6 = [3*indices_mat(:,6)-2, 3*indices_mat(:,6)-1, 3*indices_mat(:,6)];
Node7 = [3*indices_mat(:,7)-2, 3*indices_mat(:,7)-1, 3*indices_mat(:,7)];
Node8 = [3*indices_mat(:,8)-2, 3*indices_mat(:,8)-1, 3*indices_mat(:,8)];
Node9 = [3*indices_mat(:,9)-2, 3*indices_mat(:,9)-1, 3*indices_mat(:,9)];
Node10 = [3*indices_mat(:,10)-2, 3*indices_mat(:,10)-1, 3*indices_mat(:,10)];
Node11 = [3*indices_mat(:,11)-2, 3*indices_mat(:,11)-1, 3*indices_mat(:,11)];
Node12 = [3*indices_mat(:,12)-2, 3*indices_mat(:,12)-1, 3*indices_mat(:,12)];
Node13 = [3*indices_mat(:,13)-2, 3*indices_mat(:,13)-1, 3*indices_mat(:,13)];
Node14 = [3*indices_mat(:,14)-2, 3*indices_mat(:,14)-1, 3*indices_mat(:,14)];
Node15 = [3*indices_mat(:,15)-2, 3*indices_mat(:,15)-1, 3*indices_mat(:,15)];
Node16 = [3*indices_mat(:,16)-2, 3*indices_mat(:,16)-1, 3*indices_mat(:,16)];
Node17 = [3*indices_mat(:,17)-2, 3*indices_mat(:,17)-1, 3*indices_mat(:,17)];
Node18 = [3*indices_mat(:,18)-2, 3*indices_mat(:,18)-1, 3*indices_mat(:,18)];
Node19 = [3*indices_mat(:,19)-2, 3*indices_mat(:,19)-1, 3*indices_mat(:,19)];
Node20 = [3*indices_mat(:,20)-2, 3*indices_mat(:,20)-1, 3*indices_mat(:,20)];

edofMat = horzcat(Node1,Node2,Node3,Node4,Node5,Node6,Node7,Node8,Node9,Node10,Node11,Node12,Node13,Node14,Node15,Node16,...
    Node17,Node18,Node19,Node20);