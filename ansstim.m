%SQUARE SET STIMULUS CREATOR FOR ANS TASKS

%SQUARE SIZE Matrix
% every set will be the same total area (100) fist thing is to take a
% standard largest square from that (10) as the fist object. The remaining
% objects are then paied together (must be even) and then via random number
% generator each pair will be increased/reduced by some percent. that way
% the total area remains the same, and is psuedorandomly distributed.

%need to calculate size of biggest sq based on sum of two compariosons, for
%example if 25 and 21, add them divide by two times total area and then add
%maybe about 15%
clear;
trials = zeros(40,2);
%[trials] = xlsread('ansstim.xls', 1) %reads in the numbers from xcel file
load /Users/richardprather/Dropbox/Rich/PratherLab/Tasks/DotComparison/ansstim.mat %saved trials as matlab data file
% tbterpstim.mat

squaresizes = zeros (150,2); %sizes for all the items max items 150
 %number of items in this stimulus, must be odd
totalarea = 100; %somewhat arbitrary

locationsave = zeros (150,2,40);
sizesave = zeros (150,2,20);
perimeters = zeros (40,2);


trialnames = cell(40,2);
load /Users/richardprather/Dropbox/Rich/PratherLab/Tasks/DotComparison/trialnames.mat

for d=1:40 %for each set of comparison stims, currently at 1:40 for all x:x for X

bigsquare = ((2*totalarea)/(trials(d,1) + trials(d,2)))*1.7; %size of big square

squaresizes(1,1) = bigsquare;

squaresizes(1,2) = bigsquare;
averagearea1 = totalarea / (trials(d,1) - 1);
averagearea2 = totalarea / (trials(d,2) - 1);

pairs1 = (trials(d,1) - 1)/2;
pairs2 = (trials(d,2) - 1)/2;

for a=1:pairs1
    
    adjustment = rand()*.1; %random value between 0 and .1
    squaresizes((2*a),1) = averagearea1*(1 + adjustment);
    squaresizes((2*a+1),1) = averagearea1 * (1 - adjustment);
    
end;

for a=1:pairs2
    
adjustment = rand()*.1; %random value between 0 and .1
    squaresizes((2*a),2) = averagearea2*(1 + adjustment);
    squaresizes((2*a+1),2) = averagearea2 * (1 - adjustment);

end;


squaresizes = squaresizes/squaresizes(1,1);

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

for c =1:2 % set to 2
    
figure('Position',[400,900,700,700])
xlim([0,trials(d,c)+3]) %should the upper limit be associated with the value being presented
ylim([0,trials(d,c)+3])
axis off
zoom on
%figure('visible','off')
hold on

xvalues = randperm(trials(d,c));
yvalues = randperm(trials(d,c)); %right now this needs to be scaled with the max number of dots


for a=1:(trials(d,c));
    (rectangle('Facecolor','k','Position',[xvalues(a),yvalues(a),sqrt(squaresizes(a,c)),sqrt(squaresizes(a,c))]))
sizesave (a,c,d) = squaresizes(a,c);
end;

%Save locations and sizes of squares



%Save figure as a PNG file
%set(gcf, 'PaperUnits', 'inches');
%set(gcf, 'PaperSize', [11 8.5]);
%set(gcf, 'PaperPositionMode', 'manual');
%set(gcf, 'PaperPosition', [0 0 7 7]);

%print(gcf,'-dpng','-r300',trialnames{d,c});
    %save each made figure as seperate pdf file
close;
end;

end;