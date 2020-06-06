%% Image Formation by Perspective Projection

[V, F]=openOFF('model.off',' ');
v_new=[V.';ones(1,19105)];
TR=[-0.5 -0.5 1].';
Hom_Mat=[eye(3,3) TR];
V_NEW=Hom_Mat*v_new;
%%
P = patch('Vertices', V, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
%%
figure;
P = patch('Vertices', V_NEW.', 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
%%
X=V_NEW
ud=(540*X(1,:))./X(3,:) + 320;
vd=(540*X(2,:))./X(3,:) + 240;
ud(1,300)
vd(1,300)
%%
plot(ud,vd)
axis([0 640 0 480])
title("Projected 3D to 2D  ")

%%

UO=540*X(1,:) +320;
VO=540*X(2,:) + 240;
plot(UO,VO)
axis([0 640 0 480])
title("Projected 3D to 2D - Parallel Projection Orthogonal to Z-axis")