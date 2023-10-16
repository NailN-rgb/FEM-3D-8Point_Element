function K = LocalMatrixAssemble3D(N,H,D)
    a = -1;
    b = 1;
    h = (b-a)/N;
    
    x = linspace(a, b, N);
    y = linspace(a, b, N);
    z = linspace(a, b, N);

    int = 0;
    for i = 1:N
        for j = 1:N
            for k = 1:N
                Bloc = DifferintalMatrix(x(i),y(j),z(k));
                int = int + (Bloc'*D*Bloc)*h^3;
            end
        end
    end
    K = int;
    %KL = H * int; 

end