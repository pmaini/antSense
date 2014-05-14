close all;
clear all;
hold on;

global numAnts simTime p_length;

simTime = 1000;
numAnts = 20;
p_length = 60;


images = struct('cdata',{},'colormap',{});
imgframe = 1;

xmax = 50;
ymax = xmax;

axis([0 xmax 0 ymax]);
axis square;

rectangle('Position',[15 0 20 5],'FaceColor','b');
rectangle('Position',[15 45 20 5],'FaceColor','c');

c_path(1).left = [15 5; 15 10];
c_path(1).right = [35 5; 35 10];
path(1).left = [15 10;  15 45];
path(1).right = [25 10;  25 45];
path(2).left = [25 10; 40 25; 25 45];
path(2).right = [35 10; 50 25; 35 45];

for j = 1:length(c_path)    
    for i = 1:length(c_path(j).left)-1
        line([c_path(j).left(i,1) c_path(j).left(i+1,1)], [c_path(j).left(i,2) c_path(j).left(i+1,2)]);
    end
    for i = 1:length(c_path(j).right)-1
        line([c_path(j).right(i,1) c_path(j).right(i+1,1)], [c_path(j).right(i,2) c_path(j).right(i+1,2)]);
    end
end

for j = 1:length(path)
    for i = 1:length(path(j).left)-1
        line([path(j).left(i,1) path(j).left(i+1,1)], [path(j).left(i,2) path(j).left(i+1,2)]);
    end
    for i = 1:length(path(j).right)-1
        line([path(j).right(i,1) path(j).right(i+1,1)], [path(j).right(i,2) path(j).right(i+1,2)]);
    end
end

ants = struct([]);

for i = 1:numAnts
   ants(i).name = i;
   ants(i).step = 1;
   ants(i).pos = [25 6];
   ants(i).prev_pos = ants(i).pos;
   if mod(i,2) == 1
       ants(i).existence = 1 + (((i-1)/numAnts) * simTime);%ceil((simTime *(3/4))* rand());
   else
       ants(i).existence = ants(i-1).existence;
   end
   ants(i).dir =  pi/3 +  (pi/3 * rand(1)); %ceil(20*rand(1));
   ants(i).active = 0;
   ants(i).to_food = 1;
   ants(i).plot = 1;
   ants(i).p_plots = ones(p_length,1);
   ants(i).path = 1;
end

time = 1;

while time <= simTime    
    ants = next_ant_move(ants, c_path, path);
    
    pause(0.01);
    
    images(imgframe) = getframe;
    imgframe = imgframe + 1;
    
    ants = refresh_plots(ants,time);
    
    ants = update_ants(ants, time);
    
    time = time + 1;    
end

% for i = 1:imgframe-1
%    [im map] = frame2im(images(i));
%    imwrite(im,['plot',num2str(i),'.jpg'],'jpg');
% end

movie2avi(images,'movie7.avi','compression','Cinepak','fps',10);