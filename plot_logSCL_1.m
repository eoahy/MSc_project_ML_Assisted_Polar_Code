s=load ('polar-A(84)-E(136)-L(8)-Algorithm(1).dat')
x=s(:,1)
y=s(:,2)
 
figure

    title('polar-A(84)-E(136)-L(8)-Algorithm(1)    logSCL');
    ylabel('BLER');
    xlabel('E_s/N_0 [dB]');
    plot(x(:,1),y(:,1))
    plot(x(:,1),y(:,1))
    set(gca, 'YScale', 'log')
    grid on
    legend('A=84 E=136 logSCL L=8')
    %ylim([target_BLER,1]);