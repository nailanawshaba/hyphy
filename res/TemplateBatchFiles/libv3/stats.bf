lfunction stats.quantile (column, p) {
    // the R-8 method https://en.wikipedia.org/wiki/Quantile#Estimating_quantiles_from_a_sample
    
    N = Rows (column);
        
    h = (N + 1/3)*p -2/3;
    
    if (h < 0) {
        return column[0];
    }
    
    if (h >= N-1) {
        return column[N-1];
    }
    
    h_floor = h$1;
        
    return column[h_floor] + (h-h_floor)*(column[h_floor+1]-column[h_floor]);
} 