function d = vgg_H_algebraic_distance(H,X1,X2)

% d = vgg_H_algebraic_distance(H,X1,X2)
%
% For sets of homg points X1 and X2, returns the algebraic distances
%  d = (p2'_x p2'_y) * p1_w - (p1_x p1_y) * p2'_w
  
if (size(X1) ~= size(X2))
  error('Point sets not same size!');
end

N = size(X1,2);
% 书中 第93页 公式4.4
% dalg(x2,Hx1) = ||e||

Dx = [ X1' .* repmat(X2(3,:)',1,3) , zeros(N,3) , -X1' .* repmat(X2(1,:)',1,3) ];

Dy = [ zeros(N,3) , X1' .* repmat(X2(3,:)',1,3) , -X1' .* repmat(X2(2,:)',1,3) ];

h = reshape(H',9,1);
% p1 = 3*16
% DX = 16*9
% d = 2*16
d = [Dx * h , Dy * h]';