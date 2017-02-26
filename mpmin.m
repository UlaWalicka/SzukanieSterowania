function J=mpmin(X)
global Lo Mo T z

if (X(1) < 0)
    J=1e10;
else
    Ls=[X(1)*z X(1)];
    Ms=[X(2) 1];
    [Lc, Mc]=series(Ls, Ms, Lo, Mo);
    %Lc=conv(Ls, Lo);
    %Mc=conv(Ms, Mo);
    [Lz, Mz]=cloop(Lc, Mc, -1);
    if (max(real(roots(Mz)))>=0)
            J=1e10;
        else
            [Y]=step(Lz, Mz, T);
            J=sum(abs(1-Y));

            [Lu, Mu]=feedback(Ls, Ms, Lo, Mo, -1);
            [U]=step(Lu, Mu, T);
            Umax = max(U);
            Umin= min(U);
        if (Umax>10) || (Umin<-10)
            J=J+100000*U;
        end;

    end;
end;
end