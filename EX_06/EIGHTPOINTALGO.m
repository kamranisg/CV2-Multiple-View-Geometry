%% Eight Point Algorithm on 2 Views 
% The implemenation gives us 
%% 
% # *Rotation Matrix (how much camera rotated)*
% # *Translation Matrix (how much camera translated)*
% # *3D points* 

I1=imread('batinria0.tif');
imshow(I1)
subplot()
%% 
% 

I2=imread('batinria1.tif');
imshow(I2)
%%
x1 = [
   10.0000
   92.0000
    8.0000
   92.0000
  289.0000
  354.0000
  289.0000
  353.0000
  ];
y1 = [ 
  232.0000
  230.0000
  334.0000
  333.0000
  230.0000
  278.0000
  340.0000
  332.0000
  ];
x2 = [
  123.0000
  203.0000
  123.0000
  202.0000
  397.0000
  472.0000
  398.0000
  472.0000
  ];
y2 = [ 
  239.0000
  237.0000
  338.0000
  338.0000
  236.0000
  286.0000
  348.0000
  341.0000
  ];
%% 
% # Mark Corressponding Points

imshow(I1)
hold on
plot(x1,y1,'ro','Markersize',10)
figure()
imshow(I2)
hold on
plot(x2,y2,'ro','Markersize',10)
%% 
% 2. Convert from Pixel Coordinates to Image Coordinates 

Pixcord_1=[x1.';y1.';ones(1,8)]
Pixcord_2=[x2.';y2.';ones(1,8)]
K1=[844.310547 0 243.413315;
    0 1202.508301 281.529236;
    0 0 1]
K2=[852.721008 0 252.021805;
    0 1215.657349 288.587189;
    0 0 1]
Imcord_1=K1\Pixcord_1
Imcord_2=K2\Pixcord_2
%% 
% 3. Calucate chi Matrix (Kronecker Product)

a = zeros(9,8);
for i = 1:1:8
    chi(:,i)=kron(Imcord_1(:,i),Imcord_2(:,i));
end
%% 
% 4. Compute SVD of chi, Take 9th column of Vx Unstack to E Matrix (3X3)

[Ux Sx Vx]=svd(chi.');
E=reshape(Vx(:,9),3,3)
%% 
% 5. Compute SVD of E

[U S V]=svd(E);
%% 
% 6. Project E to Essential Space

S_new=[1 0 0; 0 1 0 ; 0 0 0];
Essential_Matrix=U*S_new*V.'
%% 
% 7. Calculate Rotation and Translation Matrices

Rz=[0 -1 0; 1 0 0; 0 0 1];
T1_hat = U*Rz*S_new*U.';
R1 = U*Rz.'*V.';

T2_hat = U*Rz.'*S_new*U.';
R2 = U*Rz*V.';

T1 = [ -T1_hat(2,3); T1_hat(1,3); -T1_hat(1,2) ];
T2 = [ -T2_hat(2,3); T2_hat(1,3); -T2_hat(1,2) ];
%% 
% 8. Structure Reconstruction to find 3D location

M1 = zeros(3*8,8+1);
for i = 1:1:8
    M1(3*i-2:3*i,i)= hat(Imcord_2(:,i)).'*R1*Imcord_1(:,i);
    M1(3*i-2:3*i,9)=hat(Imcord_2(:,i))*T1;
    
end

M2 = zeros(3*8,8+1);
for i = 1:1:8
    M2(3*i-2:3*i,i)= hat(Imcord_2(:,i)).'*R2*Imcord_1(:,i);
    M2(3*i-2:3*i,9)=hat(Imcord_2(:,i))*T2;
    
end


%% 
% 9. Plot 3D location 1

M1 
[EIGVEV,DIAGMAT]=eig(M1.'*M1)
lambda1 = EIGVEV(1:8, 1);
gamma  = EIGVEV(8 + 1, 1);
if gamma < 0
    gamma = -gamma;
    lambda1 = -lambda1;
end
lambda1 = lambda1 / gamma;
X1 = Imcord_1 .* repmat(lambda1', 3, 1);
X2 = R1 * X1 + repmat(T1, 1, 8);

figure
plot3(X1(1,:), X1(2,:), X1(3,:), 'b+')

%% 
% 10. Plot 3D location 2

M2
[EIGVEV2,DIAGMAT2]=eig(M2.'*M2)
lambda2 = EIGVEV2(1:8, 1);
gamma2  = EIGVEV2(8 + 1, 1);
if gamma2 < 0
    gamma2 = -gamma2;
    lambda2 = -lambda2;
end
lambda2 = lambda2 / gamma2;
X12 = Imcord_1 .* repmat(lambda2', 3, 1);
X22 = R2 * X12 + repmat(T2, 1, 8);
%%
figure
plot3(X1(1,:), X1(2,:), X1(3,:), 'b+')
%% 
% 11. Plot camera to Visualise the seen

figure
plot3(X1(1,:), X1(2,:), X1(3,:), 'b+')
hold on
plotCamera('Location',[0 0 0],'Orientation',eye(3),'Opacity',0, 'Size', 0.2, 'Color', [1 0 0])
plotCamera('Location', -R1'*T1,'Orientation',R1,'Opacity',0, 'Size', 0.2, 'Color', [0 1 0])
axis equal
grid on
%%
figure
plot3(X12(1,:), X12(2,:), X12(3,:), 'b+')
hold on
plotCamera('Location',[0 0 0],'Orientation',eye(3),'Opacity',0, 'Size', 0.2, 'Color', [1 0 0])
plotCamera('Location', -R2'*T2,'Orientation',R2,'Opacity',0, 'Size', 0.2, 'Color', [0 1 0])
axis equal
grid on
%% 
% "" Helper Function ""

function hatmat = hat(vec)
    hatmat = [0 -vec(3) vec(2); vec(3) 0 -vec(1); -vec(2) vec(1) 0];
end