function [output] = EIA_v1(query)
%% API for EIA data
%  Useful URLs:
%  key = kljfdslfkjd
%  https://www.eia.gov/opendata/qb.php
%
%  Available Series:
%  lng = Henry Hub Natural Gas Spot, oil = West Texas Intermediate Spot
%  oil_res = US Crude proved reserves (mil barrels/year)
%  oil_prod = US monthly production (thous barrels/mo)
%
%% Section 1: Call API
switch query
    case 'lng'; url = 'http://api.eia.gov/series/?api_key=kljfdslfkjd&series_id=NG.RNGWHHD.D';
        raw = webread(url); raw = raw.series.data; %(1); raw3 = raw2{1,1}; data = raw3{2};
    case 'oil'; url = 'http://api.eia.gov/series/?api_key=kljfdslfkjd&series_id=PET.RWTC.D';
        raw = webread(url); raw = raw.series.data; %(1); raw3 = raw2{1,1}; data = raw3{2};
    case 'oil_res'; url = 'http://api.eia.gov/series/?api_key=kljfdslfkjd&series_id=PET.RCRR01NUS_1.A';
        raw = webread(url); raw = raw.series.data; %(1); raw3 = raw2{1,1}; data = raw3{2};
    case 'oil_prod'; url = 'http://api.eia.gov/series/?api_key=kljfdslfkjd&series_id=PET.MCRFPUS1.M';
        raw = webread(url); raw = raw.series.data; %(1); raw3 = raw2{1,1}; data = raw3{2};
end
%% Section 2: Format output
date = zeros(size(raw));
value = zeros(size(raw));

for i = 1:length(date)
   c = raw{i,1};
   date(i) = str2double(c{1});
   if isempty(c{2})
       value(i) = 0;
   else
       value(i) = c{2};
   end
end

if strlength(string(date(1))) == 4
    date = datetime(string(date),'InputFormat','yyyy');
elseif strlength(string(date(1))) == 6
    date = datetime(string(date),'InputFormat','yyyyMM');
else
    date = datetime(string(date),'InputFormat','yyyyMMdd');
end
date = flipud(date); %inverts so most recent is last value
value =flipud(value);
data = table(date,value);
output = data;
end