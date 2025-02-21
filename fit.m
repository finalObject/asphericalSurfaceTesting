%需要拟合的点的坐标为（0，-174.802,990.048），（0.472，-171.284,995.463），（0.413，-168.639,1003.55），（0.064，-167.862,1019.55），
%（0，-170.357,1035.44），（0，-172.142,1044.78），（0.215，-174.759,1047.84），（0.171，-176.586,1048.13），（0，-179.832,1043.34），（0,181.589,1040.11），（0，-182.76,1032.62），（0，-184.13,1017.55），（0.113，-183.445,1003.17）

% 日期：2011年12月29日
% 作者：半人马alpha
% 适用于你说的情况
% 你的数据拟合结果是一个旋转双曲面(a,c均为虚数，即 a^2<0,c^2<0)
% 我按拟合出的参数给你把图画了一下，是旋转双曲面的一支
    % step0：生成拟合数据（例）
    x = [0,0,0,0,0,0,0,0.064,0.113,0.171,0.215,0.413,0.472]';
    y = [-174.802,-170.357,-172.142,-179.832,181.589,-182.760,-184.130,-167.862,-183.445,-176.586,-174.759,-168.639,-171.284]';
    z = [990.048,1035.44,1044.78,1043.34,1040.11,1032.62,1017.55,1019.55,1003.17,1048.13,1047.84,1003.55,995.463]';
    
    % step1：拟合，k表示系数，行向量
    
    % 待拟合方程：F = z^2 = (-c^2/a^2*x^2) + (c^2/a^2*2*x1*x) + (- c^2/b^2*y^2) +
    %                      (c^2/b^2*2*y1*y) + (2*z1*z) +
    %                      (-c^2/a^2*x1^2 - c^2/b^2*y1^2 - z1^2 + c^2)
    % x,y,z 均要先转化为列向量
    % k(1) = -c^2/a^2  由k值就可求出椭圆所有参数！！！
    % k(2) = c^2/a^2*2*x1
    % k(3) = - c^2/b^2
    % k(4) = c^2/b^2*2*y1
    % k(5) = 2*z1
    % k(6) = -c^2/a^2*x1^2 - c^2/b^2*y1^2 - z1^2 + c^2
    
    xdata = [x,y,z];
    ydata = z.^2;  %% 先把 z 值平方，再进行拟合
    k0 = ones(1,6);  %% k 的运行初值，不会影响最终结果
    
    F = @(k,xdata) k(1)*xdata(:,1).^2 + k(2)*xdata(:,1) + k(3)*xdata(:,2).^2 + k(4)*xdata(:,2) + k(5)*xdata(:,3) + k(6);
    k=lsqcurvefit(F,k0,xdata,ydata);
% step2：椭圆参数求解
    x1 = -k(2)/k(1)/2;
    y1 = -k(4)/k(3)/2;
    z1 = k(5)/2;
    c = sqrt(z1^2 + k(6) - k(1)*x1^2 - k(3)*y1^2);
    a = c/sqrt(-k(1));
    b = c/sqrt(-k(3));
disp('x1:');
    disp(x1);
    disp('y1:');
    disp(y1);
    disp('z1:');
    disp(z1);
    disp('a轴:');
    disp(a);
    disp('b轴:');
    disp(b);
    disp('c轴:');
    disp(c);
    
