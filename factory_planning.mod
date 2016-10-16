### SETS ###
set machines;
set months ordered;
set products;

### PARAMETERS ###
param profit{products} >=0;
param time_production{machines,products} >=0;
param selling_limit{months,products} >=0;
param disponibility_machine{months,machines} >=0;

### VARIABLES ###
var quantity{months, products}>=0 integer; #Quantity of products j manufactured at month i 
var stock{months, products}>=0 integer; #Quantity of products j stored at month i for month i+1

### OBJECTIVE ###
maximize Total_profit : sum{i in months, j in products:i<>"January"} (profit[j]*(quantity[i,j]-stock[i,j]+stock[prev(i,months,1),j]) - 0.5*stock[i,j])
	+ sum{j in products} (profit[j]*(quantity["January",j]-stock["January",j]) - 0.5*stock["January",j])
	+ sum{j in products} 0.5*stock["June", j];

subject to Selling {i in months, j in products:i<>"January"} :
	quantity[i,j] - stock[i,j] + stock[prev(i,months,1),j] <= selling_limit[i,j];

subject to Selling_Jan {j in products} :
	quantity["January",j] - stock["January",j] <= selling_limit["January",j];

subject to Time {i in machines, j in months}:
	sum{k in products} time_production[i,k]*quantity[j,k] <= 24*16*disponibility_machine[j,i];
	
subject to Stock {i in months, j in products}:
	stock[i,j] <= 100;  # faut gerer stock en janvier et en juin #
	
subject to Stock_June {i in products}:
	stock["June", i] = 50;