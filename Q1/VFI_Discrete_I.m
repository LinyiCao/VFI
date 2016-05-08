% clc,clear
tic
beta = 0.9;
alpha = 0.5;
delta = 0.5;
rho = 0;
sigma = 1;

Nk = 41;
Nz = 41;

k = linspace(0,20,Nk);
z = linspace(-2,2,Nz);

% normcdf() normal cumulative distribution function  
P = normcdf(-2);
for i = 2 : Nz
    P(i) = normcdf(z(i)) - normcdf(z(i-1));
end

Tol = 1.0E-09;
Erro = 1.0E+9;
MaxIter = 100;
Niter = 0;              % number of iteration
V0 = zeros(Nk,Nz);      % Vn
V1 = zeros(Nk,Nz);      % Vn+1
Nstep = 0;

while(Erro > Tol)
    Niter = Niter + 1;
    for ik = 1 : Nk
        for iz = 1 : Nz
            Vkp = zeros(Nk,1);
            for ikp = 1 : Nk
                sumzp = P .* V0(ikp,:);
                c = exp(z(iz))*k(ik)^alpha + (1-delta)*k(ik) - k(ikp);
                if(c>0)
                    Vkp(ikp) = log(c) + beta * sum(sumzp);
                end
                Nstep = Nstep + 1;
            end
               
            V1(ik,iz) = max(Vkp);
        end
    end
    
    Erro = abs(max(max(V1-V0)));
    
    V0 = V1;
    
    if(Niter>MaxIter)
        disp('Iteration number exceeds the max number')
        break
    end
end
toc
[kk,zz] = meshgrid(k,z);
surf(zz',kk',V1)
xlabel('z')
ylabel('k')
zlabel('V')
Niter
Nstep