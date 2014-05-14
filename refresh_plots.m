function ants = refresh_plots(ants,time)

global numAnts p_length;

for i = 1:numAnts
    if ants(i).active == 1 
        
        if ants(i).plot ~= 1
          delete(ants(i).plot);
        end
        
        ants(i).plot = plot(ants(i).pos(1), ants(i).pos(2),'b*','MarkerSize',5);
        

           if ants(i).p_plots(mod((time-ants(i).existence-(p_length/2)),p_length)+1) ~= 1
              set(ants(i).p_plots(mod((time-ants(i).existence-(p_length/2)),p_length)+1),'MarkerFaceColor',[1 0.9 1]);
            end
            
            if ants(i).p_plots(mod((time-ants(i).existence),p_length)+1) ~= 1
              delete(ants(i).p_plots(mod((time-ants(i).existence),p_length)+1));
              ants(i).p_plots(mod((time-ants(i).existence),p_length)+1) = 1;
            end
            
        if ants(i).to_food == 0
            
            
            ants(i).p_plots(mod((time-ants(i).existence),p_length)+1) = plot(ants(i).prev_pos(1), ants(i).prev_pos(2),'mo','MarkerSize',4,'MarkerFaceColor','m','DisplayName','ph');
            set(ants(i).p_plots(mod((time-ants(i).existence)-1,p_length)+1),'UserData',ants(i).p_plots(mod((time-ants(i).existence),p_length)+1));
        end
        
        
           
    end
end