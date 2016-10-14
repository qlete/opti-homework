### SETS ###
set machines;
set months;
set products;

### PARAMETERS ###
param profit >=0;
param time_production{machines,products} >=0;
param selling_limit{months,products} >=0;
param disponibility_machine{months,machines} >=0;

### VARIABLES ###
var quantity{months, products}; #Quantity of products j manufactured at month i 
var stock{months, products}; #Quantity of products j stored at month i for month i+1

### OBJECTIVE ###
maximize Total_profit : sum{i in months, j in products} profit[j]*(quantity[i,j]-stock[i,j]+stock[i-1,j]) - 0.5*stock[i,j]

subject to Selling {i in months, j in products}:
	quantity[i,j] - stock[i,j] + stock[i-1,j] <= selling_limit[i,j]

subject to Time {i in machines, j in months}:
	sum{k in products} time_production[i,k]*quantity[j,k] <= 24*16*disponibility_machine[j,i]
	
subject to Stock {i in months, j in products}:
	stock[i,j] <= 100  # faut gerer stock en janvier et en juin #
	
