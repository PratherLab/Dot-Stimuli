
% Prather Lab Computer 
% Number Comparison script
% JPG version
% 10.14.15


%----------------------------------------------------------------------
% GENERAL SET UP   
%----------------------------------------------------------------------
 close all;
clear all;
sca;
Screen('Preference', 'SkipSyncTests', 2 ); %if you get SYNC errors this will skip the test by setting value at 2. 1 or critical only, 0 for all

prompt = {'Enter Date:','Enter Subject Number:'};
dlg_title = 'Input';
num_lines = 1;  
info = inputdlg(prompt,dlg_title,num_lines);
date = info(1,1); %cell of the date to be used in file name
subnum = info(2,1); %cell of subject number

%PsychDefaultSetup(2); % Here we call some default settings for setting up Psychtoolbox
respToBeMade = true;
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow'); 
rightKey = KbName('RightArrow');



%--------------
% STIM SET UP
%-------------

dur=3; %sets duration of trial dispay in seconds
screenNumber = max(Screen('Screens'));

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);


% Open an on screen window
PsychImaging('PrepareConfiguration');
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black, [], 32, 2);


% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

%screenXpixels = 1440; %or you can set this automatically if known
%screenYpixels = 900;
%Ling computer 1024 x 760

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

 %Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%---------------
% INSTRUCTIONS/WAIT STREEN
%---------------------

%Open an on screen window and color it grey
PsychImaging('PrepareConfiguration');

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

[xCenter, yCenter] = RectCenter(windowRect); %get center point

%Instructions
line1 = 'Select which side has more objects';
line2 = '\n Use LEFT and RIGHT arrow keys ';
line3 = '\n\n Press ANY key to begin a short practive';

Screen('TextSize', window, 50);
DrawFormattedText(window, [line1 line2 line3],...
    'center', screenYpixels * 0.25, white);
% Flip to the screen
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the instructions
KbStrokeWait;

%------------------
%Practice Loop
%----------------
practrials = 5;
cd /Users/richardprather/Dropbox/Rich/PratherLab/backup/Modeling/Matlab ;
% get all images (here all *.jpg found in the current directory, but you can specify the format you want)
MyImages = dir(fullfile(pwd,'*.png'));


for trial = 1:practrials
respToBeMade = true; % may need this

% Here we load in an image from file. This one is a image of rabbits that
% is included with PTB

% generate a random number between 1 and the number of images
RandomNumber = randi([1 size(MyImages,1)]);

% get the corresponding name of the image   
theImage = imread(MyImages(RandomNumber).name);

% Get the size of the image 
[s1, s2, s3] = size(theImage); 

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

%----------------------------------------------------------------------
%DISPLAY
%----------------------------------------------------------------------

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen. We first draw the
% image in its correct orientation.


% Wait for two seconds
Screen('DrawDots', window, [xCenter; yCenter], 10, white, [], 2);
Screen('Flip', window); 
WaitSecs(1);  

Screen('DrawTexture', window, imageTexture, [], [], 0);

% Flip to the screen
Screen('Flip', window);


% Wait for pt two seconds
 WaitSecs(.2);

% take keyboard input and write to a file 

%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key

tStart = GetSecs;
while respToBeMade == true

[keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            return
        elseif keyCode(leftKey)
            response = 1;
            respToBeMade = false;
            
        elseif keyCode(rightKey)
            response = 2;
            respToBeMade = false;
            
        end
end


    WaitSecs(.3);
end

%Instructions
line1 = 'Practice Trails done';
line2 = '\n Remember to Use LEFT and RIGHT arrow keys ';
line3 = '\n\n Press ANY key to begin the task';

Screen('TextSize', window, 50);
DrawFormattedText(window, [line1 line2 line3],...
    'center', screenYpixels * 0.25, white);
% Flip to the screen
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the instructions
KbStrokeWait;



%----------------------------
%Trial Loop
%----------------------------
numTrials =  3    ; %90
respMat = zeros(3,numTrials); %Matrix to collect responses
trialname = cell(1,numTrials); 
trialspecs = zeros(3,numTrials); %Matrix to note trial specs
triggers = zeros(2,numTrials);

%cd /Users/richardprather/Dropbox/Rich/PratherLab/backup/Modeling/Matlab ;
% get all images (here all *.jpg found in the current directory, but you can specify the format you want)
%MyImages = dir(fullfile(pwd,'*.png'));

%pwd is current folder

%EEG TRigger config
%par.di = DaqDeviceIndex; % the DaqDeviceIndex function returns the index of the port assigned to the daq device so you can refer to it in the rest of your script
%DaqDConfigPort(par.di,1,0); % this configures the daq port to either send output or receive input. the first number refers to which port of the daq device, A (0) or B (1). The second number refers to output (0) or input (1)
%DaqDOut(par.di,1,0); % this zeros out the trigger line to get started

  

  
for trial = 1:numTrials
respToBeMade = true; % may need this

% Here we load in an image  from file. This one is a image of rabbits that
% is included with PTB


% generate a random number between 1 and the number of images
%RandomNumber = randperm([siz e(MyImages,1)]);

% get the corresponding name of the image   
theImage = imread(MyImages(RandomNumber).name);

% Get the size of the image 
[s1, s2, s3] = size(theImage); 

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);



%----------------------------------------------------------------------
%DISPLAY
%----------------------------------------------------------------------

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen. We first draw the
% image in its correct orientation.


% Wait for two seconds
Screen('DrawDots', window, [xCenter; yCenter], 10, white, [], 2);
Screen('Flip', window); 
WaitSecs(1);  

Screen('DrawTexture', window, imageTexture, [], [], 0);

% Flip to the screen
Screen('Flip', window);
currentTrigger = RandomNumber;
%DaqDOut(par.di,1,currentTrigger); %Turn trigger on
%DaqDOut(par.di,1,123)
triggers(trial,1) = currentTrigger;
triggers(trial,2) = currentTrigger; %response trigger
% Wait for pt two seconds
 WaitSecs(.2);



% take keyboard input and write to a file 

%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key

tStart = GetSecs;
while respToBeMade == true

[keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            return
        elseif keyCode(leftKey)
            response = 1;
            respToBeMade = false;
            %DaqDOut(par.di,1,0); %Turn trigger off
        elseif keyCode(rightKey)
            response = 2;
            respToBeMade = false;
            %DaqDOut(par.di,1,0); %Turn trigger off
        end
end

tEnd = GetSecs;
    rt = tEnd - tStart;
    respMat(1, trial) = rt;
    respMat(2, trial) = response;
    respMat(3, trial) = currentTrigger;
    trialname{trial,1} = char(getfield(MyImages,{RandomNumber},'name'));
    
    WaitSecs(.3);
end

%concatinate tbt + date + sub
s = strcat('tbt',date,'_',subnum,'.csv');
s = char(s);
csvwrite([s],respMat);

% TERMINATE
 
sca;
