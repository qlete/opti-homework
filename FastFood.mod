### SETS ###
set allProducts;
set nutriments;

set drinks;
set burgers;
set fries;
set chicken;
set salads;
set misc;

### PARAMETERS ###
param valNutr{allProducts, nutriments} >=0;
param prix{allProducts} >=0;
param lowerBound{nutriments} >=0;
param upperBound{nutriments} >=0;


### VARIABLE ###
var quantity{allProducts} >=0 integer; 

### OBJECTIVE ###
minimize Total_price : sum{i in allProducts} quantity[i]*prix[i];

### CONSTRAINTS ###
subject to Bounds {i in nutriments} : lowerBound[i] <= sum{j in allProducts} valNutr[j,i]*quantity[j] <= upperBound[i];

subject to cons_pt: quantity["PtitesTomates"] = 0;