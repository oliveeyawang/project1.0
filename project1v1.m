
scrsz = get(groot, 'ScreenSize');

banana_milk = [1,0.831,0.431];

muted_per = [0.698, 0.318, 0.169];

tan_orange = [0.925, 0.624, 0.169];

green = [0.349, 0.8, 0.02];

start_screen = figure('Position', scrsz, 'Color', [1, 1, 1], 'Name', 'Start Screen', 'NumberTitle', 'off');

axes('Position', [0.3, 0.5, 0.4, 0.3]); 
img = imread('puppy_image.jpg');
imshow(img);


uicontrol('Style', 'text', ...
    'String', 'WELCOME TO', ...
    'Units', 'normalized', ...
    'Position', [0.2, 0.7, 0.3, 0.1], ... 
    'FontSize', 24, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', [1, 1, 1]);



uicontrol('Style', 'pushbutton', ...
    'String', 'Play Our Awesome Game!', ...
    'Units', 'normalized', ...
    'Position', [0.38, 0.2, 0.26, 0.08], ...
    'FontSize', 20, ...
    'FontWeight', 'bold', ...
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
puppy_image = imread('puppy_image.jpg');
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



set(five_normal, 'Callback', {@user_mode, five_normal, timecha, StartGame, scrsz});
set(timecha, 'Callback', {@user_mode, five_normal, timecha, StartGame, scrsz});

% Button function
function user_mode (button, ~, five_normal, timecha, StartGame, scrsz)

% Allows for switch between buttons
if strcmpi(button.UserData, 'five_normal')
    five_normal.Enable = 'on';
    timecha.Enable = 'on';
    StartGame.String = 'Ready!';
    StartGame.Visible = 'on';

   set(StartGame, 'Callback', @(src, event) create_mode_screen('Five Normal', scrsz));

elseif strcmpi(button.UserData, 'timecha')
    five_normal.Enable = 'on';
    timecha.Enable = 'on';
    StartGame.String = 'START';
    StartGame.Visible = 'on';

    set(StartGame, 'Callback', @(src, event) create_mode_screen('Time Challenge', scrsz));
    
else 
    fprintf('shouldn''t happen, error')
end
end

function create_mode_screen(mode, scrsz)
    % Close previous figure
    close all;

    % Create the figure for the selected game mode
    mode_screen = figure('Position', scrsz);

    % Set the title based on the selected mode
    uicontrol('Style', 'text', 'String', [mode ' Mode'], 'FontSize', 30, 'Position', [0.4, 0.5, 0.2, 0.2]);

    % Customize the figure for the selected game mode here
    % Example: add game logic, buttons, etc.
    % You can add the game interface here (e.g., text, buttons, etc.)
    % Just as a placeholder:
    uicontrol('Style', 'pushbutton', 'String', ['Start ' mode], 'FontSize', 20, 'Position', [0.4, 0.4, 0.2, 0.1]);
end
