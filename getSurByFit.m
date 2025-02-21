% @author finalObject
%         http://www.finalobject.cn
%         i@finalobject.cn
%         https://github.com/finalObject
% @date 2017年4月8日 9:48:22
% @version 2.0
% 通过拟合出来的椭球数据重建表面
% 输入参数默认是正方形，xy范围可以不同
function [ x1,y1,z1 ] = getSurByFit( k ,percision,startX,startY,side,neg)
    % k(1)=x1;
    % k(2)=y1;
    % k(3)=z1;
    % k(4)=a;
    % k(5)=b;
    % k(6)=c;
    
    % side是试图生成数据的边长，返回的xyz矩阵是side*side
        % 待拟合方程：F = z^2 = (-c^2/a^2*x^2) + (c^2/a^2*2*x1*x) + (- c^2/b^2*y^2) +
    %                      (c^2/b^2*2*y1*y) + (2*z1*z) +
    %                      (-c^2/a^2*x1^2 - c^2/b^2*y1^2 - z1^2 + c^2)
    % x,y,z 均要先转化为列向量
    % k(1) = -c^2/a^2
    % k(2) = c^2/a^2*2*x1
    % k(3) = - c^2/b^2
    % k(4) = c^2/b^2*2*y1
    % k(5) = 2*z1
    % k(6) = -c^2/a^2*x1^2 - c^2/b^2*y1^2 - z1^2 + c^2
    if (nargin==2)
        startX=-29.5;
        startY=-29.5;
        side=60;
        neg=1;
    end
    x1 = startX:percision:(startX+side);
    y1 = startY:percision:(startY+side);
    lengthX = length(x1);
    [x1,y1] = meshgrid(x1,y1);
    z1 = zeros(lengthX,lengthX);
    for ii=1:lengthX
        for jj=1:lengthX
            %z1(ii,jj)=-sqrt(1-((x1(ii,jj)-k(1))/k(4))^2-((y1(ii,jj)-k(2))/k(5))^2)*k(6)+k(3);
            b=-k(5);
            c=-(k(1)*x1(ii,jj)*x1(ii,jj)+k(2)*x1(ii,jj)+k(3)*y1(ii,jj)*y1(ii,jj)+k(4)*y1(ii,jj)+k(6));
            z1(ii,jj)=(-b-sqrt(b^2-4*c)*neg)/2;
        end
    end
    
end

