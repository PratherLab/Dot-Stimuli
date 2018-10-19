
%{ 
TBT STIM MAKER 3.10.14
FOR USE WITH ADULT DATA

Perceptual factors:
Number
Total Area
Largest item Area (controled)
Density
Convex Perimeter

%}

clear;
load tbtvarstim.mat %A set of stim to use includes values for all PFs

trialspecs = zeros(125,6); %Trial specs: number, area, hullsize

trialspecs = tbtstim;

squaresizes = zeros (60,2); %buffer for sizes for all the items in a stim. max items 60
locationsave = zeros (120,2,40); %buffer for locations
sizesave = zeros (120,2,20); %buffer for square sizes
perimeters = zeros (132,2); % total perimeters for each trail


trialnames = cell(125,1);
load tbtvarnames.mat;
trialnames = trialnames;

for d = 1:125 %total pairs 125
          

averagearea1 = trialspecs(d,3) / (trialspecs(d,1)); %average area of all items
averagearea2 = trialspecs(d,4) / (trialspecs(d,2));

pairs1 = (trialspecs(d,1))/2;
pairs2 = (trialspecs(d,2))/2;

for a=1:pairs1
    %random adjustments to square sizes. paired so that total is 
    adjustment = rand()*.1; %random value between 0 and .1
    squaresizes((2*a-1),1) = averagearea1*(1 + adjustment);
    squaresizes((2*a),1) = averagearea1 * (1 - adjustment);
end;

for a=1:pairs2
    
adjustment = rand()*.1; %random value between 0 and .1
    squaresizes((2*a-1),2) = averagearea2*(1 + adjustment);
    squaresizes((2*a),2) = averagearea2 * (1 - adjustment);
end;

if rem(trialspecs(d,1),2) > 0 %is even then add additional sqaure of size average area 
    squaresizes((pairs1*2),1) = averagearea1;
end

if rem(trialspecs(d,2),2) > 0
    squaresizes((pairs2*2),2) = averagearea2;
end


squaresizes = squaresizes/4.4; %sets largest size square to 1 or less 


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
xlim([0,trialspecs(d,1)+trialspecs(d,1)+30]) %should the upper limit be associated with the value being presented
ylim([0,trialspecs(d,1)+15])
axis off
zoom on
%figure('visible','off')
hold on

if trialspecs(d,5) < trialspecs(d,6) 

xvaluesA = randperm(round(max(trialspecs(d,1:2))));
yvaluesA = randperm(round(max(trialspecs(d,1:2))));
xvaluesB = randperm(round(max(trialspecs(d,1:2))*trialspecs(d,6)/trialspecs(d,5))); %increase size of possble XY coords
yvaluesB = randperm(round(max(trialspecs(d,1:2))*trialspecs(d,6)/trialspecs(d,5)));

else
xvaluesA = randperm(round(max(trialspecs(d,1:2))*trialspecs(d,5)/trialspecs(d,6)));
yvaluesA = randperm(round(max(trialspecs(d,1:2))*trialspecs(d,5)/trialspecs(d,6))); %right now this needs to be scaled with the max number of dots
xvaluesB = randperm(round(max(trialspecs(d,1:2))));
yvaluesB = randperm(round(max(trialspecs(d,1:2))));
    
end

xvaluesB = xvaluesB + trialspecs(d,1) + 12; %moves the B value over to the right.


for a=1:(trialspecs(d,1));
    plot(rectangle('Facecolor','k','Position',[xvaluesA(a),yvaluesA(a),sqrt(squaresizes(a,1)),sqrt(squaresizes(a,1))]))
    
sizesave (a,c,d) = squaresizes(a,c);
end;

for a=1:(trialspecs(d,2));
plot(rectangle('Facecolor','k','Position',[xvaluesB(a),yvaluesB(a),sqrt(squaresizes(a,2)),sqrt(squaresizes(a,2))]))
sizesave (a,c,d) = squaresizes(a,c);
end;

seperator = zeros(2,2);
seperator = [trialspecs(d,1)+12,0; trialspecs(d,1)+12, trialspecs(d,1)+12];
line(seperator(2,:), seperator(1,:),'Color','black');
%zoom on
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