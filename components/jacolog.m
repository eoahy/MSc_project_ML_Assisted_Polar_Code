function r=jacolog(x, y)

        if(x>y)
          r = x; 
	  diff=x-y; 
	else
	  r = y; 
          diff=y-x; 
        end
	  
        if(diff > 3.7 )      
r = r + 0.00;
        elseif(diff > 2.25) 
r = r + 0.05;
        elseif(diff > 1.5 ) 
r = r + 0.15;
        elseif(diff > 1.05) 
r = r + 0.25;
        elseif(diff > 0.7 ) 
r = r + 0.35;
        elseif(diff > 0.43) 
r = r + 0.45;
        elseif(diff > 0.2 ) 
r = r + 0.55;
        else                 
r = r + 0.65;
        end


