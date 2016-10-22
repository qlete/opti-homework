### SETS ###
set machines;
set months ordered; #We create an ordered set to later use function prev()to access previous elements 
set products;

### PARAMETERS ###
param profit{products} >=0; #profit contribution of the different products
param time_production{machines,products} >=0; #entry ij of the matrix is the time product j needs on machine i
param selling_limit{months,products} >=0; #entry ij of the matrix is the selling limit of product j in month i
param disponibility_machine{months,machines} >=0; #entry ij is the number of machines j disposable durng month i 

### VARIABLES ###
var quantity{months, products}>=0 integer; #Quantity of products j manufactured at month i 
var stock{months, products}>=0 integer; #Quantity of products j stored at month i for month i+1

### OBJECTIVE ###
#We use the functions first() and last() to stay more general
maximize Total_profit : sum{i in months, j in products:i<>first(months)} (profit[j]*(quantity[i,j]-stock[i,j]+stock[prev(i,months,1),j]) - 0.5*stock[i,j])
	+ sum{j in products} (profit[j]*(quantity[first(months),j]-stock[first(months),j]) - 0.5*stock[first(months),j]);
	#+ sum{j in products} 0.5*stock[last(months), j];

#Constraints to respect the selling limits : we impose a different constraint for the first month as it has no previous month
subject to Selling {i in months, j in products:i<>first(months)} :
	quantity[i,j] - stock[i,j] + stock[prev(i,months,1),j] <= selling_limit[i,j];

subject to Selling_Jan {j in products} :
	quantity[first(months),j] - stock[first(months),j] <= selling_limit[first(months),j];

subject to Time {i in machines, j in months}:
	sum{k in products} time_production[i,k]*quantity[j,k] <= 24*16*disponibility_machine[j,i];
	
subject to Stock {i in months, j in products}:
	stock[i,j] <= 100;

#We impose the stock to be 50 by the end of june	
subject to Stock_June {i in products}:
	stock[last(months), i] = 50;