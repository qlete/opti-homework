### SETS ###
set machines;
set months;
set products;

### PARAMETERS ###
param profit >=0;
param time_production >=0;
param selling_limit >=0;
param disponibility_machine >=0;

### VARIABLES ###
var quantity{months, products}; #Quantity of products j manufactured at month i 
var stock{months, products}; #Quantity of products j stored at month i for month i+1

### OBJECTIVE ###
maximize Total_profit : sum{i in months, j in products} profit[j]*(quantity[i,j]-stock[i,j]+stock[i,j-1]) - 0.5 ... cout 

