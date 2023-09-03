
 load('store_lates_modes_2.mat')
 store_lates_modes_2(1358:2011,2048:2370)=10;
     % Store
    filename1='store_lates_modes_2';
    % Save the results
    save([filename1,'.mat'], 'store_lates_modes_2');