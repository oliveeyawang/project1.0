

scrsz = get(groot, 'ScreenSize');

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

global banana_milk;
banana_milk = [1,0.831,0.431];

game_mode = figure ('Units', 'normalized','Position', [.16, .16, .7, .7], 'Color', banana_milk);

%Text code
TextType = uicontrol ('Style','text', 'Units','normalized', 'Position',[.265,.5,.5,.3],...
    'String', 'WHICH GAME MODE WOULD YOU LIKE TO PLAY?', 'Backgroundcolor',banana_milk,...
    'FontSize',28, 'FontWeight','bold', 'ForegroundColor',[1,1,1], 'FontUnits','normalized');



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
        set(StartGame, 'Callback', @(src, event) create_five_normal_screen(scrsz, green)); % Call Five Normal screen
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
    persistent valid_words; % Keep it in memory between calls
    
    if isempty(valid_words)
        fileID = fopen('words.txt', 'r');
        if fileID == -1
            error('Error opening the word file.');
        end
        valid_words = textscan(fileID, '%s');
        fclose(fileID);
        valid_words = valid_words{1};
    end
    
    userInput = lower(strtrim(get(src, 'String'))); % Clean input
    if ismember(userInput, valid_words)
        disp(['Valid word: ' userInput]);
    else
        disp('Invalid word. Try again.');
    end
end

%%
function create_five_normal_screen(scrsz, green)
    % Main figure
    mode_screen = figure('Position', scrsz, 'Color', [1, 1, 1], 'Name', 'Five Normal Mode', 'NumberTitle', 'off');
    
    % Create a structure to store drag information that persists between callbacks
    setappdata(mode_screen, 'drag_info', struct('dragging', false, 'source', [], 'start_position', []));
    
    % Letters to be placed in the tiles
    letter_tiles = {'A', 'B', 'C', 'D', 'E'};
    
    % Positioning for letter tiles
    tile_positions = [0.1, 0.7; 0.3, 0.7; 0.5, 0.7; 0.7, 0.7; 0.9, 0.7];
    
    % Create letter tiles
    for i = 1:length(letter_tiles)
        tile = uicontrol('Style', 'pushbutton', ...
            'String', letter_tiles{i}, ...
            'Units', 'normalized', ...
            'Position', [tile_positions(i, 1), tile_positions(i, 2), 0.1, 0.1], ...
            'FontSize', 16, ...
            'FontWeight', 'bold', ...
            'BackgroundColor', green, ...
            'ForegroundColor', [1, 1, 1], ...
            'Tag', ['tile_' num2str(i)]);
        
        % Use Callback instead of ButtonDownFcn
        set(tile, 'Callback', @(src, event) start_drag(src, mode_screen));
    end
    
    % Create slots for word placement
    slot_positions = [0.05, 0.3; 0.25, 0.3; 0.45, 0.3; 0.65, 0.3; 0.85, 0.3];
    
    for i = 1:5
        uicontrol('Style', 'edit', ...
            'Units', 'normalized', ...
            'Position', [slot_positions(i, 1), slot_positions(i, 2), 0.1, 0.1], ...
            'FontSize', 16, ...
            'BackgroundColor', [1, 1, 1], ...
            'Enable', 'inactive', ...
            'Tag', ['slot_' num2str(i)]);
    end
    
    % Add a submit button or other interface elements as needed
end

% Start dragging when tile is clicked
function start_drag(src, fig)
    % Get the drag_info structure from the figure
    drag_info = getappdata(fig, 'drag_info');
    
    % Set dragging flag to true and store the source object
    drag_info.dragging = true;
    drag_info.source = src;
    drag_info.start_position = get(src, 'Position');
    
    % Update the drag_info in the figure
    setappdata(fig, 'drag_info', drag_info);
    
    % Enable figure mouse tracking
    set(fig, 'WindowButtonMotionFcn', @(src, event) drag_tile(fig));
    set(fig, 'WindowButtonUpFcn', @(src, event) drop_tile(fig));
end

% Function to drag the tile with the mouse
function drag_tile(fig)
    % Get the drag_info structure
    drag_info = getappdata(fig, 'drag_info');
    
    if drag_info.dragging
        % Get current normalized mouse position
        current_point = get(fig, 'CurrentPoint');
        
        % Convert to normalized units if needed
        if ~strcmpi(get(fig, 'Units'), 'normalized')
            fig_pos = get(fig, 'Position');
            current_point = [current_point(1)/fig_pos(3), current_point(2)/fig_pos(4)];
        end
        
        % Update the position of the dragged tile
        set(drag_info.source, 'Position', [current_point(1) - 0.05, current_point(2) - 0.05, 0.1, 0.1]);
    end
end

% Function to drop the tile into a slot
function drop_tile(fig)
    % Get the drag_info structure
    drag_info = getappdata(fig, 'drag_info');
    
    if drag_info.dragging
        % Get the current position of the mouse
        current_point = get(fig, 'CurrentPoint');
        
        % Convert to normalized units if needed
        if ~strcmpi(get(fig, 'Units'), 'normalized')
            fig_pos = get(fig, 'Position');
            current_point = [current_point(1)/fig_pos(3), current_point(2)/fig_pos(4)];
        end
        
        % Check for a slot near the drop position
        slots = findobj(fig, 'Style', 'edit');
        placed = false;
        
        for i = 1:length(slots)
            slot_pos = get(slots(i), 'Position');
            
            % If the mouse position is close enough to the slot, place the tile there
            if current_point(1) >= slot_pos(1) && current_point(1) <= slot_pos(1) + slot_pos(3) && ...
               current_point(2) >= slot_pos(2) && current_point(2) <= slot_pos(2) + slot_pos(4)
                
                % Set the letter in the slot
                set(slots(i), 'String', get(drag_info.source, 'String'));
                
                % Make the original tile invisible or disable it
                set(drag_info.source, 'Visible', 'off');
                
                placed = true;
                break;
            end
        end
        
        % If not placed in a slot, return to original position
        if ~placed
            set(drag_info.source, 'Position', drag_info.start_position);
        end
        
        % Reset drag state
        drag_info.dragging = false;
        setappdata(fig, 'drag_info', drag_info);
        
        % Clear the motion and button up functions
        set(fig, 'WindowButtonMotionFcn', '');
        set(fig, 'WindowButtonUpFcn', '');
    end
end
