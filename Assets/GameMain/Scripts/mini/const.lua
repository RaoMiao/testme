function SetGlobal() --设置游戏内部使用的全程变量
    JY={};
    JY.SPD=1;
    JY.Status=GAME_START --游戏当前状态
    JY.WAIT=0; --延时
    JY.TEXT={[1]=""} --显示文本
    JY.CURRENT_COLOR=M_White; --当前文本颜色
    JY.TEXT_COLOR={[1]={[1]={s=1,c=JY.CURRENT_COLOR}}} --文本颜色
    JY.TEXT_BUFF="" --待显示文本
    JY.HELPINDEX=0
    JY.CENTER_MSG="";
    JY.EFT1=0;
    JY.EFT2=0;
    JY.pid=0;
    JY.eid=0;
    JY.info={}; --战斗信息
    JY.co_fight=nil;
    JY.co_learn=nil;
    JY.co_auto=nil;
    JY.bt={};
    JY.current=0;
    JY.hold=false;
    JY.KF_CURRENT_PAGE=0;
    JY.KF_MAX_PAGE=0;
    JY.LEARN_KFID=0;
    JY.LOG_CURRENT_PAGE=0;
    JY.LOG_MAX_PAGE=0;
    JY.PersonStatusPage=0;
    JY.Leaving={}; 
    --保存R×数据
    JY.Base={}; --基本数据
    JY.PersonNum=0; --人物个数
    JY.Person={}; --人物数据
    JY.ForceNum=0; --人物个数
    JY.Force={}; --人物数据
    JY.MapNum=0; --场景个数
    JY.Map={}; --场景数据
    JY.ItemNum=0; --道具个数
    JY.Item={}; --道具数据
    JY.KungfuNum=0; --武功个数
    JY.Kungfu={}; --武功数据
    JY.SkillNum=0; --招式个数
    JY.Skill={}; --招式数据
    JY.LingwuNum=0; --领悟个数
    JY.Lingwu={}; --领悟数据
    JY.Name={};
    JY.SubMap=-1; --当前子场景编号
    JY.SubMapX=0; --子场景显示位置偏移，场景移动指令使用
    JY.SubMapY=0;
   
    JY.Darkness=0; --=0 屏幕正常显示，=1 不显示，屏幕全黑
   
    JY.MmapMusic=-1; --切换大地图音乐，返回主地图时，如果设置，则播放此音乐
   
    JY.CurrentBGM=-1; --当前播放的音乐id，用来在关闭音乐时保存音乐id．
    JY.EnableMusic=1; --是否播放音乐 1 播放，0 不播放
    JY.EnableSound=1; --是否播放音效 1 播放，0 不播放
    
    JY.Dark=true;
end

