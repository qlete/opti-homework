### SETS ###
set allProducts; 
set nutriments;

### PARAMETERS ###
param valNutr{allProducts, nutriments} >=0; #entry ij is the number of nutriment j in product i
param prix{allProducts} >=0; #price of the products
param lowerBound{nutriments} >=0; #lowerbound on every nutriment
param upperBound{nutriments} >=0; #upperbound on every nutriment


### VARIABLE ###
var quantity{allProducts} >=0 integer; #Represents the quantity of each product that we select

### OBJECTIVE ###
minimize Total_price : sum{i in allProducts} quantity[i]*prix[i];

### CONSTRAINTS ###
subject to Bounds {i in nutriments} : lowerBound[i] <= sum{j in allProducts} valNutr[j,i]*quantity[j] <= upperBound[i];
