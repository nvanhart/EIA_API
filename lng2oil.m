%% LNG to Oil Converter
%  5.8 million BTU = 1 barrel of oil 
%  Converts price of LNG to barrel of oil to output ratio
%  When ratio > 1, LNG is a bargain to oil
%% Section 1: Collect current price
gas = EIA('lng') %current lng price
oil = EIA('oil')

%% Section 2: Calculate ratio
ratio = gas.value(end)*5.8/oil.value(end)

plot((gas.value*5.8/oil.value))

