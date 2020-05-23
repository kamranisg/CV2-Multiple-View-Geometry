function [V] = T_Origin(V)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    Centroid=sum(V.',2)/19105
    V=(V.'-Centroid).'
end