global Result_Modes
c=1013
for a=1013:1706% 1075 den sonra segmentation yapmak zorunda
    
    store= zeros(3,3);
    A= zeros(1,3);
    G= zeros(1,3);
    Result_store1= zeros(1,3);
            
              
               
              
        for i=2*(ceil(a/2))+22:1088
            A(1,i)=a;
            G(1,i)=i;
            PUCCH_encoder(round(rand(1,A(1,i))),G(1,i));
            Result_store1(1,i)=Result_Modes;
           
        end
   
        
     sonuc=reshape(Result_store1,[],1);   
   
     table9=[reshape(A,[],1) reshape(G,[],1)  reshape(Result_store1,[],1)];
    
    % % Store
    BaseName='store_results_segmentation_2';
    %
    filename=[BaseName,num2str(a)];    
    % % Save the results
    save([filename,'.mat'], 'table9');

    load('store_lates_modes_2.mat')
    
        store_lates_modes_2(2370-c,2*(ceil(a/2))+22:1088)= sonuc(2*(ceil(a/2))+22:1088,:);
   
    c=c+1;
    % Store
    filename1='store_lates_modes_2';
    % Save the results
    save([filename1,'.mat'], 'store_lates_modes_2');
end
c