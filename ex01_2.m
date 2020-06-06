%% 
% 2. Basic Operations
% 
% a) Define the matrices.

A=[2,2,0;0,8,3]
b=[5;15]
B=A
%% 
% b) Replace an element of Matrix A.

A(1,2)=4
%% 
% c) Computation

c=0
for i = -4:4:4
    c=c+i*A.'*b
end
disp(c)
%% 
% d) Comparison

Element_wise=A.*B % Corresponds to element wise Multiplication Out = 2x3 Matrix
Matrix_Mult=A.'*B % Corresponds to Matrix Multiplication Out = 3x3 Matrix