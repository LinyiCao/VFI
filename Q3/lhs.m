function y = lhs(kp)
global beta alpha delta Nz P z k 
global iz ik 

zi = z(iz);
ki = k(ik);

y1 = 1/(exp(zi) * ki^alpha + (1-delta) * ki - kp);

y2 = 0;

for izp = 1 : Nz
%     Hnkpzp = Hn(kp,izp);
    y2 = y2 + P(izp) * ...
         (exp(z(izp)) * alpha * kp^(alpha-1) + (1-delta)) ...
        /(exp(z(izp)) * kp^alpha + (1-delta)*kp - Hn(kp,izp));
end

y = y1 - beta * y2;

end
