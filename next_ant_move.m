function ants = next_ant_move(ants, c_path, path)

global numAnts

for i= 1:numAnts
     
     if ants(i).active == 1
         
         will_move = 1;
         tempx = (ants(i).pos(1)+(cos(ants(i).dir)*ants(i).step));
         tempy = (ants(i).pos(2)+(sin(ants(i).dir)*ants(i).step));
         
%          switch ants(i).dir
%
%              case 1
%                   tempx = (ants(i).pos(1) - ants(i).step);
%                   tempy = (ants(i).pos(2));                  
%          
%              case 2
%                 if ants(i).to_food == 1
%                   tempx = (ants(i).pos(1));
%                   tempy = (ants(i).pos(2) - ants(i).step);
%                 else
%                   tempx = (ants(i).pos(1));
%                   tempy = (ants(i).pos(2) + ants(i).step);
%                 end
%                   
%              case 3
%                   tempx = (ants(i).pos(1) + ants(i).step);
%                   tempy = (ants(i).pos(2));
%                   
%              otherwise
%                 if ants(i).to_food == 1
%                     tempx = (ants(i).pos(1));
%                     tempy = (ants(i).pos(2) + ants(i).step);
%                 else
%                     tempx = (ants(i).pos(1));
%                     tempy = (ants(i).pos(2) - ants(i).step);
%                 end 
%
%          end         
             
         ants(i).path = find_path(c_path, path, tempx, tempy);  
         
         if ants(i).path == 0
             
             will_move = 0;
             
         elseif ants(i).path < 10
             
             for j = 1:length(c_path(ants(i).path).left)-1
                 if will_move == 1 && c_path(ants(i).path).left(j,2) <= tempy && tempy < c_path(ants(i).path).left(j+1,2)
                 
                     slope_l = (c_path(ants(i).path).left(j+1,2)-c_path(ants(i).path).left(j,2))/(c_path(ants(i).path).left(j+1,1)-c_path(ants(i).path).left(j,1));
                     slope_r = (c_path(ants(i).path).right(j+1,2)-c_path(ants(i).path).right(j,2))/(c_path(ants(i).path).right(j+1,1)-c_path(ants(i).path).right(j,1));

                     if slope_l ~= Inf
                         if tempx <= (((tempy - c_path(ants(i).path).left(j,2))/slope_l) + c_path(ants(i).path).left(j,1))
                            will_move = 0;
                         end
                     elseif tempx <= c_path(ants(i).path).left(j,1)
                         will_move = 0;
                     end

                     if slope_r ~= Inf 
                         if tempx >= (((tempy - c_path(ants(i).path).right(j,2))/slope_r) + c_path(ants(i).path).right(j,1))
                             will_move = 0;
                         end
                     elseif tempx >= c_path(ants(i).path).right(j,1)
                         will_move = 0;                     
                     end
                 
                  end
              end
         else
             val = ants(i).path - 10;
             for j = 1:length(path(val).left)-1
                if will_move == 1 && path(val).left(j,2) <= tempy && tempy < path(val).left(j+1,2)
                    
                     slope_l = (path(val).left(j+1,2)-path(val).left(j,2))/(path(val).left(j+1,1)-path(val).left(j,1));
                     slope_r = (path(val).right(j+1,2)-path(val).right(j,2))/(path(val).right(j+1,1)-path(val).right(j,1));

                     if slope_l ~= Inf 
                         if tempx <= (((tempy - path(val).left(j,2))/slope_l) + path(val).left(j,1))
                             will_move = 0;
                         end
                     elseif tempx <= path(val).left(j,1)
                         will_move = 0;
                     end
                     if slope_r ~= Inf
                         if tempx >= (((tempy - path(val).right(j,2))/slope_r) + path(val).right(j,1))
                             will_move = 0;
                         end
                     elseif tempx >= path(val).right(j,1)
                         will_move = 0;                   
                     end
                     
                end
             end             
         end
                 
         if will_move == 1
             ants(i).prev_pos = ants(i).pos;
             ants(i).pos = [tempx tempy];
         end
    end
end 