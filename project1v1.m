
scrsz = get(groot, 'ScreenSize');

banana_milk = [1,0.831,0.431];

muted_per = [0.698, 0.318, 0.169];

tan_orange = [0.925, 0.624, 0.169];

green = [0.349, 0.8, 0.02];

%%%%%%%

%define screen size of the figure window
scrsz = get(0, 'ScreenSize'); 

%create a figure window with the screen size 
start_screen = figure('Position', scrsz, 'Color', [1, 1, 1], 'Name', 'Start Screen', 'NumberTitle', 'off');

%set axes position for displaying the GIF (can adjust as needed)
axes('Position', [0.3, 0.5, 0.4, 0.3]); 

%read the GIF and get its frames and colormap
[gifImage, map] = imread('anagram.gif', 'frames', 'all');  %testing anagram jpeg i drew pls lord work

%get dimensions of GIF
[gifHeight, gifWidth, ~,numFrames] = size(gifImage); 

%%%%%%%
uicontrol('Style', 'text', ...
    'String', 'WELCOME TO KIARA AND OLIVIA''S' , ...
    'Units', 'normalized', ...
    'Position', [0.25, 0.78, 0.5, 0.1], ... 
    'FontSize', 30, ...
    'FontWeight', 'bold', ...
    'FontName', 'Georgia', ...
    'BackgroundColor', [1,1,1]);


% Loop through the frames within GIF to display the GIF
    for k = 1:numFrames

    %display the current frame of the GIF
        imshow(gifImage(:,:,:,k), map);

    % Adjust the pause to control the speed of animation
        pause(0.2);  
    end

uicontrol('Style', 'pushbutton', ...
    'String', 'Game! (click here to start)', ...
    'Units', 'normalized', ...
    'Position', [0.38, 0.4, 0.26, 0.08], ...
    'FontSize', 20, ...
    'FontWeight', 'bold', ...
    'FontName', 'Georgia', ...
    'BackgroundColor', green, ...
    'Callback', @(src, event) uiresume(start_screen),...
    'ForegroundColor',[1,1,1]);

uiwait(start_screen);
close(start_screen);
% left to right, bottom to top, width, height
% color: RGB

%%
%figure for game modes


game_mode = figure ('Units', 'normalized','Position', [.16, .16, .7, .7], 'Color', banana_milk);

%Text code
TextType = uicontrol ('Style','text', 'Units','normalized', 'Position',[.265,.5,.5,.3],...
    'String', 'WHICH GAME MODE WOULD YOU LIKE TO PLAY?', 'Backgroundcolor',banana_milk,...
    'FontSize',28, 'FontWeight','bold', 'ForegroundColor',[1,1,1], 'FontUnits','normalized');

%testing puppy image (you could draw something for it)

% 'CData',image_1


% Button on the right
five_normal = uicontrol('Style','pushbutton', 'Units', 'normalized','Position', [.08, .1, .3, .5],...
     'UserData','five_normal');

% Button on the left
timecha = uicontrol('Style','pushbutton', 'Units', 'normalized','Position', [.62, .1, .3, .5],...
     'UserData','timecha');

StartGame = uicontrol('Style','pushbutton', 'Units','normalized',...
        'Position', [.41, .3, .18, .1], 'Visible','off', 'FontSize', 20, 'FontWeight', 'bold',...
        'ForegroundColor',[1,1,1], 'BackgroundColor',green);



set(five_normal, 'Callback', @(src, event) user_mode(src, five_normal, timecha, StartGame, scrsz, green));
set(timecha, 'Callback', @(src, event) user_mode(src, five_normal, timecha, StartGame, scrsz, green));

% Button function
function user_mode(button, five_normal, timecha, StartGame, scrsz, green)
    if strcmpi(button.UserData, 'five_normal')
        StartGame.String = 'Ready!'; % Update button text
        StartGame.Visible = 'on'; % Make the Start button visible
        % Set callback for Start button when mode is selected
        set(StartGame, 'Callback', @(src, event) create_mode_screen('Five Normal', scrsz, green));
    elseif strcmpi(button.UserData, 'timecha')
        StartGame.String = 'Ready!'; % Update button text
        StartGame.Visible = 'on'; % Make the Start button visible
        % Set callback for Start button when mode is selected
        set(StartGame, 'Callback', @(src, event) create_mode_screen('Time Challenge', scrsz, green));
    end
end

%% Function for Mode Screens
function create_mode_screen(mode, scrsz, green)
    % Close previous figure
    close all;

    % Create the figure for the selected game mode
    mode_screen = figure('Position', scrsz, 'Color', [1, 1, 1], 'Name', [mode ' Mode'], 'NumberTitle', 'off');

    % Display the mode name
    uicontrol('Style', 'text', ...
              'String', [mode ' Mode'], ...
              'Units', 'normalized', ...
              'Position', [0.4, 0.8, 0.2, 0.1], ...
              'FontSize', 30, ...
              'FontWeight', 'bold', ...
              'BackgroundColor', [1, 1, 1]);

    % Create the start button (will disappear after click)
    startButton = uicontrol('Style', 'pushbutton', ...
                            'String', ['Start ' mode], ...
                            'Units', 'normalized', ...
                            'Position', [0.4, 0.3, 0.2, 0.08], ...
                            'FontSize', 20, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [green], ...
                            'ForegroundColor', [1, 1, 1], ...
                            'Callback', @(src, event) start_game(mode, src)); % Pass handle to hide after click
end

%% Function for Starting Game
function start_game(mode, buttonHandle)
    disp([mode ' game started!']);
    
    % Hide the start button after clicking
    set(buttonHandle, 'Visible', 'off');
    
    % **Show input box ONLY for Time Challenge mode**
    if strcmp(mode, 'Time Challenge')
        uicontrol('Style', 'edit', ...
                  'Units', 'normalized', ...
                  'Position', [0.08, 0.7, 0.25, 0.08], ...
                  'FontSize', 18, ...
                  'BackgroundColor', [0.9, 0.9, 0.9], ...
                  'ForegroundColor', [0, 0, 0], ...
                  'Callback', @handle_input);
        uicontrol('Style', 'pushbutton', 'String', ['Start ' mode], 'FontSize', 20, 'Position', [0.4, 0.4, 0.2, 0.1]);
    end
end

%% Function to Handle Input (Example)
function handle_input(src, ~)
    userInput = get(src, 'String');
    disp(['User input: ' userInput]);
end
