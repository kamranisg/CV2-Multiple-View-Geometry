function [V] = X_ROT(Alpha,V)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    pi=3.14;
    Alpha=(pi/180)*Alpha;
    X_ROT=[1 0 0;0 cos(Alpha) -sin(Alpha); 0 sin(Alpha) cos(Alpha)];
    V=(X_ROT*V.').'
end