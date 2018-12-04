function PicCatchIni()
    lib.PicInit(CC.PaletteFile); --加载原来的256色调色板
    lib.PicLoadFile(CC.SMAPPicFile[1],CC.SMAPPicFile[2],0);
    lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],1);
    lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],11,75);
    lib.PicLoadFile(CC.EFT[1],CC.EFT[2],2);
    ButtonIni();
end
   
function ButtonIni()
    JY.bt={};
    local x,y;
    x,y=98,8; --属性
    JY.bt[1]={id=1,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="属性",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=true};
    x=x+87; --道具
    JY.bt[2]={id=2,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="武器",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=true};
    x=x+87; --成就
    JY.bt[3]={id=3,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="称号",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=true};
    x=x+87; --记录
    JY.bt[4]={id=4,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="战绩",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=true};
    
    y=y+40; --Boss
    x=JY.bt[1].x1;
    JY.bt[5]={id=5,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="Boss",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=false,show=true};
    x=x+87; --场景
    JY.bt[6]={id=6,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="场景",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=true};
    x=x+87; --设定
    JY.bt[7]={id=7,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="设定",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=true};
    x=x+87; --关闭
    JY.bt[8]={id=8,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=true};
    y=y+40; --加速
    JY.bt[10]={id=10,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="X1",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
   
    x=JY.bt[1].x1;
    x=x+87; 
   
   
    --人物属性界面 关闭按钮
    x,y=252,420;
    JY.bt[11]={id=11,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    --开启选择武功
    x,y=90+35,JY.bt[11].y1+4;
    JY.bt[12]={id=12,x1=x,y1=y,x2=x+62,y2=y+28,tx=x+31,ty=y+14,txt="武功",pic1=135,pic2=136,pic3=137,pic4=138,sp=0,enable=true,show=false};
    x,y=90-35,JY.bt[11].y1+4;
    JY.bt[16]={id=16,x1=x,y1=y,x2=x+62,y2=y+28,tx=x+31,ty=y+14,txt="统计",pic1=135,pic2=136,pic3=137,pic4=138,sp=0,enable=true,show=false};
    --地图选择界面 关闭按钮
    x,y=183,JY.bt[11].y1;
    JY.bt[13]={id=13,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    --战绩界面 关闭按钮
    x,y=183,JY.bt[11].y1;
    JY.bt[14]={id=14,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    --设定界面 关闭按钮
    x,y=183,JY.bt[11].y1;
    JY.bt[15]={id=15,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    --统计/成就界面 关闭按钮
    --称号选择界面 关闭按钮
    x,y=183,JY.bt[11].y1;
    JY.bt[17]={id=17,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    --武器选择界面 关闭按钮
    x,y=183,JY.bt[11].y1;
    JY.bt[18]={id=18,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="关闭",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    
    --人物属性初始化
    x,y=52,JY.bt[11].y1;
    JY.bt[31]={id=31,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="自动姓名",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=false};
    x=x+87;
    JY.bt[32]={id=32,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="手动更名",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=false};
    x=x+87;
    JY.bt[33]={id=33,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="重置属性",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,enable=true,show=false};
    x=x+87;
    JY.bt[34]={id=34,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="完成",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
    x,y=45+45,JY.bt[11].y1-272+34;
    JY.bt[35]={id=35,x1=x,y1=y,x2=x+64,y2=y+80,tx=x,ty=y,txt="",pic1=999,pic2=999,pic3=999,pic4=999,sp=0,enable=true,show=false};
    
    --设定 开启/关闭
    x,y=220,JY.bt[11].y1-230;
    JY.bt[81]={id=81,x1=x,y1=y,x2=x+70,y2=y+24,tx=x+36,ty=y+14,txt="开启",pic1=175,pic2=176,pic3=177,pic4=178,sp=0,enable=true,show=false};
    x=x+80;
    JY.bt[82]={id=82,x1=x,y1=y,x2=x+70,y2=y+24,tx=x+36,ty=y+14,txt="关闭",pic1=175,pic2=176,pic3=177,pic4=178,sp=0,enable=true,show=false};
    x,y=220,y+30;
    JY.bt[83]={id=83,x1=x,y1=y,x2=x+70,y2=y+24,tx=x+36,ty=y+14,txt="开启",pic1=175,pic2=176,pic3=177,pic4=178,sp=0,enable=true,show=false};
    x=x+80;
    JY.bt[84]={id=84,x1=x,y1=y,x2=x+70,y2=y+24,tx=x+36,ty=y+14,txt="关闭",pic1=175,pic2=176,pic3=177,pic4=178,sp=0,enable=true,show=false};
    x,y=220,y+30;
    JY.bt[85]={id=85,x1=x,y1=y,x2=x+70,y2=y+24,tx=x+36,ty=y+14,txt="开启",pic1=175,pic2=176,pic3=177,pic4=178,sp=0,enable=true,show=false};
    x=x+80;
    JY.bt[86]={id=86,x1=x,y1=y,x2=x+70,y2=y+24,tx=x+36,ty=y+14,txt="关闭",pic1=175,pic2=176,pic3=177,pic4=178,sp=0,enable=true,show=false};
    
    x,y=220+4,y+30;
    JY.bt[91]={id=91,x1=x,y1=y,x2=x+62,y2=y+28,tx=x+31,ty=y+14,txt="重生",pic1=135,pic2=136,pic3=137,pic4=138,sp=0,enable=true,show=false};
    
    --武功列表
    for i=1,8 do
    y=JY.bt[11].y1-262+29*i;
    x=194;
    JY.bt[100+i*2-1]={id=100+i*2-1,x1=x,y1=y,x2=x+98,y2=y+26,tx=x+49,ty=y+13,txt="",pic1=140,pic2=141,pic3=142,pic4=143,kfid=0,sp=0,enable=true,show=false};
    x=294;
    JY.bt[100+i*2]={id=100+i*2,x1=x,y1=y,x2=x+98,y2=y+26,tx=x+49,ty=y+13,txt="",pic1=140,pic2=141,pic3=142,pic4=143,kfid=0,sp=0,enable=true,show=false};
    end
    --上一页/下一页 武功
    x,y=200,JY.bt[11].y1-262;--,98;
    JY.bt[121]={id=121,x1=x,y1=y,x2=x+30,y2=y+30,tx=x+15,ty=y+15,txt="",pic1=150,pic2=151,pic3=152,pic4=153,sp=0,enable=false,show=false};
    x=356;
    JY.bt[122]={id=122,x1=x,y1=y,x2=x+30,y2=y+30,tx=x+15,ty=y+15,txt="",pic1=155,pic2=156,pic3=157,pic4=158,sp=0,enable=false,show=false};
    --上一页/下一页 LOG
    x,y=240,JY.bt[11].y1-266;--94;
    JY.bt[123]={id=123,x1=x,y1=y,x2=x+30,y2=y+30,tx=x+15,ty=y+15,txt="",pic1=150,pic2=151,pic3=152,pic4=153,sp=0,enable=false,show=false};
    x=368;
    JY.bt[124]={id=124,x1=x,y1=y,x2=x+30,y2=y+30,tx=x+15,ty=y+15,txt="",pic1=155,pic2=156,pic3=157,pic4=158,sp=0,enable=false,show=false};
    
    --自由加点
    x,y=350,JY.bt[11].y1-48;
    JY.bt[131]={id=131,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --福缘
    y=y-21;
    JY.bt[132]={id=132,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --悟性
    y=y-21;
    JY.bt[133]={id=133,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --机敏
    y=y-21;
    JY.bt[134]={id=134,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --根骨
    y=y-21;
    JY.bt[135]={id=135,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --膂力
    y=y-21*4;
    JY.bt[136]={id=136,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --内力
    y=y-21;
    JY.bt[137]={id=137,x1=x,y1=y,x2=x+18,y2=y+18,tx=x+11,ty=y+9,txt="+",pic1=165,pic2=166,pic3=167,pic4=168,sp=0,enable=false,show=false}; --生命
    
    --地图/称号列表
    for i=1,6 do
    y=JY.bt[11].y1-272+38*i;
    x=51;
    JY.bt[140+i*4-3]={id=140+i*4-3,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="",pic1=160,pic2=161,pic3=162,pic4=163,mapid=0,sp=0,enable=true,show=false};
    x=x+88;
    JY.bt[140+i*4-2]={id=140+i*4-2,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="",pic1=160,pic2=161,pic3=162,pic4=163,mapid=0,sp=0,enable=true,show=false};
    x=x+88;
    JY.bt[140+i*4-1]={id=140+i*4-1,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="",pic1=160,pic2=161,pic3=162,pic4=163,mapid=0,sp=0,enable=true,show=false};
    x=x+88;
    JY.bt[140+i*4]={id=140+i*4,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="",pic1=160,pic2=161,pic3=162,pic4=163,mapid=0,sp=0,enable=true,show=false};
    end
    
    --是/否
    x,y=137,310;
    JY.bt[198]={id=198,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="是",pic1=160,pic2=161,pic3=162,pic4=163,sp=0,event=0,enable=true,show=false};
    x=226;
    --退出
    JY.bt[199]={id=199,x1=x,y1=y,x2=x+84,y2=y+36,tx=x+42,ty=y+17,txt="否",pic1=130,pic2=131,pic3=132,pic4=133,sp=0,enable=true,show=false};
   end
   
   function ButtonEvent()
    JY.current=0;
    JY.HELPINDEX=0;
    JY.hold=false;
    for i,v in pairs(JY.bt) do
    if v.show then
    if v.enable then
    if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
    if v.id==1 then --属性
    PlayWavE(0);
    OpenPersonStatus();
    elseif v.id==2 then --武器
    PlayWavE(0);
    OpenWeaponList();
    elseif v.id==3 then --称号
    PlayWavE(0);
    OpenTitleList();
    --OpenRecord();
    elseif v.id==4 then --战绩
    PlayWavE(0);
    OpenLog();
    elseif v.id==5 then --Boss
    PlayWavE(0);
    JY.Base["当前事件"]=JY.Map[JY.Base["当前地图"]]["事件"];
    if JY.Base["当前事件"]>0 then
    JY.CENTER_MSG="** 即将挑战Boss **";
    end
    SetMainMenu();
    elseif v.id==6 then --场景
    PlayWavE(0);
    OpenMapList();
    elseif v.id==7 then --设定
    PlayWavE(0);
    OpenSetting();
    elseif v.id==8 then --退出
    PlayWavE(0);
    JY.bt[198].event=1;
    JY.bt[198].show=true;
    JY.bt[199].show=true;
    SetMainMenu();
    elseif v.id==10 then
       PlayWavE(0);
       JY.SPD=JY.SPD+1;
       if JY.SPD>JY.Base.MaxSPD then
           JY.SPD=1;
       end
       v.txt="X"..JY.SPD;
    elseif v.id==11 then
    PlayWavE(0);
    ClosePersonStatus();
    elseif v.id==12 then
    PlayWavE(0);
    if JY.PersonStatusPage==1 then
    CloseKungfuList();
    else
    OpenKungfuList();
    end
    elseif v.id==13 then
    PlayWavE(0);
    CloseMapList();
    elseif v.id==14 then
    PlayWavE(0);
    CloseLog();
    elseif v.id==15 then
    PlayWavE(0);
    CloseSetting();
    elseif v.id==16 then
    PlayWavE(0);
    if JY.PersonStatusPage==0 then
    JY.PersonStatusPage=2;
    elseif JY.PersonStatusPage==1 then
    CloseKungfuList();
    JY.PersonStatusPage=2;
    else
    JY.PersonStatusPage=0;
    end
    SetFreePoint();
    elseif v.id==17 then
    PlayWavE(0);
    CloseTitleList();
    elseif v.id==18 then
    PlayWavE(0);
    CloseWeaponList();
    elseif v.id==31 then
    PlayWavE(0);
    JY.Person[JY.pid]["名称"]=IniName();
    elseif v.id==32 then
    PlayWavE(0);
    for ii,vv in pairs({31,32,33,34,35}) do
    JY.bt[vv].enable=false;
    end
    local str=JY.Person[JY.pid]["名称"];
    local str2=JY.Person[JY.pid]["外号"];
    JY.Person[JY.pid]["名称"]="";
    JY.Person[JY.pid]["外号"]="";
    JY.CENTER_MSG="";
    JY.Person[JY.pid]["名称"]=Input(str);
    JY.CENTER_MSG="*1. 本游戏为放置类游戏, 基本不需要操作*2. 本游戏为自动存档, 每分钟自动保存*3. 选择不同的场景, 将面对强弱各异的对手*4. 人物等级上限为99级*5. 武功修炼完全随机, 等级上限为40级*6. 大武侠(dawuxia.net)祝游戏愉快*";
    JY.Person[JY.pid]["外号"]=str2;
    for ii,vv in pairs({31,32,33,34,35}) do
    JY.bt[vv].enable=true;
    end
    elseif v.id==33 then
    PlayWavE(0);
    ResetAttrib();
    elseif v.id==34 then
    PlayWavE(0);
    ClosePersonIni();
    elseif v.id==35 then
    PlayWavE(0);
    JY.Person[JY.pid]["头像"]=JY.Person[JY.pid]["头像"]+1;
    if JY.Person[JY.pid]["头像"]>85 then
    JY.Person[JY.pid]["头像"]=78;
    end
    elseif v.id==91 then
   
    PlayWavE(0);
    CloseSetting();
    JY.bt[198].event=2;
    JY.bt[198].show=true;
    JY.bt[199].show=true;
    SetMainMenu();
   
    elseif between(v.id,101,116) then
    SetKungfu(v.kfid);
    elseif v.id==121 then
    PlayWavE(0);
    JY.KF_CURRENT_PAGE=limitX(JY.KF_CURRENT_PAGE-1,1,JY.KF_MAX_PAGE);
    QueryKungfuList();
    JY.bt[121].enable=JY.KF_CURRENT_PAGE>1;
    JY.bt[122].enable=JY.KF_CURRENT_PAGE<JY.KF_MAX_PAGE;
    elseif v.id==122 then
    PlayWavE(0);
    JY.KF_CURRENT_PAGE=limitX(JY.KF_CURRENT_PAGE+1,1,JY.KF_MAX_PAGE);
    QueryKungfuList();
    JY.bt[121].enable=JY.KF_CURRENT_PAGE>1;
    JY.bt[122].enable=JY.KF_CURRENT_PAGE<JY.KF_MAX_PAGE;
    elseif v.id==123 then
    PlayWavE(0);
    JY.LOG_CURRENT_PAGE=limitX(JY.LOG_CURRENT_PAGE-1,1,JY.LOG_MAX_PAGE);
    JY.bt[123].enable=JY.LOG_CURRENT_PAGE>1;
    JY.bt[124].enable=JY.LOG_CURRENT_PAGE<JY.LOG_MAX_PAGE;
    elseif v.id==124 then
    PlayWavE(0);
    JY.LOG_CURRENT_PAGE=limitX(JY.LOG_CURRENT_PAGE+1,1,JY.LOG_MAX_PAGE);
    JY.bt[123].enable=JY.LOG_CURRENT_PAGE>1;
    JY.bt[124].enable=JY.LOG_CURRENT_PAGE<JY.LOG_MAX_PAGE;
    elseif v.id==131 then --福缘
    PlayWavE(0);
    JY.Person[JY.pid]["福缘"]=limitX(JY.Person[JY.pid]["福缘"]+1,1,20);
    InsertLog(2,7,JY.Person[JY.pid]["福缘"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif v.id==132 then --悟性
    PlayWavE(0);
    JY.Person[JY.pid]["悟性"]=limitX(JY.Person[JY.pid]["悟性"]+1,1,20);
    InsertLog(2,6,JY.Person[JY.pid]["悟性"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif v.id==133 then --机敏
    PlayWavE(0);
    JY.Person[JY.pid]["机敏"]=limitX(JY.Person[JY.pid]["机敏"]+1,1,20);
    InsertLog(2,5,JY.Person[JY.pid]["机敏"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif v.id==134 then --根骨
    PlayWavE(0);
    JY.Person[JY.pid]["根骨"]=limitX(JY.Person[JY.pid]["根骨"]+1,1,20);
    InsertLog(2,4,JY.Person[JY.pid]["根骨"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif v.id==135 then --膂力
    PlayWavE(0);
    JY.Person[JY.pid]["膂力"]=limitX(JY.Person[JY.pid]["膂力"]+1,1,20);
    InsertLog(2,3,JY.Person[JY.pid]["膂力"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif v.id==136 then --内力
    PlayWavE(0);
    JY.Person[JY.pid]["内力最大值"]=limitX(JY.Person[JY.pid]["内力最大值"]+40,1,9999);
    InsertLog(2,2,JY.Person[JY.pid]["内力最大值"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif v.id==137 then --生命
    PlayWavE(0);
    JY.Person[JY.pid]["生命最大值"]=limitX(JY.Person[JY.pid]["生命最大值"]+40,1,9999);
    InsertLog(2,1,JY.Person[JY.pid]["生命最大值"]);
    AddFreePT(-1);
    SetFreePoint();
    elseif between(v.id,141,164) then
    PlayWavE(0);
    if JY.bt[13].show then
    if v.mapid~=JY.Base["当前场景"] then
    JY.Base["下个场景"]=v.mapid;
    JY.CENTER_MSG="** 即将进入"..JY.Force[v.mapid]["名称"].." **";
    end
    CloseMapList();
    elseif JY.bt[17].show then
    JY.Person[0]["外号"]=JY.Item[v.mapid]["名称"];
    CloseTitleList();
    elseif JY.bt[18].show then
    JY.Person[0]["武器"]=100+v.mapid;
    CloseWeaponList();
    end
    elseif v.id==198 then
    PlayWavE(0);
    JY.bt[198].show=false;
    JY.bt[199].show=false;
    if v.event==1 then
    lib.Delay(350);
    os.exit();
    elseif v.event==2 then
    JY.Base["指令"]=1;
    JY.CENTER_MSG="** 即将转世重生 **";
    end
    v.event=0;
    SetMainMenu();
    elseif v.id==199 then
    PlayWavE(0);
    JY.bt[198].show=false;
    JY.bt[199].show=false;
    SetMainMenu();
    end
    return;
    elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
    JY.current=v.id;
    JY.hold=true;
    if v.id==81 and (not v.select) then
    v.select=true;
    JY.bt[82].select=false;
    JY.Base["开启音效"]=1;
    PlayWavE(0);
    elseif v.id==82 and (not v.select) then
    v.select=true;
    JY.bt[81].select=false;
    JY.Base["开启音效"]=0;
    PlayWavE(0);
    elseif v.id==83 and (not v.select) then
    v.select=true;
    JY.bt[84].select=false;
    JY.Base["修炼备选"]=1;
    PlayWavE(0);
    elseif v.id==84 and (not v.select) then
    v.select=true;
    JY.bt[83].select=false;
    JY.Base["修炼备选"]=0;
    PlayWavE(0);
    elseif v.id==85 and (not v.select) then
    v.select=true;
    JY.bt[86].select=false;
    JY.Base["开启音乐"]=1;
    PlayWavE(0);
    elseif v.id==86 and (not v.select) then
    v.select=true;
    JY.bt[85].select=false;
    JY.Base["开启音乐"]=0;
    PlayWavE(0);
    end
    return;
    elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
    JY.current=v.id;
    if v.enable and v.help~=nil then
    JY.HELPINDEX=v.id;
    end
    return;
    end
    else
    if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
    PlayWavE(1);
    return;
    end
    end
    end
    end
   end
   function SetMainMenu()
    local flag=true;
    for i,v in pairs({11,12,13,14,15,16,17,34,198,199}) do
    if JY.bt[v].show then
    flag=false;
    break;
    end
    end
    for i,v in pairs({1,2,3,4,5,6,7,8}) do
    JY.bt[v].enable=flag;
    end
    if JY.Base["下个场景"]>0 then --已经决定换地图
    JY.bt[5].enable=false;
    JY.bt[6].enable=false;
    end
    if JY.Base["倒计时"]>0 then --不满足条件时，
    JY.bt[5].enable=false;
    end
    if JY.Base["当前事件"]>0 then --已经开启了Boss战
    JY.bt[5].enable=false;
    JY.bt[6].enable=false;
    end
    if JY.Base["指令"]>0 then --等待执行指令
    JY.bt[5].enable=false;
    JY.bt[6].enable=false;
    end
   end
   function OpenPersonStatus()
    if JY.bt[198].show then
    return;
    end
    JY.bt[11].show=true;
    JY.bt[12].show=true;
    JY.bt[16].show=true;
    JY.PersonStatusPage=0;
    SetMainMenu();
    SetFreePoint();
   end
   function ClosePersonStatus()
    if JY.bt[198].show then
    return;
    end
    JY.bt[11].show=false;
    JY.bt[12].show=false;
    JY.bt[16].show=false;
    CloseKungfuList();
    SetMainMenu();
    SetFreePoint();
   end
   function OpenKungfuList()
    local num_per_page=16;
    local total_num=0;
    for i=81,JY.KungfuNum-1 do
    if JY.Base["武功等级"..i]>0 then
    total_num=total_num+1;
    end
    end
    JY.KF_MAX_PAGE=1+math.modf((total_num-1)/num_per_page);
    JY.KF_CURRENT_PAGE=1;
    JY.PersonStatusPage=1;
    JY.bt[121].show=true;
    JY.bt[122].show=true;
    JY.bt[121].enable=JY.KF_CURRENT_PAGE>1;
    JY.bt[122].enable=JY.KF_CURRENT_PAGE<JY.KF_MAX_PAGE;
    QueryKungfuList();
    SetFreePoint();
   end
   function CloseKungfuList()
    local num_per_page=16;
    JY.KF_MAX_PAGE=0;
    JY.KF_CURRENT_PAGE=0;
    JY.PersonStatusPage=0;
    JY.bt[121].show=false;
    JY.bt[122].show=false;
    for i=1,num_per_page do
    JY.bt[100+i].txt="";
    JY.bt[100+i].show=false;
    end
    SetFreePoint();
   end
   function QueryKungfuList()
    local num_per_page=16;
    local num=0;
    local start=num_per_page*(JY.KF_CURRENT_PAGE-1);
    for i=1,num_per_page do
    JY.bt[100+i].txt="";
    JY.bt[100+i].show=false;
    end
    for i=81,JY.KungfuNum-1 do
    local lv=JY.Base["武功等级"..i];
    if lv>0 then
    num=num+1;
    lv=lv+5;
    if between(num,start+1,start+num_per_page) then
    JY.bt[100+num-start].txt=JY.Kungfu[i]["名称"];
    JY.bt[100+num-start].kfid=i;
    JY.bt[100+num-start].help=string.format("%-18sLv%02d*%s*伤害: %4d 命中: %4d*格挡: %4d 闪避: %4d",
    JY.Kungfu[i]["名称"],JY.Base["武功等级"..i],GenTalkString(JY.Kungfu[i]["说明"],15),
    math.floor(JY.Kungfu[i].Damage*lv/10),math.floor(JY.Kungfu[i].AP*lv/10),
    math.floor(JY.Kungfu[i].PP*lv/10),math.floor(JY.Kungfu[i].DP*lv/10));
    JY.bt[100+num-start].helppic=80+JY.Kungfu[i].Lv;
    JY.bt[100+num-start].show=true;
    end
    end
    end
   end
   function OpenMapList()
    JY.bt[13].show=true;
    QueryMapList();
    SetMainMenu();
   end
   function CloseMapList()
    for i=1,24 do
    JY.bt[140+i].show=false;
    end
    JY.bt[13].show=false;
    SetMainMenu();
   end
   function QueryMapList()
    for i=1,24 do
    JY.bt[140+i].txt=JY.Force[i]["名称"];
    JY.bt[140+i].help=nil;
    JY.bt[140+i].mapid=i;
    JY.bt[140+i].show=true;
    if JY.Base["开启场景"..i]>0 then
    JY.bt[140+i].enable=true;
    JY.bt[140+i].sp=89+JY.Base["开启场景"..i];
    else
    JY.bt[140+i].enable=false;
    end
    end
   end
   function OpenTitleList()
    JY.bt[17].show=true;
    QueryTitleList();
    SetMainMenu();
   end
   function CloseTitleList()
    for i=1,24 do
    JY.bt[140+i].show=false;
    end
    JY.bt[17].show=false;
    SetMainMenu();
   end
   function QueryTitleList()
    for i=1,24 do
    JY.bt[140+i].mapid=i;
    JY.bt[140+i].show=true;
    if JY.Base["开启称号"..i]>0 then
    JY.bt[140+i].txt=JY.Item[i]["名称"];
    JY.bt[140+i].help=GenTalkString(JY.Item[i]["说明"],15);
    JY.bt[140+i].enable=true;
    JY.bt[140+i].sp=0;
    else
    JY.bt[140+i].txt="----";
    JY.bt[140+i].help=nil;
    JY.bt[140+i].enable=false;
    JY.bt[140+i].sp=0;
    end
    end
   end
   function OpenWeaponList()
    JY.bt[18].show=true;
    QueryWeaponList();
    SetMainMenu();
   end
   function CloseWeaponList()
    for i=1,24 do
    JY.bt[140+i].show=false;
    end
    JY.bt[18].show=false;
    SetMainMenu();
   end
   function QueryWeaponList()
    for i=1,24 do
    JY.bt[140+i].mapid=i;
    JY.bt[140+i].show=true;
    if JY.Base["开启武器"..i]>0 then
    JY.bt[140+i].txt=JY.Item[100+i]["名称"];
    JY.bt[140+i].help=JY.Item[100+i]["名称"].."*"..GenTalkString(	JY.Item[100+i]["说明"],15)..string.format("*伤害 %+d 命中 %+d*格挡 %+d 闪避 %+d",
                                                                   math.modf(JY.Item[100+i]["伤害"]/10),math.modf(JY.Item[100+i]["命中"]/10),
                                                                   math.modf(JY.Item[100+i]["格挡"]/10),math.modf(JY.Item[100+i]["闪避"]/10));
    JY.bt[140+i].enable=true;
    JY.bt[140+i].sp=0;
    else
    JY.bt[140+i].txt="----";
    JY.bt[140+i].help=nil;
    JY.bt[140+i].enable=false;
    JY.bt[140+i].sp=0;
    end
    end
   end
   function OpenLog()
    JY.bt[14].show=true;
    JY.bt[123].show=true;
    JY.bt[124].show=true;
    local num_per_page=14;
    JY.LOG_MAX_PAGE=1+math.modf((GetLogNum()-1)/num_per_page);
    JY.LOG_CURRENT_PAGE=JY.LOG_MAX_PAGE;
    JY.bt[123].enable=JY.LOG_CURRENT_PAGE>1;
    JY.bt[124].enable=JY.LOG_CURRENT_PAGE<JY.LOG_MAX_PAGE;
    SetMainMenu();
   end
   function CloseLog()
    JY.bt[14].show=false;
    JY.bt[123].show=false;
    JY.bt[124].show=false;
    SetMainMenu();
   end
   function OpenSetting()
    JY.bt[15].show=true;
    for i=81,86 do
    JY.bt[i].show=true;
    end
    for i=91,91 do
    JY.bt[i].show=true;
    if JY.Base["指令"]>0 then --等待执行指令
    JY.bt[i].enable=false;
    else
    JY.bt[i].enable=true;
    end
    end
    if JY.Base["开启音效"]>0 then
    JY.bt[81].select=true;
    JY.bt[82].select=false;
    else
    JY.bt[82].select=true;
    JY.bt[81].select=false;
    end
    if JY.Base["修炼备选"]>0 then
    JY.bt[83].select=true;
    JY.bt[84].select=false;
    else
    JY.bt[84].select=true;
    JY.bt[83].select=false;
    end
    if JY.Base["开启音乐"]>0 then
    JY.bt[85].select=true;
    JY.bt[86].select=false;
    JY.bt[85].enable=true;
    JY.bt[86].enable=true;
    else
    JY.bt[86].select=true;
    JY.bt[85].select=false;
    JY.bt[85].enable=true;
    JY.bt[86].enable=true;
    end
    JY.bt[10].show=true;
   
    SetMainMenu();
   end
   function CloseSetting()
    JY.bt[15].show=false;
    for i=81,86 do
    JY.bt[i].show=false;
    end
    for i=91,91 do
    JY.bt[i].show=false;
    end
    JY.bt[10].show=false;
    SetMainMenu();
   end
   function OpenRecord()
    JY.bt[16].show=true;
    SetMainMenu();
   end
   function CloseRecord()
    JY.bt[16].show=false;
    SetMainMenu();
   end
   function OpenPersonIni()
    ClosePersonStatus();
    CloseMapList();
    CloseTitleList();
    CloseLog();
    CloseSetting();
    CloseRecord();
    JY.bt[31].show=true;
    JY.bt[32].show=true;
    JY.bt[33].show=true;
    JY.bt[34].show=true;
    JY.bt[35].show=true;
    JY.CENTER_MSG="*1. 本游戏为放置类游戏, 基本不需要操作*2. 本游戏为自动存档, 每分钟自动保存*3. 选择不同的场景, 将面对强弱各异的对手*4. 人物等级上限为99级*5. 武功修炼完全随机, 等级上限为40级*6. 大武侠(dawuxia.net)祝游戏愉快*";
    SetFreePoint();
    SetMainMenu();
   end
   function ClosePersonIni()
    if between(JY.Person[JY.pid]["头像"],82,85) then
    JY.Person[JY.pid]["性别"]=1;
    else
    JY.Person[JY.pid]["性别"]=0;
    end
    --
    math.randomseed(JY.Base.Seed);
    for i=1,8 do
    local kfid=PercentRandom(JY.Leaving);
    if kfid>0 and CheckKungfu(kfid+100) then
    JY.Base["武功等级"..(kfid+100)]=1;
    end
    end
    JY.Leaving={};
    --
    ClosePersonStatus();
    JY.bt[11].x1=252;
    JY.bt[11].txt="关闭";
    JY.bt[31].show=false;
    JY.bt[32].show=false;
    JY.bt[33].show=false;
    JY.bt[34].show=false;
    JY.bt[35].show=false;
    JY.CENTER_MSG="";
    SetFreePoint();
    SetMainMenu();
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white来到这个世界...\\n";
    JY.WAIT=4;
   
   if JY.Person[JY.pid]["名称"]=="大武侠" then
    JY.Person[JY.pid]["生命最大值"]=100;
    JY.Person[JY.pid]["内力最大值"]=80;
    JY.Person[JY.pid]["生命"]=JY.Person[JY.pid]["生命最大值"];
    JY.Person[JY.pid]["内力"]=JY.Person[JY.pid]["内力最大值"];
    for i,v in pairs({"膂力","根骨","机敏","悟性","福缘"}) do
    JY.Person[JY.pid][v]=1;
    JY.Base[v.."成长"]=0; --升级不加属性
    end
   JY.Base["自由属性点"]=0;
   end
   
    JY.Status=GAME_AUTO;
    JY.Base.Seed=tostring(os.time()):reverse():sub(1, 6);
    math.randomseed(JY.Base.Seed);
   end
   function SetFreePoint()
    if (JY.bt[11].show or JY.bt[34].show) and JY.PersonStatusPage==0 then
    JY.bt[131].show=true;
    JY.bt[132].show=true;
    JY.bt[133].show=true;
    JY.bt[134].show=true;
    JY.bt[135].show=true;
    JY.bt[136].show=true;
    JY.bt[137].show=true;
    if JY.Base["自由属性点"]>0 then
    if JY.Person[JY.pid]["福缘"]<20 then
    JY.bt[131].enable=true;
    else
    JY.bt[131].enable=false;
    end
    if JY.Person[JY.pid]["悟性"]<20 then
    JY.bt[132].enable=true;
    else
    JY.bt[132].enable=false;
    end
    if JY.Person[JY.pid]["机敏"]<20 then
    JY.bt[133].enable=true;
    else
    JY.bt[133].enable=false;
    end
    if JY.Person[JY.pid]["根骨"]<20 then
    JY.bt[134].enable=true;
    else
    JY.bt[134].enable=false;
    end
    if JY.Person[JY.pid]["膂力"]<20 then
    JY.bt[135].enable=true;
    else
    JY.bt[135].enable=false;
    end
    if JY.Person[JY.pid]["内力最大值"]<9999 then
    JY.bt[136].enable=true;
    else
    JY.bt[136].enable=false;
    end
    if JY.Person[JY.pid]["生命最大值"]<9999 then
    JY.bt[137].enable=true;
    else
    JY.bt[137].enable=false;
    end
    else
    JY.bt[131].enable=false;
    JY.bt[132].enable=false;
    JY.bt[133].enable=false;
    JY.bt[134].enable=false;
    JY.bt[135].enable=false;
    JY.bt[136].enable=false;
    JY.bt[137].enable=false;
    end
    else
    JY.bt[131].show=false;
    JY.bt[132].show=false;
    JY.bt[133].show=false;
    JY.bt[134].show=false;
    JY.bt[135].show=false;
    JY.bt[136].show=false;
    JY.bt[137].show=false;
    end
   end
   function SetKungfu(kfid)
    local p=JY.Person[JY.pid];
    local kind=JY.Kungfu[kfid]["类型"];
    if kind==7 then
    if p["内功"]==kfid then
    PlayWavE(1);
    p["内功"]=0;
    p["内功等级"]=0;
    else
    PlayWavE(0);
    p["内功"]=kfid;
    p["内功等级"]=JY.Base["武功等级"..kfid];
    end
    elseif kind==8 then
    if p["轻功"]==kfid then
    PlayWavE(1);
    p["轻功"]=0;
    p["轻功等级"]=0;
    else
    PlayWavE(0);
    p["轻功"]=kfid;
    p["轻功等级"]=JY.Base["武功等级"..kfid];
    end
    elseif kind==9 then
    if p["特技"]==kfid then
    PlayWavE(1);
    p["特技"]=0;
    p["特技等级"]=0;
    else
    PlayWavE(0);
    p["特技"]=kfid;
    p["特技等级"]=JY.Base["武功等级"..kfid];
    end
    else
    for i=1,5 do
    if p["武功"..i]==kfid then
    PlayWavE(1);
    for j=i,4 do
    p["武功"..j]=p["武功"..(j+1)];
    p["武功等级"..j]=p["武功等级"..(j+1)];
    end
    p["武功"..5]=0;
    p["武功等级"..5]=0;
    return;
    end
    end
    for i=1,5 do
    if p["武功"..i]==0 then
    PlayWavE(0);
    p["武功"..i]=kfid;
    p["武功等级"..i]=JY.Base["武功等级"..kfid];
    return;
    end
    end
    for i=1,4 do
    p["武功"..i]=p["武功"..(i+1)];
    p["武功等级"..i]=p["武功等级"..(i+1)];
    end
    PlayWavE(0);
    p["武功"..5]=kfid;
    p["武功等级"..5]=JY.Base["武功等级"..kfid];
    end
   end
   function CheckLvUp(pid)
    if JY.Base["实战"]>=CC.Exp[JY.Person[JY.pid]["等级"]+1] then
    JY.Base["实战"]=0;
    LvUp(pid);
    PlayWavE(11);
    JY.TEXT_BUFF="\\yellow"..JY.Person[pid]["名称"].."\\white修为上升！\\n";
    JY.WAIT=4;
    coroutine.yield();
    if JY.Base["生命加值"]>0 then
    JY.TEXT_BUFF=string.format("\\yellow"..JY.Person[pid]["名称"].."\\white生命上限上升到%d \\green(%+d)\\white！\\n",JY.Person[pid]["生命最大值"],JY.Base["生命加值"]);
    JY.WAIT=4;
    coroutine.yield();
    end
    if JY.Base["内力加值"]>0 then
    JY.TEXT_BUFF=string.format("\\yellow"..JY.Person[pid]["名称"].."\\white内力上限上升到%d \\green(%+d)\\white！\\n",JY.Person[pid]["内力最大值"],JY.Base["内力加值"]);
    JY.WAIT=4;
    coroutine.yield();
    end
    JY.TEXT_BUFF="\\yellow"..JY.Person[pid]["名称"].."\\white获得1点自由属性点！\\n";
    AddFreePT(1);
    JY.WAIT=4;
    coroutine.yield();
    end
   end
   function AddFreePT(n)
    JY.Base["自由属性点"]=limitX(JY.Base["自由属性点"]+n,0,99);
   end
   function LvUp(pid)
    local lv=JY.Person[pid]["等级"]+1;
    JY.Person[pid]["等级"]=lv;
    InsertLog(1,JY.Person[pid]["等级"]);
    JY.Person[pid]["生命"]=JY.Person[pid]["生命最大值"];
    JY.Person[pid]["内力"]=JY.Person[pid]["内力最大值"];
    JY.Person[pid]["生命最大值"]=limitX(JY.Person[pid]["生命最大值"]+2,1,9999);
    JY.Person[pid]["内力最大值"]=limitX(JY.Person[pid]["内力最大值"]+2,1,9999);
    JY.Base["生命加值"]=JY.Person[pid]["生命最大值"]-JY.Person[pid]["生命"];
    JY.Base["内力加值"]=JY.Person[pid]["内力最大值"]-JY.Person[pid]["内力"];
    JY.Person[pid]["生命"]=JY.Person[pid]["生命最大值"];
    JY.Person[pid]["内力"]=JY.Person[pid]["内力最大值"];
    if JY.Base["生命加值"]>0 then
    InsertLog(2,1,JY.Person[pid]["生命最大值"]);
    end
    if JY.Base["内力加值"]>0 then
    InsertLog(2,2,JY.Person[pid]["内力最大值"]);
    end
   end
   function CalNextLv(pid)
    local lv=JY.Person[pid]["等级"];
    for i,v in pairs({"膂力","根骨","机敏","悟性","福缘"}) do
    JY.Base[v.."加值"]=0;
    if JY.Person[pid][v]<20 and JY.Base[v.."成长"]>0 then
    if math.random()<JY.Base[v.."成长"]/limitX(26-lv,1,30) then
    JY.Base[v.."加值"]=JY.Base[v.."加值"]+1;
    end
    if math.random(100)<JY.Person[pid]["福缘"] then --高福缘 额外提高成长速度
    JY.Base[v.."加值"]=JY.Base[v.."加值"]+1;
    end
    end
    JY.Base[v.."成长"]=JY.Base[v.."成长"]-JY.Base[v.."加值"];
    end
    JY.Base["生命加值"]=limitX(JY.Base["生命成长"]+math.random(4)-math.random(4),1,40);
    JY.Base["内力加值"]=limitX(JY.Base["内力成长"]+math.random(4)-math.random(4),1,40);
   end
   function TableRandom(t)
    local n=#t;
    if n==1 then
    return t[1];
    elseif n>1 then
    n=math.random(n)
    return t[n];
    else
    return 0;
    end
   end
   function PercentRandom(t)
    local pt={};
    local pv=0;
    pt[0]=pv;
    for i,v in pairs(t) do
    pv=pv+v;
    pt[i]=pv;
    end
    if pv==0 then
    return 0;
    end
    local v=math.random()*pv;
    for i=1,#t do
    if v>=pt[i-1] and v<pt[i] then
    return i;
    end
    end
    return 1;
   end
   