s=load ('capacity_84_272.dat')
x=s(:,1)
y=s(:,2)
 
figure

    plot(x(:,1),y(:,1))
    plot(x(:,1),y(:,1))
    set(gca, 'YScale', 'log')
    grid on
    legend('capacity A=84 E=272')
    
    title('capacity A=84 E=272');
    ylabel('BLER');
    xlabel('E_s/N_0 [dB]');
    %ylim([target_BLER,1]);