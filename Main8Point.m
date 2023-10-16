clc,clear,close all;

Nodes = csvread('GerasimovNodes.txt');
Elems = csvread('GerasimovMesh.txt');

% %Преобразование данных
% Elems(:,(6:9)) = Elems(:,(5:8));
% Elems(:,5) = Elems(:,9);
% Elems(:,9) = [];

% Для отладки
% Nodes = csvread('Nodes.txt');
% Elems = csvread('Mesh.txt');
Render3D(Nodes,Elems);

Fixed = csvread('GerasimovFixed.txt');
Force = csvread('GerasimovForce.txt');
Force(:,3) = Force(:,3) * 10^12;

%Для отладки
% Fixed = [1 2 3 4];
% Force = [5 0 0 -3 * 10^12;
%          6 0 0 -3 * 10^12;
%          7 0 0 -3 * 10^12;
%          8 0 0 -3 * 10^12];

E = 30000 * 10^9;
%
v = 0.3;

%Матрица упругости
D = (E * (1-v))/((1 + v) * (1 - v)) * ... 
    [1,          v/(1-v), v/(1-v),  0,                 0,                 0;
     v/(1-v),    1,       v/(1-v),  0,                 0,                 0;
     v/(1-v),    v/(1-v), 1,        0,                 0,                 0;
     0,          0,       0,        (1-2*v)/(2*(1/v)), 0,                 0;
     0,          0,       0,        0,                 (1-2*v)/(2*(1/v)), 0;
     0,          0,       0,        0,                 0,                 (1-2*v)/(2*(1/v));];

H = 1;

%Local matrix
KL = LocalMatrixAssemble3D(10, H, D);

%Assembling
KG = zeros(3 * size(Nodes,1));
for k = 1:size(Elems,1)
    for i = 1:8
        for j = 1:8
            shiftUp   = [3 * Elems(k, i) - 2, 3 * Elems(k, i) - 1, 3 * Elems(k,i)];
            shiftLeft = [3 * Elems(k, j) - 2, 3 * Elems(k, j) - 1, 3 * Elems(k,j)];

            KG(shiftUp, shiftLeft)  = KG(shiftUp, shiftLeft) + ...
                KL(3*i-2:3*i, 3*j-2:3*j);
        end
    end
end

%Boundary condition
for i = 1:length(Fixed)
        idx = [Fixed(i) * 3 - 2, Fixed(i) * 3 - 1, Fixed(i)*3];
        KG(idx,:)               = 0;
        KG(:,idx)               = 0;
        KG(idx(1), idx(1))      = 1;
        KG(idx(2), idx(2))      = 1;
        KG(idx(3), idx(3))      = 1;
end

P = zeros(length(KG),1);
for i = 1:size(Force,1)
    idx = Force(i,1);
    P([3*idx-1; 3*idx-1; 3*idx]) = Force(i, [2 3 4]);
end

slv = linsolve(KG,P);

NodesNew = Nodes + reshape(slv, 3, [])';

Render3D(NodesNew,Elems, Fixed, Force);


