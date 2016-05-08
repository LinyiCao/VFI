% clc,clear
global beta alpha delta Nz Nk P z k 
global iz ik Hint

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
H0 = zeros(Nk,Nz);      % Hn
H1 = zeros(Nk,Nz);      % Hn+1
Hint = zeros(Nk,Nz);


while(Erro > Tol)
    Niter = Niter + 1;
    for ik = 2 : Nk
        ik
        for iz = 1 : Nz
            iz
            low = 0.0001;
            upk = exp(z(iz))*k(ik)^alpha+(1-delta)*k(ik) - low;
            Hint(ik,iz) = findHint(0.0001,upk);
            H1(ik,iz) = Hn(k(ik),iz);
        end
    end
    
    Erro = abs(max(max(H1-H0)));
    
    H0 = H1;
    
    if(Niter>MaxIter)
        disp('Iteration number exceeds the max number')
        break
    end
end

toc
 
[kk,zz] = meshgrid(k,z);
surf(zz',kk',H1)
xlabel('z')
ylabel('k')
zlabel('k''')

            