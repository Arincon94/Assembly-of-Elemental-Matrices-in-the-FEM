clc, clearvars, close all;

% Dimensions 
Lx = 3.66; Ly = 0.61; Lz = 0.30;
nelx = 6; nely = 3; nelz = 2;
lx = Lx/nelx; ly = Ly/nely; lz = Lz/nelz;
x = ones(nely,nelx,nelz);

% Mateiral properties 
E = 2.068e11;
nu = 0.3;
rho = 8058;

% Prepare FEA
tic;
nodes = (nelx+1)*(nely+1)*(nelz+1)  + nelx*(nely+1)*(nelz+1) ...
    + nely*(nelx+1)*(nelz+1) + nelz*(nelx+1)*(nely+1);
ndof = 3*nodes;
nele = nelx*nely*nelz;
KE = quadratic_stiffness(E, nu, lx, ly, lz);
ME = quadratic_mass(rho, lx, ly, lz);
edofMat = edofMat_quadratic(nele,nelx,nely,nelz);
iS = reshape(kron(edofMat,ones(60,1))',60*60*nele,1);
jS = reshape(kron(edofMat,ones(1,60))',60*60*nele,1);

% Fixed DOFs
% Since my FEM implements 8-node elements, I couldn't find an efficient way
% to calculate the boundary conditions for the 20-node elements
% First condition
V1 = 1:(2*nely + 1);
VI1 = ((nelx + 1)*(2*nely + 1) + nelx*(nely + 1)+1):((nelx + 1)*(2*nely + 1) + nelx*(nely + 1) + (nely+1));
V2 = ((nelx + 1)*(2*nely + 1) + nelx*(nely + 1) + (nelx+1)*(nely+1) + 1):((nelx + 1)*(2*nely + 1) + nelx*(nely + 1) + (nelx+1)*(nely+1) + (2*nely+1));
VI2 = (2*(nelx + 1)*(2*nely + 1) + 2*nelx*(nely + 1) + (nelx+1)*(nely+1) + 1):(2*(nelx + 1)*(2*nely + 1) + 2*nelx*(nely + 1) + (nelx+1)*(nely+1) + nely + 1);
V3 = (2*(nelx + 1)*(2*nely + 1) + 2*nelx*(nely + 1) + 2*(nelx+1)*(nely+1) + 1):(2*(nelx + 1)*(2*nely + 1) + 2*nelx*(nely + 1) + 2*(nelx+1)*(nely+1) + (2*nely+1));
first_nodes = horzcat(V1, VI1, V2, VI2, V3);
first_DOFs = 3*first_nodes' - 2;

% Second condition
IMed = ceil(length(V1) / 2);
second_nodes = [V1(IMed), V2(IMed), V3(IMed)];
second_DOFs = 3*second_nodes' - 1;

% Third condition
third_DOFs = 3*V2';

fixeddof = [first_DOFs; second_DOFs; third_DOFs];
alldofs = 1:ndof;
freedofs = setdiff(alldofs, fixeddof);

% Global matrices assembly

kK = reshape(KE(:)*x(:)',60*60*nele,1);
kM = reshape(ME(:)*x(:)',60*60*nele,1);
K = sparse(iS,jS,kK); K = (K + K')/2;
M = sparse(iS,jS,kM); M = (M + M')/2;
K(:,fixeddof) = []; K(fixeddof,:) = [];
M(:,fixeddof) = []; M(fixeddof,:) = [];


% Modal analysis
[Phi, Lamb] = eigs(K,M,10,'smallestabs');
omega_q = sqrt(Lamb)/2/pi;
toc;

%% Linear 

% Dimensions 
Lx = 3.66; Ly = 0.61; Lz = 0.30;
nelx = 12; nely = 6; nelz = 3;
lx = Lx/nelx; ly = Ly/nely; lz = Lz/nelz;
x = ones(nely,nelx,nelz);

% Mateiral properties 
E = 2.068e11;
nu = 0.3;
rho = 8058;

% Prepare FEA
tic;
nele = nelx*nely*nelz;
ndof = 3*(nelx+1)*(nely+1)*(nelz+1);
KE = linear_stiffness(E,nu,lx,ly,lz);
ME = linear_mass(rho,lx,ly,lz);
nodegrd = reshape(1:(nely+1)*(nelx+1),nely+1,nelx+1);
nodeids = reshape(nodegrd(1:end-1,1:end-1),nely*nelx,1);
nodeidz = 0:(nely+1)*(nelx+1):(nelz-1)*(nely+1)*(nelx+1);
nodeids = repmat(nodeids,size(nodeidz))+repmat(nodeidz,size(nodeids));
edofVec = 3*nodeids(:)+1;
edofMat = repmat(edofVec,1,24)+ repmat([0 1 2 3*nely + [3 4 5 0 1 2] -3 -2 -1 ...
    3*(nely+1)*(nelx+1)+[0 1 2 3*nely + [3 4 5 0 1 2] -3 -2 -1]],nele,1);
iS = reshape(kron(edofMat,ones(24,1))',24*24*nele,1);
jS = reshape(kron(edofMat,ones(1,24))',24*24*nele,1);

% Support fixed DOFs
% First condition 
[i_f, j_f, k_f] = meshgrid(0,0:nely,0:nelz);
first_id = k_f*(nelx+1)*(nely+1) + i_f*(nely+1)+(nely+1-j_f);
first_nodes = 3*first_id(:)-2;
% Second condition 
clear i_f j_f k_f 
[i_f, j_f, k_f] = meshgrid(0,nely/2,0:nelz);
second_id = k_f*(nelx+1)*(nely+1) + i_f*(nely+1)+(nely+1-j_f);
second_nodes = 3*second_id(:) - 1;
% Third condition 
clear i_f j_f k_f
[i_f, j_f, k_f] = meshgrid(0,0:nely,nelz);
third_id = k_f*(nelx+1)*(nely+1) + i_f*(nely+1)+(nely+1-j_f);
third_nodes = 3*third_id(:);
% Fixed nodes vector
fixeddof = [first_nodes; second_nodes; third_nodes];
alldofs = 1:ndof;
freedofs = setdiff(alldofs, fixeddof);

% Global matrices assembly
kK = reshape(KE(:)*x(:)',24*24*nele,1);
kM = reshape(ME(:)*x(:)',24*24*nele,1);
K = sparse(iS,jS,kK); K = (K + K')/2;
M = sparse(iS,jS,kM); M = (M + M')/2;
K(:,fixeddof) = []; K(fixeddof,:) = [];
M(:,fixeddof) = []; M(fixeddof,:) = [];

% Modal analysis
[Phi, Lamb] = eigs(K,M,10,'smallestabs');
omega_l = sqrt(Lamb)/2/pi;
toc;

%% Table 

Column1 = diag(omega_q);
Column2 = diag(omega_l);

table_omega = table(Column1, Column2, ...
    'VariableNames', {'Quadratic', 'Linear'});

disp(table_omega);

