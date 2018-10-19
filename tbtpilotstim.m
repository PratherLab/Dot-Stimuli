% Trial by Trial Stim Maker
% Original date 8.11.13
% Stim used in Fall 2013 Child data

%{ 
this file creas nn smblc compaison
unlike prevs version we do not contrl fo perceponal features
hey ae varied and kept track of. this includes

Number
Total/Mean Area Area
Largest item Area

Density
Convex Perimeter

%}

clear;
trials = zeros(48,2); %number of trial pairs

load tbtpilotstim.mat %A set of stim to use
trials = tbtstim;

squaresizes = zeros (120,2); %sizes for all the items in a stim. max items 60

load tbtareas.mat; %the total areas for each trial
totalareas = zeros(120,2);
totalareas = totalarea;


locationsave = zeros (120,2,40); %buffer for locations
sizesave = zeros (120,2,20); %buffer for square sizes
perimeters = zeros (132,2); % total perimeters for each trail


trialnames = cell(132,2);

%load smalltrialnames.mat
%trialnames = smallratiotrialnames;
load tbttrialnames.mat;
trialnames = bigtrialnames;

for d = 1:48 %total pairs
          
bigsquare = ((2*totalareas(d,1))/(trials(d,1) + trials(d,2)))*1.7; %size of bigest square

squaresizes(1,1) = bigsquare; %biggest sq on both is same size
squaresizes(1,2) = bigsquare;

averagearea1 = totalareas(d,1) / (trials(d,1) - 1); 
averagearea2 = totalareas(d,2) / (trials(d,2) - 1);

pairs1 = (trials(d,1) - 1)/2;
pairs2 = (trials(d,2) - 1)/2;

for a=1:pairs1
    %random adjustments to square sizes
    adjustment = rand()*.1; %random value between 0 and .1
    squaresizes((2*a),1) = averagearea1*(1 + adjustment);
    squaresizes((2*a+1),1) = averagearea1 * (1 - adjustment);
end;

for a=1:pairs2
    
adjustment = rand()*.1; %random value between 0 and .1
    squaresizes((2*a),2) = averagearea2*(1 + adjustment);
    squaresizes((2*a+1),2) = averagearea2 * (1 - adjustment);
end;

if rem(trials(d,1),2) == 0 %is even then add additional sqaure of size average area 
    squaresizes((pairs1*2)+1,1) = averagearea1;
end

if rem(trials(d,2),2) == 0
    squaresizes((pairs2*2)+1,2) = averagearea2;
end


squaresizes = squaresizes/squaresizes(1,1); %sets largest size square to 1 

squareperimeters = 4*sqrt(squaresizes);
perimeters(d,1) = sum(squareperimeters(:,1));
perimeters(d,2) = sum(squareperimeters(:,2));




%PLACEMENT Matrix
%Create one set of coordinates seperate enough for biggest square, sort list by
%random and place each square set
%will be places at the coordinates stating with 1 to final set. Then if
%needed the pictures can be rotated.

%DRAW AXIS AND OBJECTS
%Set axis as needed, save or display objects

%filenames = trials;
%filenames = mat2str(filenames); %for pdf file names

 %end; %add this end to skip drawing figs

for c =1:1 % set to 1
    
figure('Position',[400,900,1400,700])
xlim([0,trials(d,1)+trials(d,1)+5]) %should the upper limit be associated with the value being presented
ylim([0,trials(d,1)+3])
axis off
zoom on
%figure('visible','off')
hold on

xvaluesA = randperm(trials(d,1));
yvaluesA = randperm(trials(d,1)); %right now this needs to be scaled with the max number of dots

xvaluesB = randperm(trials(d,1));
yvaluesB = randperm(trials(d,1));

xvaluesB = xvaluesB + trials(d,1)+3; %moves the B value over to the right.


for a=1:(trials(d,1));
    plot(rectangle('Facecolor','k','Position',[xvaluesA(a),yvaluesA(a),sqrt(squaresizes(a,1)),sqrt(squaresizes(a,1))]))
    
sizesave (a,c,d) = squaresizes(a,c);
end;

for a=1:(trials(d,2));
plot(rectangle('Facecolor','k','Position',[xvaluesB(a),yvaluesB(a),sqrt(squaresizes(a,2)),sqrt(squaresizes(a,2))]))
sizesave (a,c,d) = squaresizes(a,c);
end;

seperator = zeros(2,2);
seperator = [trials(d,1)+2,0; trials(d,1)+2, trials(d,1)+2];
line(seperator(2,:), seperator(1,:),'Color','black');
%Save locations and sizes of squares



%Save figure as a PNG file
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [11 8.5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 10 5]);

print(gcf,'-dpng','-r300',trialnames{d,c});
    %save each made figure as seperate pdf file
close;
end;


end



% Image editing
%further editing of images for fliping
if 0
    load flipset.mat 
   flipset = flipset% cell with images to rotate
    cd /Users/richard/Dropbox/Rich/backup/Vaule/TBT dynamic/TBT adult/tbt adult stim
   for a=1:62
    B = imrotate(A,angle)
   end
    
    
end