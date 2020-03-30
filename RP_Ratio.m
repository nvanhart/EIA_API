%% Crude Oil Reserve:Production ratio
%  Divides previous year's annual reserves by monthly production. 
%  Muliplies reserves by 1,000,000 and production by 1,000 and 12 to
%  annualize the estimate.
%% Section 1: Collect current price
reserves = EIA('oil_res');
production = EIA('oil_prod');

%% Section 2: Calculate monthly ratios
date = production.date;
ratio = zeros(size(date));

for i = 1:length(ratio)
    yrs1 = year(reserves.date); %converts to year only
    idx1 = find(yrs1 == year(production.date(i))-1); %idx for reserves
    if isempty(idx1)
        ratio(i) = 0; %if no data for current year
    else
        ratio(i) = (reserves.value(idx1)*1000000) / (production.value(i)*12*1000);
    end
end
rpr = table(date,ratio)
