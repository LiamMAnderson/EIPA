% Liam Anderson
% 100941879
% ELEC 4700 Feb 7 2020


nx = 50;
ny = 50;
n = ny*nx; % 50x50 = 2500

x = linspace(0,1,nx); % vector from 0 to 1 with 50 entries
y = linspace(0,1,ny); % vector from 0 to 1 with 50 entries
dx2 = 1;
dy2 = 1;



G = sparse(n,n);




% populate spatial matrix G
for i=1:nx
    for j=1:ny
        n = j + (i-1)*ny; % MAPPING diagonals (relates each node to neighboring nodes)
        % BOUNDARY CONDITIONS
        if (i == 1 || i == nx || j == 1 || j == ny)
            G(n,n) = 1;
        else
            G(n,n) = -4/dx2; % middle value DIAGONAL
            G(n,n-1) = 1/dx2; % left side DIAGONAL
            G(n,n+1) = 1/dx2; % right side DIAGONAL
            G(n,n-ny) = 1/dy2; % first value DIAGONAL
            G(n,n+ny) = 1/dy2; % last value DIAGONAL
            
        end
        
    end
    
end


for (i=10:20)
    for (j=10:20)
        n = j + (i-1)*ny;
        G(n,n) = -2;
    end
end


spy(G);

[E,D] = eigs(G,9,'SM');

E_matrix = zeros(nx,ny,9); % set up reshaped matrix


for n=1:9
    E_matrix(:,:,n) = reshape(E(:,n),nx,ny);
    hold on;
    figure(1);
    subplot(3,3,n)
    surf(E_matrix(:,:,n));
end


            