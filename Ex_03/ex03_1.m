%% *1. Homogenous Transformation Matrices*
% 
% 
% *0. Load the 3-D Model.*

[V,F] = openOFF('model.off', '');
close all
P = patch('Vertices', V, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
axis equal;
shading interp;
camlight right;
camlight left;
%% 
% 
% 
% *1. Translate to Origin*

Centroid=sum(V.',2)/19105;
V_Origin=(V.'-Centroid).';
figure;
P2= patch('Vertices', V_Origin, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
shading interp;
axis equal;
camlight right;
camlight left;
%% 
% *2. Rotate by 45 deg around X-axis then 120 deg around Z-axis*

V_x1=X_ROT(45,V_Origin);
V_z1=Z_ROT(120,V_x1);
figure;
P3= patch('Vertices', V_z1, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
shading interp;
axis equal;
camlight right;
camlight left;
%% 
% *3. Rotate by 120 deg around Z-axis then 45 deg around X-axis*.

V_z2=Z_ROT(120,V_Origin);
V_x2=X_ROT(45,V_z2);
figure;
P4=patch('Vertices', V_x2, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
shading interp;
axis equal;
camlight right;
camlight left;
%% 
% *4. Translate the 3-D Object after Transformation 3*

figure;
P4=patch('Vertices', V_x2, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
V_translate=V_x2.' + [0.5 0.2 0.1].'
P5=patch('Vertices', V_translate.', 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
shading interp;
axis equal;
camlight right;
camlight left;