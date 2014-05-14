function ants = update_ants(ants,time)

global numAnts;

for i = 1:numAnts
    
   if ants(i).existence <= time
      ants(i).active = 1; 
   end
   
   if ants(i).active == 1
       
       if ants(i).pos(2) >= 44.5
           ants(i).to_food = 0;
       elseif ants(i).pos(2) <=  5.5
           ants(i).to_food = 1;
       end
       
%       ants(i).dir = ceil(6*rand(1));
      
       move = ceil(6* rand(1));
      
       switch move         
          case 1
              ants(i).dir = 3*(pi/4) + ((pi/2)*rand(1));
          case 2
              if ants(i).to_food == 1
                ants(i).dir = 5*(pi/4) + ((pi/2)*rand(1));
              else
                ants(i).dir = (pi/4) + ((pi/2)*rand(1));
              end
          case 3
              ants(i).dir = 7*(pi/4) + ((pi/2)*rand(1));
          otherwise
              if ants(i).to_food == 1
                ants(i).dir = (pi/4) + ((pi/2)*rand(1));
              else
                ants(i).dir = 5*(pi/4) + ((pi/2)*rand(1));
              end
       end
   end
end