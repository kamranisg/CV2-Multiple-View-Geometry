%% *2. THE MOORE-PENROSE PSEUDO-INVERSE EXERCISE*
%% *Creating Data.*
%% *A) Creating a random Matrix D of size mx4.*

m=4
D =randi([1,5],[m,4])
D(:,4) = 4*D(:,1) -3*D(:,2) +2*D(:,3) -1
%% B) Introducing Small additive errors in data.

eps = 1.e-4
D=D*eps
%% 2. Find the coefficients of x solving Dx = b.
%% A) Compute the Singular Value Decomposition.

[U,S,V]=svd(D)
%% B) Compute Moore-Penrose pseudo-inverse using A) and find x

for i =1:1:3
    if(S(i,i)>0)
        S(i,i)=1/S(i,i);
    end
end
S=S.'
A_dagger=V*S*U.'
b=[1;1;1;1]
x1=A_dagger*b
%% C) Compute using Matlab built-in function

A_Dagger_Matlab=pinv(D)
x2=A_Dagger_Matlab*b
m1=3
D2 =randi([1,5],[m1,4])
D2(:,4) = 4*D2(:,1) -3*D2(:,2) +2*D2(:,3) -1
eps = 1.e-4
D2=D2*eps
[U2,S2,V2]=svd(D2)
for i =1:1:3
    if(S2(i,i)>0)
        S2(i,i)=1/S2(i,i);
    end
end
S2=S2.'
A_D=V2*S2*U2.'
b2=[1;1;1]
X2=A_D*b2 % VALUE OF X solved manually
A_D_M=pinv(D2)
X2_M=A_D_M*b2 % VALUE OF X on applying pinv()
%%
null(D2)
%% 
% *Final Outcome :=* *Since m=3 we have infinitely many solutions thus we get 
% a non-empty null vector as above. The set of all possible solutions are X2_M 
% + lamda*null(D2).*