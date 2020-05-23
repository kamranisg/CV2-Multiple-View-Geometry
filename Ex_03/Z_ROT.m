function [V] = Z_ROT(Gamma,V)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    pi=3.14;
    Gamma=(pi/180)*Gamma;
    Z_ROT=[cos(Gamma) -sin(Gamma) 0; sin(Gamma) cos(Gamma) 0; 0 0 1];
    V=(Z_ROT*V.').';
end