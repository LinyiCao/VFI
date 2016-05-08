function val = findHint(a,b)

fa=lhs(a);
fb=lhs(b);
c=(a+b)/2;
fc=lhs(c);
if (fa*fb>0)
    errordlg('Fa*Fb>0');
end

while ( abs(fc)>1*10^(-4) )
    c=(a+b)/2;
    fc=lhs(c);
    if fb*fc>0
        b=c;
        fb=fc;
    else
        a=c;
        fa=fc;
    end
end

val = c;

end