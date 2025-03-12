

uiwait(msgbox('Open our awesome game?'));




%figure for game
scrsz = get(groot, 'ScreenSize');
MAIN = figure ('Position', scrsz, 'Color',[0,1,1]);
% left to right, bottom to top, width, height
% color: RGB

%%
%figure for game modes

gmback_color = [0.839,0.733,0.941];
game_mode = figure ('Units', 'normalized','Position', [.16, .16, .7, .7], 'Color', gmback_color);

%Text code
TextType = uicontrol ('Style','text', 'Units','normalized', 'Position',[.265,.5,.5,.3],...
    'String', 'WHICH GAME MODE WOULD YOU LIKE TO PLAY?', 'Backgroundcolor',gmback_color,...
    'FontSize',28, 'FontWeight','bold', 'ForegroundColor',[1,1,1], 'FontUnits','normalized');

%testing puppy image (you could draw something for it)
image_1 = imread('puppy_image.jpg');
% 'CData',image_1


% Button on the right
five_normal = uicontrol('Style','pushbutton', 'Units', 'normalized','Position', [.08, .1, .3, .5],...
     'UserData','five_normal');

% Button on the left
timecha = uicontrol('Style','pushbutton', 'Units', 'normalized','Position', [.62, .1, .3, .5],...
     'UserData','timecha');

StartGame = uicontrol('Style','pushbutton', 'Units','normalized',...
        'Position', [.265, .15, .14, .12], 'Visible','off');

set(five_normal, 'Callback', {@user_mode, five_normal, timecha, StartGame});
set(timecha, 'Callback', {@user_mode, five_normal, timecha, StartGame});

% Button function
function user_mode (button, event, five_normal, timecha, StartGame)

% Allows for switch between buttons
if strcmpi(button.UserData, 'five_normal')
    five_normal.Enable = 'on';
    timecha.Enable = 'off';
    StartGame.String = 'START';
    StartGame.Visible = 'on';


elseif strcmpi(button.UserData, 'timecha')
    five_normal.Enable = 'off';
    timecha.Enable = 'on';
    StartGame.String = 'START';
    StartGame.Visible = 'on';
    
else 
    fprintf('shouldn''t happen, error')
end
end

