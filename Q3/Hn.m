function val = Hn(kp,iz)
global Nk k 
global Hint

if(kp<k(1))
    val = 0;
    
    
    return
end

if(kp>=k(end))
    val = Hint(Nk,iz);
    
    
    return
end


for i = 1 : Nk-1
    ik = i;
    if( kp>=k(i) && kp<k(i+1) )
        ik = i;
        break
    end
end
k0 = k(ik);
k1 = k(ik+1);
val = (Hint(ik+1,iz)-Hint(ik,iz))*(kp-k0)/(k1-k0) + Hint(ik,iz);

end