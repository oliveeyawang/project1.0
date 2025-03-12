

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

TextType = uicontrol ('Style','text', 'Units','normalized', 'Position',[.265,.5,.5,.3],...
    'String', 'WHICH GAME MODE WOULD YOU LIKE TO PLAY?', 'Backgroundcolor',gmback_color);
five_normal = uicontrol('Style','pushbutton', 'Units', 'normalized','Position', [.05, .1, .3, .2])
timecha = uicontrol('Style','pushbutton', 'Units', 'normalized','Position', [.65, .1, .3, .2])