function SetGlobalConst()
    GAME_VER="6.10";
    -- 游戏状态定义
    GAME_START =0 --开始画面,各种选单
    GAME_AUTO =1; --
    GAME_FIGHT =2; --
    GAME_LEARN =3; --
    GAME_WMAP =4; --
    GAME_WMAP2 =5; --
    GAME_DEAD =6; --
    GAME_END =7; --
    GAME_WARWIN =8; --
    GAME_WARLOSE =9; --
    -- SDL 键码定义，这里名字仍然使用directx的名字
    VK_ESCAPE=27
    VK_Y=121
    VK_N=110
    VK_SPACE=32
    VK_RETURN=13
   
    SDLK_UP=273
    SDLK_DOWN=274
    SDLK_LEFT=276
    SDLK_RIGHT=275
   
    if CONFIG.Rotate==0 then
    VK_UP=SDLK_UP;
    VK_DOWN=SDLK_DOWN;
    VK_LEFT=SDLK_LEFT;
    VK_RIGHT=SDLK_RIGHT;
    else --右转90度
    VK_UP=SDLK_RIGHT;
    VK_DOWN=SDLK_LEFT;
    VK_LEFT=SDLK_UP;
    VK_RIGHT=SDLK_DOWN;
    end
   
    -- 游戏中颜色定义
    C_STARTMENU=RGB(132, 0, 4) -- 开始菜单颜色
    C_RED=RGB(216, 20, 24) -- 开始菜单选中项颜色
   
    C_WHITE=RGB(236, 236, 236); --游戏内常用的几个颜色值
    C_ORANGE=RGB(252, 148, 16);
    C_GOLD=RGB(236, 200, 40);
    C_BLACK=RGB(0,0,0);
    
    M_Black=RGB(0,0,0);
    M_Sienna=RGB(160,82,45);
    M_DarkOliveGreen=RGB(85,107,47);
    M_DarkGreen=RGB(0,100,0);
    M_DarkSlateBlue=RGB(72,61,139);
    M_Navy=RGB(0,0,128);
    M_Indigo=RGB(75,0,130);
    M_DarkSlateGray=RGB(47,79,79);
    M_DarkRed=RGB(139,0,0);
    M_DarkOrange=RGB(255,140,0); --(239,101,0)
    M_Olive=RGB(128,128,0);
    M_Green=RGB(0,128,0);
    M_Teal=RGB(0,128,128);
    M_Blue=RGB(0,0,255);
    M_SlateGray=RGB(112,128,144);
    M_DimGray=RGB(105,105,105);
    M_Red=RGB(255,0,0);
    M_SandyBrown=RGB(244,164,96);
    M_YellowGreen=RGB(154,205,50);
    M_SeaGreen=RGB(46,139,87);
    M_MediumTurquoise=RGB(72,209,204);
    M_RoyalBlue=RGB(65,105,225);
    M_Purple=RGB(128,0,128);
    M_Gray=RGB(128,128,128);
    M_Magenta=RGB(255,0,255);
    M_Orange=RGB(255,165,0);
    M_Yellow=RGB(255,255,0);
    M_Lime=RGB(0,255,0);
    M_Cyan=RGB(0,255,255);
    M_DeepSkyBlue=RGB(0,191,255);
    M_DarkOrchid=RGB(153,50,204);
    M_Silver=RGB(192,192,192);
    M_Pink=RGB(255,192,203);
    M_Wheat=RGB(245,222,179);
    M_LemonChiffon=RGB(255,250,205);
    M_PaleGreen=RGB(152,251,152);
    M_PaleTurquoise=RGB(175,238,238);
    M_LightBlue=RGB(173,216,230);
    M_Plum=RGB(221,160,221);
    M_White=RGB(255,255,255);
    
    C_Name=RGB(255,207,85);
   
    --游戏数据全局变量
    CC={}; --定义游戏中使用的常量，这些可以在修改游戏时修改之
    CC.Debug=0;
    CC.FPS=false;
    CC.PASCODE= { 
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
    ".","\\","?","*","+","-",
    }
    --config
    CC.FontType=0;
    CC.MusicVolume=CONFIG.MusicVolume;
    CC.SoundVolume=CONFIG.SoundVolume
    
    CC.SrcCharSet=0; --源代码的字符集 0 gb 1 big5，用于转换R×。 如果源码被转换为big5，则应设为1
    CC.OSCharSet=CONFIG.OSCharSet; --OS 字符集，0 GB, 1 Big5
    CC.FontName=CONFIG.FontName; --显示字体
   
    CC.ScreenW=CONFIG.Width; --显示窗口宽高
    CC.ScreenH=CONFIG.Height;
   
    --定义记录文件名。S和D由于是固定大小，因此不再定义idx了。
    CC.R_IDXFilename={[0]=CONFIG.DataPath .. "newgame.idx",
    CONFIG.DataPath .. "r1.idx",
    CONFIG.DataPath .. "r2.idx",
    CONFIG.DataPath .. "r3.idx",
    CONFIG.DataPath .. "r4.idx",
    CONFIG.DataPath .. "r5.idx",};
    CC.R_GRPFilename={[0]=CONFIG.DataPath .. "newgame.grp",
    CONFIG.DataPath .. "ESAVE0.grp",
    CONFIG.DataPath .. "ESAVE1.grp",
    CONFIG.DataPath .. "ESAVE2.grp",
    CONFIG.DataPath .. "ESAVE3.grp",
    CONFIG.DataPath .. "ESAVE4.grp",
    CONFIG.DataPath .. "ESAVE5.grp",
    CONFIG.DataPath .. "ESAVE6.grp",
    CONFIG.DataPath .. "ESAVE7.grp",
    CONFIG.DataPath .. "ESAVE8.grp",
    CONFIG.DataPath .. "ESAVE9.grp",};
    CC.S_Filename={[0]=CONFIG.DataPath .. "allsin.grp",
    CONFIG.DataPath .. "s1.grp",
    CONFIG.DataPath .. "s2.grp",
    CONFIG.DataPath .. "s3.grp",};
   
    CC.TempS_Filename=CONFIG.DataPath .. "allsinbk.grp";
   
    CC.D_Filename={[0]=CONFIG.DataPath .. "alldef.grp",
    CONFIG.DataPath .. "d1.grp",
    CONFIG.DataPath .. "d2.grp",
    CONFIG.DataPath .. "d3.grp",};
   
    CC.PaletteFile=CONFIG.DataPath .. "mmap.col";
    CC.SavedataFile=CONFIG.DataPath .. "savedata.grp";
    CC.MapFile=CONFIG.DataPath .. "HEXZMAP.R3";
    CC.FirstFile=CONFIG.PicturePath .. "title.png";
    CC.DeadFile=CONFIG.PicturePath .. "dead.png";
   
    CC.MMapFile={CONFIG.DataPath .. "earth.002",
    CONFIG.DataPath .. "surface.002",
    CONFIG.DataPath .. "building.002",
    CONFIG.DataPath .. "buildx.002",
    CONFIG.DataPath .. "buildy.002"};
   
    --各种贴图文件名。
    CC.MMAPPicFile={CONFIG.DataPath .. "mmap.idx",CONFIG.DataPath .. "mmap.grp"};
    CC.SMAPPicFile={CONFIG.DataPath .. "smap.idx",CONFIG.DataPath .. "smap.grp"};
    CC.WMAPPicFile={CONFIG.DataPath .. "wmap.idx",CONFIG.DataPath .. "wmap.grp"};
    CC.EFT={CONFIG.DataPath .. "eft.idx",CONFIG.DataPath .. "eft.grp"};
   
    CC.HeadPicFile={CONFIG.DataPath .. "hdgrp.idx",CONFIG.DataPath .. "hdgrp.grp"};
    CC.UIPicFile={CONFIG.DataPath .. "ui.idx",CONFIG.DataPath .. "ui.grp"};
   
   
    CC.BGMFile=CONFIG.SoundPath .. "M%02d.mp3";
    CC.ATKFile=CONFIG.SoundPath .. "Atk%02d.wav";
    CC.EFile=CONFIG.SoundPath .. "Se%02d.wav";
   
    CC.WarFile=CONFIG.DataPath .. "war.sta";
    CC.WarMapFile={CONFIG.DataPath .. "warfld.idx",
    CONFIG.DataPath .. "warfld.grp"};
   
    CC.TalkIdxFile=CONFIG.ScriptPath .. "oldtalk.idx";
    CC.TalkGrpFile=CONFIG.ScriptPath .. "oldtalk.grp";
   
    
    
    --定义记录文件R×结构。 lua不支持结构，无法直接从二进制文件中读取，因此需要这些定义，用table中不同的名字来仿真结构。
    CC.TeamNum=16; --队伍人数
    CC.MyThingNum=400 --主角物品数量
    CC.Kungfunum=5 --角色武功数量
    CC.MaxKungfuNum=80
    CC.Base_S={}; --保存基本数据的结构，以便以后存取
    CC.Base_S["名称"]={0,2,14}; --nouse
    CC.Base_S["章节名"]={14,2,14}; --章节名
   CC.Base_S["数据版本号"]={28,2,14}; --数据版本号
    CC.Base_S["Seed"]={42,0,4};
       CC.Base_S["BossTimer"]={52,0,2};
       CC.Base_S["MaxSPD"]={54,0,2};
    CC.Base_S["无用"]={56,2,14}; --nouse
    CC.Base_S["无用1"]={70,2,14};
    CC.Base_S["下个场景"]={84,0,2};
    CC.Base_S["当前地图"]={86,0,2};
    CC.Base_S["当前场景"]={88,0,2};
    CC.Base_S["当前音乐"]={90,0,2};
    CC.Base_S["当前事件"]={92,0,2};
    CC.Base_S["武将数量"]={94,0,2};
    CC.Base_S["相性"]={96,0,2};
    CC.Base_S["指令"]={98,0,2};
    CC.Base_S["时"]={100,0,2} -- 起始位置(从0开始)，数据类型(0有符号 1无符号，2字符串)，长度
    CC.Base_S["分"]={102,0,2};
    CC.Base_S["秒"]={104,0,2};
    CC.Base_S["节"]={106,0,2};
    CC.Base_S["倒计时"]={108,0,2};
    CC.Base_S["力量"]={110,0,2};
    CC.Base_S["自由属性点"]={112,0,2};
    CC.Base_S["体力"]={114,0,2};
    CC.Base_S["实战"]={116,0,4};
    CC.Base_S["潜能"]={120,0,4};
    CC.Base_S["黄金"]={124,0,4};
    CC.Base_S["膂力成长"]={128,0,2};
    CC.Base_S["根骨成长"]={130,0,2};
    CC.Base_S["机敏成长"]={132,0,2};
    CC.Base_S["悟性成长"]={134,0,2};
    CC.Base_S["福缘成长"]={136,0,2};
    CC.Base_S["生命成长"]={138,0,2};
    CC.Base_S["内力成长"]={140,0,2};
    CC.Base_S["膂力加值"]={142,0,2};
    CC.Base_S["根骨加值"]={144,0,2};
    CC.Base_S["机敏加值"]={146,0,2};
    CC.Base_S["悟性加值"]={148,0,2};
    CC.Base_S["福缘加值"]={150,0,2};
    CC.Base_S["生命加值"]={152,0,2};
    CC.Base_S["内力加值"]={154,0,2};
    
    CC.Base_S["开启音乐"]={156,0,2};
    CC.Base_S["开启音效"]={158,0,2};
    CC.Base_S["修炼备选"]={160,0,2};
    CC.Base_S["自宫"]={162,0,2};
    
    CC.Base_S["基本伤害"]={190,0,2};
    CC.Base_S["基本命中"]={192,0,2};
    CC.Base_S["基本格挡"]={194,0,2};
    CC.Base_S["基本闪避"]={196,0,2};
    --统计信息
    CC.Base_S["战斗次数"]={200,0,4};
    CC.Base_S["胜利次数"]={204,0,4};
    CC.Base_S["攻击次数"]={208,0,4};
    CC.Base_S["命中次数"]={212,0,4};
    CC.Base_S["防御次数"]={216,0,4};
    CC.Base_S["格挡次数"]={220,0,4};
    CC.Base_S["闪避次数"]={224,0,4};
    CC.Base_S["睡觉次数"]={228,0,4};
    CC.Base_S["进食次数"]={232,0,4};
    CC.Base_S["思考次数"]={236,0,4};
    CC.Base_S["闭关次数"]={240,0,4};
    CC.Base_S["潜能合计"]={244,0,4};
    
    CC.Base_S["最大伤害"]={248,1,2};
    CC.Base_S["平均伤害"]={250,1,2};
    for i=1,10 do
    CC.Base_S["伤害"..i]={250+2*i,1,2};
    end
    CC.Base_S["最大命中"]={272,1,2};
    CC.Base_S["平均命中"]={274,1,2};
    for i=1,10 do
    CC.Base_S["命中"..i]={274+2*i,1,2};
    end
    CC.Base_S["最大格挡"]={296,1,2};
    CC.Base_S["平均格挡"]={298,1,2};
    for i=1,10 do
    CC.Base_S["格挡"..i]={298+2*i,1,2};
    end
    CC.Base_S["最大闪避"]={320,1,2};
    CC.Base_S["平均闪避"]={322,1,2};
    for i=1,10 do
    CC.Base_S["闪避"..i]={322+2*i,1,2};
    end
    for i=1,24 do 
    CC.Base_S["开启场景" .. i]={1762+2*(i-1),0,2};
    end
    for i=1,50 do
    CC.Base_S["开启称号" .. i]={1862+2*(i-1),0,2};
    end
    for i=1,50 do
    CC.Base_S["开启武器" .. i]={1962+2*(i-1),0,2};
    end
    for i=1,10000 do
    CC.Base_S["武功等级" .. i]={16160+2*i,0,2};
    end
    for i=1,10000 do
    CC.Base_S["武功经验" .. i]={36158+4*i,0,4};
    end
    
    --
    CC.PersonSize=126; --每个人物数据占用字节
    CC.Person_S={}; --保存人物数据的结构，以便以后存取
    CC.Person_S["代号"]={0,0,2,false} --true 实际存储 false 不存储
    CC.Person_S["头像"]={2,0,2,false}
    CC.Person_S["战斗动作"]={4,0,2,false}
    CC.Person_S["名称"]={6,2,14,false}
    CC.Person_S["外号"]={20,2,14,false}
    CC.Person_S["性别"]={34,0,2,false}
    CC.Person_S["等级"]={36,0,2,false}
    CC.Person_S["实战1"]={38,0,4,false}
    CC.Person_S["潜能1"]={42,0,4,false}
    CC.Person_S["生命"]={46,0,2,true}
    CC.Person_S["生命最大值"]={48,0,2,false}
    CC.Person_S["内力性质"]={50,0,2,false}
    CC.Person_S["内力"]={52,0,2,true}
    CC.Person_S["内力最大值"]={54,0,2,false}
    CC.Person_S["体力"]={56,0,2,false}
    CC.Person_S["名声"]={58,0,2,false}
    CC.Person_S["膂力"]={60,0,2,false}
    CC.Person_S["悟性"]={62,0,2,false}
    CC.Person_S["根骨"]={64,0,2,false}
    CC.Person_S["机敏"]={66,0,2,false}
    CC.Person_S["福缘"]={68,0,2,false}
    CC.Person_S["门派"]={70,0,2,false}
    CC.Person_S["位置"]={72,0,2,false}
    CC.Person_S["武功1"]={74,0,2,false}
    CC.Person_S["武功等级1"]={76,0,2,false}
    CC.Person_S["武功2"]={78,0,2,false}
    CC.Person_S["武功等级2"]={80,0,2,false}
    CC.Person_S["武功3"]={82,0,2,false}
    CC.Person_S["武功等级3"]={84,0,2,false}
    CC.Person_S["武功4"]={86,0,2,false}
    CC.Person_S["武功等级4"]={88,0,2,false}
    CC.Person_S["武功5"]={90,0,2,false}
    CC.Person_S["武功等级5"]={92,0,2,false}
    CC.Person_S["内功"]={94,0,2,false}
    CC.Person_S["内功等级"]={96,0,2,false}
    CC.Person_S["轻功"]={98,0,2,false}
    CC.Person_S["轻功等级"]={100,0,2,false}
    CC.Person_S["特技"]={102,0,2,false}
    CC.Person_S["特技等级"]={104,0,2,false}
    CC.Person_S["招架"]={106,0,2,true}
    CC.Person_S["招架等级"]={108,0,2,true}
    CC.Person_S["武器"]={110,0,2,false}
    CC.Person_S["掉宝1"]={112,0,2,false}
    CC.Person_S["掉宝2"]={114,0,2,false}
    CC.Person_S["掉宝3"]={116,0,2,false}
    CC.Person_S["掉宝4"]={118,0,2,false}
    CC.Person_S["掉宝5"]={120,0,2,false}
    CC.Person_S["掉落武器"]={122,0,2,false}
    CC.Person_S["图鉴"]={124,0,2,true}
    
    CC.ForceSize=68; --每个兵种数据占用字节
    CC.Force_S={}; --保存兵种数据的结构，以便以后存取
    CC.Force_S["代号"]={0,0,2}
    CC.Force_S["名称"]={2,2,14}
    CC.Force_S["地图1"]={16,0,2}
    CC.Force_S["地图2"]={18,0,2}
    CC.Force_S["地图3"]={20,0,2}
    CC.Force_S["地图4"]={22,0,2}
    CC.Force_S["地图5"]={24,0,2}
    CC.Force_S["地图6"]={26,0,2}
       for i=1,10 do
           CC.Force_S["前置地图"..i]={26+2*i,0,2}
           CC.Force_S["前置地图进度"..i]={46+2*i,0,2}
       end
    
    CC.MapSize=128; --每个场景数据占用字节
    CC.Map_S={}; --保存场景数据的结构，以便以后存取
    CC.Map_S["代号"]={0,0,2}
    CC.Map_S["图片"]={2,0,2}
    CC.Map_S["音乐"]={4,0,2}
    for i=1,20 do
    CC.Map_S["杂兵"..i]={4+2*i,0,2}
    end
    for i=1,10 do
    CC.Map_S["小Boss"..i]={44+2*i,0,2}
    end
    CC.Map_S["事件"]={66,0,2}
    for i=1,10 do
    CC.Map_S["通关Boss"..i]={66+2*i,0,2}
    CC.Map_S["战斗前剧情"..i]={86+2*i,0,2}
    CC.Map_S["战斗后剧情"..i]={106+2*i,0,2}
    end
    
    
       CC.ItemSize=264; --每个道具数据占用字节
       CC.Item_S={};
       CC.Item_S["代号"]={0,0,2}
       CC.Item_S["名称"]={2,2,14}
       CC.Item_S["说明"]={16,2,200}
       CC.Item_S["类型"]={216,2,14}
       CC.Item_S["生命"]={230,0,2}
       CC.Item_S["内力"]={232,0,2}
       CC.Item_S["伤害"]={234,0,2}
       CC.Item_S["命中"]={236,0,2}
       CC.Item_S["格挡"]={238,0,2}
       CC.Item_S["闪避"]={240,0,2}
       for i=1,6 do
           CC.Item_S["需武功"..i]={240+2*i,0,2}
       end
       CC.Item_S["需武功等级"]={254,0,2}
       CC.Item_S["需人物等级"]={256,0,2}
       CC.Item_S["需通过场景"]={258,0,2}
       CC.Item_S["需通过场景进度"]={260,0,2}
       CC.Item_S["暴率"]={262,0,2}
    
    
    
    CC.KungfuSize=490; --每个武功数据占用字节
    CC.Kungfu_S={}; --保存武功数据的结构，以便以后存取
    CC.Kungfu_S["代号"]={0,0,2}
    CC.Kungfu_S["名称"]={2,2,14}
    CC.Kungfu_S["武器"]={16,2,14}
    CC.Kungfu_S["说明"]={30,2,400}
    CC.Kungfu_S["类型"]={430,0,2}
    CC.Kungfu_S["类型描述"]={432,2,14}
    CC.Kungfu_S["Lv"]={446,0,2}
    CC.Kungfu_S["AP"]={448,0,2}
    CC.Kungfu_S["DP"]={450,0,2}
    CC.Kungfu_S["PP"]={452,0,2}
    CC.Kungfu_S["Damage"]={454,0,2}
    --CC.Kungfu_S["Def"]={440,0,2}
    CC.Kungfu_S["Hard"]={456,0,2}
    CC.Kungfu_S["音效"]={458,0,2}
    
    CC.Kungfu_S["生命"]={460,0,2}
    CC.Kungfu_S["内力"]={462,0,2}
    CC.Kungfu_S["伤害"]={464,0,2}
    CC.Kungfu_S["命中"]={466,0,2}
    CC.Kungfu_S["格挡"]={468,0,2}
    CC.Kungfu_S["闪避"]={470,0,2}
    CC.Kungfu_S["性别"]={480,0,2}
    CC.Kungfu_S["做梦"]={482,0,2}
    CC.Kungfu_S["修炼动画"]={484,0,2}
    CC.Kungfu_S["内力消耗"]={486,0,2}
    CC.Kungfu_S["暴率"]={488,0,2}
   
    CC.SkillSize=486; --每个招式数据占用字节
    CC.Skill_S={}; --保存招式数据的结构，以便以后存取
    CC.Skill_S["武功"]={0,0,2}
    CC.Skill_S["名称"]={2,2,14}
    CC.Skill_S["类型"]={16,2,14}
    CC.Skill_S["子类型"]={30,2,14}
    CC.Skill_S["等级"]={44,0,2}
    CC.Skill_S["性别"]={46,0,2}
    CC.Skill_S["等级1"]={48,0,2}
    CC.Skill_S["等级2"]={50,0,2}
    CC.Skill_S["AP"]={52,0,2}
    CC.Skill_S["Damage"]={54,0,2}
    CC.Skill_S["VsDP"]={56,0,2}
    CC.Skill_S["VsPP"]={58,0,2}
       for i=1,6 do
           CC.Skill_S["需武功"..i]={58+2*i,0,2}
           CC.Skill_S["忌武功"..i]={70+2*i,0,2}
       end
    CC.Skill_S["备用"]={84,0,2}
    CC.Skill_S["文本"]={86,2,400}
    
    CC.LingwuSize=32;
    CC.Lingwu_S={};
    CC.Lingwu_S["代号"]={0,0,2}
    CC.Lingwu_S["武功"]={2,0,2}
    CC.Lingwu_S["前置1"]={4,0,2}
    CC.Lingwu_S["前置2"]={6,0,2}
    CC.Lingwu_S["前置3"]={8,0,2}
    CC.Lingwu_S["前置4"]={10,0,2}
    CC.Lingwu_S["前置5"]={12,0,2}
    CC.Lingwu_S["前置6"]={14,0,2}
    CC.Lingwu_S["前置7"]={16,0,2}
    CC.Lingwu_S["等级1"]={18,0,2}
    CC.Lingwu_S["等级2"]={20,0,2}
    CC.Lingwu_S["等级3"]={22,0,2}
    CC.Lingwu_S["等级4"]={24,0,2}
    CC.Lingwu_S["等级5"]={26,0,2}
    CC.Lingwu_S["等级6"]={28,0,2}
    CC.Lingwu_S["等级7"]={30,0,2}
    
    CC.DX={[0]=2,-2,-2,2}; --不同方向x，y的加减值，用于走路改变坐标值
    CC.DY={[0]=-1,1,-1,1};
    --1,2,3,4 下 上 左 右
    CC.DirectX={0,0,-1,1}; --不同方向x，y的加减值，用于走路改变坐标值
    CC.DirectY={1,-1,0,0};
   
    CC.RowPixel=4 -- 每行字的间距像素数
   
    CC.MenuBorderPixel=5 -- 菜单四周边框留的像素数，也用于绘制字符串的box四周留得像素
    CC.MouseClickType=0; --0 满足1且2，1只检查初始点击位置， 2只检查最终释放位置
    CC.OpearteSpeed=4 --游戏操作反应速度
    CC.WarDelay=1 --战斗操作反应速度
    CC.FrameNum=50; --帧数
    CC.Exp={
    4,8,12,16,20,24,28,32,36,40,
    48,56,64,72,80,88,96,104,112,120,
    136,152,168,184,200,216,232,248,264,280,
    312,344,376,408,440,472,504,536,568,600,
    664,728,792,856,920,984,1048,1112,1176,1240,
    1368,1496,1624,1752,1880,2008,2136,2264,2392,2520,
    2776,3032,3288,3544,3800,4056,4312,4568,4824,5080,
    5592,6104,6616,7128,7640,8152,8664,9176,9688,10200,
    11224,12248,13272,14296,15320,16344,17368,18392,19416,20440,
    22488,24536,26584,28632,30680,32728,34776,36824,38872,99999,
    99999999,99999999,99999999,99999999,99999999,
    99999999,99999999,99999999,99999999,99999999,
    99999999,99999999,99999999,99999999,99999999,
    99999999,99999999,99999999,99999999,99999999,
    99999999,99999999,99999999,99999999,99999999,
    99999999,99999999,99999999,99999999,99999999,
    99999999,99999999,99999999,99999999,99999999,}
   end
   
   
   