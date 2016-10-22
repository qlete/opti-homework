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
param nb_group >=0; #Number of groups
param max_qtt_day{1..nb_group} >=0; #Max quantity for each day and each group
param min_qtt_week{1..nb_group} >=0; #Min quantity for each week and each group


### VARIABLE ###
var quantity{allProducts, 1..7} >=0 integer; #Now, we have one quantity per product and per day of the week

### OBJECTIVE ###
minimize Total_price : sum{k in 1..7, i in allProducts} quantity[i, k]*prix[i];

### CONSTRAINTS ###
#To respect the daily bounds
subject to Bounds {k in 1..7, i in nutriments} : lowerBound[i] <= sum{j in allProducts} valNutr[j,i]*quantity[j, k] <= upperBound[i];

#Max quantity of products in each group per day
subject to Max_qtt1 {k in 1..7} : sum{j in drinks} quantity[j, k]<=max_qtt_day[1]; 
subject to Max_qtt2 {k in 1..7} : sum{j in burgers} quantity[j, k]<=max_qtt_day[2]; 
subject to Max_qtt3 {k in 1..7} : sum{j in fries} quantity[j, k]<=max_qtt_day[3]; 
subject to Max_qtt4 {k in 1..7} : sum{j in chicken} quantity[j, k]<=max_qtt_day[4]; 
subject to Max_qtt5 {k in 1..7} : sum{j in salads} quantity[j, k]<=max_qtt_day[5]; 
subject to Max_qtt6 {k in 1..7} : sum{j in misc} quantity[j, k]<=max_qtt_day[6]; 

#Min quantity of products in each group per week
subject to Min_qtt1 : sum{j in drinks, k in 1..7} quantity[j, k]>=min_qtt_week[1]; 
subject to Min_qtt2 : sum{j in burgers, k in 1..7} quantity[j, k]>=min_qtt_week[2];
subject to Min_qtt3 : sum{j in fries, k in 1..7} quantity[j, k]>=min_qtt_week[3];
subject to Min_qtt4 : sum{j in chicken, k in 1..7} quantity[j, k]>=min_qtt_week[4];
subject to Min_qtt5 : sum{j in salads, k in 1..7} quantity[j, k]>=min_qtt_week[5];
subject to Min_qtt6 : sum{j in misc, k in 1..7} quantity[j, k]>=min_qtt_week[6];

#Different products
subject to Diff_prod {i in allProducts} : sum{j in 1..7} quantity[i, j] <= 1;
