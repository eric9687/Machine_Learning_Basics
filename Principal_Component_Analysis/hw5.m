% Read data X,Y & set significance level rerr = 0.05
X=xlsread('counties.xlsx','','C2:P3115');
Y=xlsread('counties.xlsx','','Q2:Q3115');
rerr = 0.05;

% PCA compress
[pcs, cprs_data, cprs_c] = pca_compress(X, rerr);

% PCA reconstruct
pca_reconstruct(pcs, cprs_data, cprs_c);

% excute function
linear_regression(Y,cprs_data',rerr);