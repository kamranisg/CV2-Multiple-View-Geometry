function [score, points] = getHarrisCorners(I, sigma, kappa, theta)

[M11, M12, M22] = getM(I, sigma);

% compute score using det and trace
detM = M11 .* M22 - M12.^2;
traceM = M11 + M22;
score = detM - kappa * traceM.^2;

% display score (for debugging)
imagesc(sign(score) .* abs(score).^(1/4));
colorbar;

% you can disable non-maximum suppression (for debugging)
max_only = 1;

% padded image for easier non-max suppression check
score_pad = -inf * ones(size(I) + 2);
score_pad(2:end-1, 2:end-1) = score;

% find corners
[y, x] = find( score > theta ...
             & ( ~max_only ...
               | ( score > score_pad(1:end-2, 2:end-1) ...
                 & score > score_pad(3:end  , 2:end-1) ...
                 & score > score_pad(2:end-1, 1:end-2) ...
                 & score > score_pad(2:end-1, 3:end))));

points = [x y];

end

