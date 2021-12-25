function recon_data=pca_reconstruct(pcs,cprs_data,cprs_c)
[n,~]=size(pcs);
% reconstruct standard variables
recon_data=pcs*cprs_data;
% nomarlizing recon_data
for i=1:n
    recon_data(i,:)=recon_data(i,:).*sqrt(cprs_c(i,2))+cprs_c(i,1);
end
% rewrite datas in new document
xlswrite('recon_data.xls',recon_data');
end