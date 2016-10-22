### SETS ###
set allProducts;
set nutriments;

#We create the six groups of product to impose diversity in the menus
set drinks;
set burgers;
set fries;
set chicken;
set salads;
set misc;

### PARAMETERS ###
param valNutr{allProducts, nutriments} >=0; #entry ij is the number of nutriment j in product i
param prix{allProducts} >=0; #price of the products
param lowerBound{nutriments} >=0; #lowerbound on every nutriment
param upperBound{nutriments} >=0; #upperbound on every nutriment
param nb_group >=0; #number of groups
param max_qtt_day{1..nb_group} >=0; #Max quantity for each day and each group


### VARIABLE ###
var quantity{allProducts} >=0 integer; #Represents the quantity of each product that we select

### OBJECTIVE ###
minimize Total_price : sum{i in allProducts} quantity[i]*prix[i];

### CONSTRAINTS ###
#To respect the daily bounds
subject to Bounds {i in nutriments} : lowerBound[i] <= sum{j in allProducts} valNutr[j,i]*quantity[j] <= upperBound[i];

#Max quantity of products in each group per day. Determined by good sense.
#Here we have to write one constraint per set as AMPL doesn't allow sets of sets
subject to Max_qtt1 : sum{j in drinks} quantity[j]<=max_qtt_day[1]; 
subject to Max_qtt2 : sum{j in burgers} quantity[j]<=max_qtt_day[2]; 
subject to Max_qtt3 : sum{j in fries} quantity[j]<=max_qtt_day[3]; 
subject to Max_qtt4 : sum{j in chicken} quantity[j]<=max_qtt_day[4]; 
subject to Max_qtt5 : sum{j in salads} quantity[j]<=max_qtt_day[5]; 
subject to Max_qtt6 : sum{j in misc} quantity[j]<=max_qtt_day[6]; 

#Take at least one drink a day
subject to Drink : sum{i in drinks} quantity[i] >= 1;
