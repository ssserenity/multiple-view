function H = vgg_H_from_x_lin(xs1,xs2)
% H = vgg_H_from_x_lin(xs1,xs2)
%
% Compute H using linear method (see Hartley & Zisserman Alg 3.2 page 92 in
%                              1st edition, Alg 4.2 page 109 in 2nd edition). 
% Point preconditioning is inside the function.
%
% The format of the xs [p1 p2 p3 ... pn], where each p is a 2 or 3
% element column vector.

% 设置C1 C2 为单位阵 不做变换

[r,c] = size(xs1);

if (size(xs1) ~= size(xs2))
 error ('Input point sets are different sizes!')
end

if (size(xs1,1) == 2)
  xs1 = [xs1 ; ones(1,size(xs1,2))];
  xs2 = [xs2 ; ones(1,size(xs2,2))];
end

% condition points
%C1 = [sqrt(2)/x_stdvariance   0          -sqrt(2)/x_stdvariance*x_mean;
%       0         sqrt(2)/y_stdvariance   -sqrt(2)/y_stdvariance*y_mean;
%       0                      0                                      1]
%  书的 4.4.4
C1 = vgg_conditioner_from_pts(xs1);
C2 = vgg_conditioner_from_pts(xs2);
xs1 = vgg_condition_2d(xs1,C1);
xs2 = vgg_condition_2d(xs2,C2);

D = [];
ooo  = zeros(1,3);
for k=1:c
  p1 = xs1(:,k);
  p2 = xs2(:,k);

  D = [ D;
    p1'*p2(3) ooo -p1'*p2(1)    % 公式4.1 中的第二行
    ooo p1'*p2(3) -p1'*p2(2)    % 公式4.2 中的第一行
   ];
end

% Extract nullspace
% D = USV
% U is egien-vector of DD'
% V is eigen-vector of D'D
[u,s,v] = svd(D, 0); 
s = diag(s);
 
nullspace_dimension = sum(s < eps * s(1) * 1e3);
if nullspace_dimension > 1
  fprintf('Nullspace is a bit roomy...');
end
 
h = v(:,9);

H = reshape(h,3,3)';

% decondition
% 书中的4.4 109页 ALgorithm 
% 4.2: THE normalized DLT for 2D homograhies

H = inv(C2) * H * C1;

H = H/H(3,3);
end


function f()
%% test
    n = 1*randn(2,1);
    xs1_real = [[10 10 2]' [23 32 3]' [21 12 4]' [67 90 2]' [65 190 2]' [12 34 3]' [45 30 2]' [10 86 8]'...
                [65 20 1]' [33 45 23]' [19 81 11]' [75 43 8]' [30 80 3]'  [77 25 5]' [100 34 6]' [56 80 4]'];
    N = size(xs1_real,2);
    
%     for i = 1:N
%         xs1_real(:,i) = xs1_real(:,i)/xs1_real(3,i);
%     end
    
    xs1_mesurement = zeros(size(xs1_real));
    
    for i = 1:N
        xs1_mesurement(:,i) = [n;0]+xs1_real(:,i);
    end
    
    H_real=[100,3,20;...
            14,30,80;...
            6,4,4];
    
    for i = 1:N
    xs2_real(:,i) = H_real*xs1_mesurement(:,i);
    end
%     
%     for i = 1:N
%        xs2_real(:,i) = xs2_real(:,i)/xs2_real(3,i);
%     end
    
    H_Eestimation = vgg_H_from_x_lin(xs1_mesurement, xs2_real)
    
%     
%     H_Eestimation =
%     0.1699    0.0663    1.3677
%     0.0204    0.0578    0.5769
%     0.1104    0.0680    1.0000

% 100/0.1699*H_Eestimation

%
%   100.0016   39.0006  804.9780
%    12.0002   34.0006  339.5377
%    65.0011   40.0007  588.5815

% if not use C1 C2 condition
%    100.0006   39.0002   70.1775
%    12.0001   34.0002  118.8332
%    65.0004   40.0002   44.7427

%    99.9570   38.9832  220.9782
%    11.9948   33.9854  290.6332
%    64.9720   39.9828  219.5872

%    结论：
%    1. 由于是2D 单应，最后一列应该恢复不出来？？？
%       好像不是： 如果［x y w］w 不都取1 ，最后一列是可以恢复出来的

%       100.0005   41.0658  229.7869
%       13.2815   34.2070   87.0592
%       65.5608   41.2894   10.4333

% 麻痹！！！蠢哭了，上面的是不存在的，因为之前 xs2_real(:,i) = H_real*xs1_mesurement(:,i); 写错了！！！
% 写成  xs2_real(:,i) = H_real*xs1_real(:,i);
% 下次 出现什么明显不合理的  先检查是不是代码错误！！

     %: 注意 什么叫 恢复到尺度
%      H_Eestimation =
%      25.0000    0.7500    5.0000
%      3.5000    7.5000   20.0000
%      1.5000    1.0000    1.0000

%    2. condition  可以不用，




end
