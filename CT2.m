clear;
%          	  1. International Ellipsoid 1924
%	          2. International Ellipsoid 1967
%	          3. World Geodetic System 1972
%	          4. Geodetic Reference System 1980
%	          5. World Geodetic System 1984
%% 1.原始输入是车子的经纬高LLH,直接转换成本地坐标系ENU，大地框架是WGS84
load vehicle_llh.mat llh;
wgs84 = wgs84Ellipsoid('meters');

enu=zeros(size(llh));

for i=1:size(llh,1)
    [e,n,u]=geodetic2enu(llh(i,1),llh(i,2),llh(i,3),llh(1,1),llh(1,2),llh(1,3),wgs84);
    enu(i,:)=[e,n,u];
end

%% 2.输入检测到的行人的相对位置,△x和△y（假设每个时刻只检测到一个人）
xy=zeros(size(llh));
% xy=5*rand(size(llh));
% xy(:,3)=0;

%% 3.得到组合的ENU,然后再进行逆转换,得到LLH
ENU=enu+xy;
LLH=zeros(size(ENU));

for i=1:size(ENU,1)
    [lat,lng,h]=enu2geodetic(enu(i,1),enu(i,2),enu(i,3),llh(1,1),llh(1,2),llh(1,3),wgs84);
    LLH(i,:)=[lat,lng,h];
end
