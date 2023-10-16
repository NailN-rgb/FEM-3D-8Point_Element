function B = DifferintalMatrix(x, y, z)

B = zeros(6,24);

% Form Function = 1/8 (1 + xi * x)(1 + yi * i)(1 + zi * z)

Points = [-1,-1,-1;
           1,-1,-1;
           1, 1,-1;
          -1, 1,-1;
          -1,-1, 1;
           1,-1, 1; 
           1, 1, 1;
          -1, 1, 1];

DifFormFunc = @(difi, dif, mui, mu, ksii, ksi) 1/8 * sign(difi * dif) * (1 + mui * mu) * (1 + ksii * ksi);

for i = 1:8
    Nx = DifFormFunc(Points(i,1), x, Points(i,2), y, Points(i,3), z);
    Ny = DifFormFunc(Points(i,2), y, Points(i,1), x, Points(i,3), z);
    Nz = DifFormFunc(Points(i,3), z, Points(i,1), x, Points(i,2), y);

    B(1, 3 * i - 2) = Nx;
    B(4, 3 * i - 2) = Ny;
    B(6, 3 * i - 2) = Nz;
    B(2, 3 * i - 1) = Ny;
    B(4, 3 * i - 1) = Nx;
    B(5, 3 * i - 1) = Nz;
    B(3, 3 * i) = Nz;
    B(5, 3 * i) = Ny;
    B(6, 3 * i) = Nx;

end

end