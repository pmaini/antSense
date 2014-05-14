function curr_path = find_path(c_path,path,x,y)

curr_path  = 0 ;

for i= 1:length(c_path)
    if curr_path == 0 && c_path(i).left(1,2) < y && c_path(i).left(end,2) >= y
        for j = 1:length(c_path(i).left)-1
            if curr_path == 0
                
                slope_l = (c_path(i).left(j+1,2)-c_path(i).left(j,2))/(c_path(i).left(j+1,1)-c_path(i).left(j,1));
                slope_r = (c_path(i).right(j+1,2)-c_path(i).right(j,2))/(c_path(i).right(j+1,1)-c_path(i).right(j,1));

                if slope_l ~= Inf                     
                    if x > (((y - c_path(i).left(j,2))/slope_l) + c_path(i).left(j,1))                    
                        if slope_r ~= Inf 
                            if x < (((y - c_path(i).right(j,2))/slope_r) + c_path(i).right(j,1))
                                curr_path = i;
                            end
                        elseif x < c_path(i).right(j,1)
                            curr_path = i;
                        end
                    end                    
                elseif x > c_path(i).left(j,1)                    
                    if slope_r ~= Inf 
                        if x < (((y - c_path(i).right(j,2))/slope_r) + c_path(i).right(j,1))
                            curr_path = i;
                        end
                    elseif x < c_path(i).right(j,1)
                        curr_path = i;
                    end                    
                end                
            end 
        end
    end
end

if curr_path == 0
    for i = 1:length(path)
        if curr_path == 0 && path(i).left(1,2) <= y && path(i).left(end,2) >= y
            for j = 1:length(path(i).left) - 1           
                if curr_path == 0

                    slope_l = (path(i).left(j+1,2)-path(i).left(j,2))/(path(i).left(j+1,1)-path(i).left(j,1));
                    slope_r = (path(i).right(j+1,2)-path(i).right(j,2))/(path(i).right(j+1,1)-path(i).right(j,1));

                    if slope_l ~= Inf                         
                        if x > (((y - path(i).left(j,2))/slope_l ) + path(i).left(j,1))
                            if slope_r ~= Inf 
                                if x < (((y - path(i).right(j,2))/slope_r) + path(i).right(j,1))
                                    curr_path = 10 + i;
                                end
                            elseif x < path(i).right(j,1)
                                curr_path = 10 + i;
                            end
                        end
                    elseif x > path(i).left(j,1)
                        if slope_r ~= Inf 
                            if x < (((y - path(i).right(j,2)/slope_r)) + path(i).right(j,1))
                               curr_path = 10 + i;
                            end                               
                        elseif x < path(i).right(j,1)
                            curr_path = 10 + i;
                        end                        
                    end
                end
            end  
        end
    end
end