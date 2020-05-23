function [V] = Y_ROT(Beta,V)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    pi=3.14;
    Beta=(pi/180)*Beta;
    Y_ROT=[cos(Beta) 0 sin(Beta); 0 1 0; -sin(Beta) 0 cos(Beta)];
    V=(Y_ROT*V.').'
end