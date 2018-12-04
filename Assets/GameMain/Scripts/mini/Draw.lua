--显示阴影字符串
function DrawStringS(x,y,str,color,size) 
    if CONFIG.Windows then
    if CC.FontType==0 then
    lib.DrawStr(x-1,y,str,color,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x,y,str,color,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    elseif CC.FontType==1 then
    lib.DrawStr(x,y,str,color,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
    end
    else
    if CC.FontType==0 then
    lib.DrawStr(x-1,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    elseif CC.FontType==1 then
    lib.DrawStr(x,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
    end
    end
end
   
--显示阴影字符串
function DrawString2(x,y,str,color,size) 
    lib.DrawStr(x-2,y-1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x-2,y,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x-2,y+1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x-1,y-1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x,y-1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x+1,y-1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x+1,y,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x+1,y+1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x,y+1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    lib.DrawStr(x-1,y+1,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
    DrawString(x,y,str,color,size);
end

--显示字符串,会分行
function DrawStr(x,y,str,color,size) 
	local strarray={}
 	local num,maxlen;
 	maxlen=0
 	num,strarray=Split(str,'*')
 	for i=1,num do
 	local len=#strarray[i];
 	if len>maxlen then
    maxlen=len
    end
    end
    if maxlen==0 then
    return;
    end
    for i=1,num do
    DrawString(x,y+size*(i-1),strarray[i],color,size);
    end
end

--split string
function Split(szFullString,szSeparator)
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray = {}
    while true do
    local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
    if not nFindLastIndex then
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
    break
    end
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
    nFindStartIndex = nFindLastIndex + string.len(szSeparator)
    nSplitIndex = nSplitIndex + 1
    end
    return nSplitIndex,nSplitArray
end

function ShowScreen()
    if JY.Dark then
    Light(4);
    else
    lib.ShowSurface(0);
    end
end

function RGB(r,g,b) --设置颜色RGB
    return r*65536+g*256+b;
end

function GetRGB(color) --分离颜色的RGB分量
    color=color%(65536*256);
    local r=math.floor(color/65536);
    color=color%65536;
    local g=math.floor(color/256);
    local b=color%256;
    return r,g,b
end


function DrawGame()
    if JY.Status==GAME_START then
    lib.PicLoadCache(0,490*2,0,0,1);
    else
    lib.PicLoadCache(0,2*2,0,0,1);
    lib.PicLoadCache(0,0*2,0,CC.ScreenH-292,1);
    --绘制文本信息
    for i,v in pairs(JY.TEXT) do
    for index=1,#JY.TEXT_COLOR[i] do
    local start=JY.TEXT_COLOR[i][index].s;
    local endp;
    if index<#JY.TEXT_COLOR[i] then
    endp=JY.TEXT_COLOR[i][index+1].s-1;
    else
    endp=-1;
    end
    DrawString(16+16*start/2,514+20*i,string.sub(v,start,endp),JY.TEXT_COLOR[i][index].c,16);
    end
    end
    --结束绘制文本信息
    --
    DrawString(6,10,string.format("%s",JY.Person[0]["名称"]),M_White,16);
    DrawString(6,26,string.format("%s",JY.Force[JY.Base["当前场景"]]["名称"]),M_White,16);
    DrawString(6,42,string.format("修为 Lv%02d",JY.Person[0]["等级"]),M_White,16);
    DrawString(6,58,string.format("历练 %04.1f%%",100*JY.Base["实战"]/CC.Exp[JY.Person[0]["等级"]+1]),M_White,16);
    DrawString(6,74,string.format("潜能 %d",JY.Base["潜能"]),M_White,16);
    DrawString(6,90,string.format("用时 %02d:%02d:%02d",JY.Base["时"],JY.Base["分"],JY.Base["秒"]),M_White,16);
   
   DrawString(30,485,os.date("当前时间：%Y年%m月%d日%H:%M:%S"),M_White,16)
   
   if CONFIG.Windows then
   DrawString(320,485,"设备：PC",M_White,16);
   else
   DrawString(320,485,"设备：Android",M_White,16);
   end
   
    DrawString(6,106,"版本 "..JY.Base["数据版本号"].."	@"..GAME_VER,M_White,16);
    
    end
    
    --EFT
    
    if JY.EFT1>0 then
    lib.PicLoadCache(2,(JY.EFT1+os.clock()*4%JY.EFT2)*2,115,192,1); 
    end
    
    if JY.Status==GAME_LEARN and JY.LEARN_KFID>0 then
    DrawLearnKF(JY.LEARN_KFID);
    elseif JY.Status==GAME_FIGHT then
    local self={}
    self.x1=16;
    self.y1=380;
    lib.PicLoadCache(0,88*2,self.x1,self.y1,1);
    lib.PicLoadCache(1,JY.Person[JY.pid]["头像"]*2,self.x1+12,self.y1+14,1);
    DrawStringS(self.x1+88,self.y1+14,JY.Person[JY.pid]["名称"],M_White,16);
    DrawString(self.x1+88,self.y1+38,"生命",M_White,16);
    DrawString(self.x1+88,self.y1+58,"内力",M_White,16);
    DrawString(self.x1+88,self.y1+78,"状态",M_White,16);
    for i=0,19 do
    if 25*(40+i)<JY.Person[JY.pid]["生命"] then
    lib.PicLoadCache(0,61*2,self.x1+128+5*i,self.y1+39,1);
    elseif 25*(20+i)<JY.Person[JY.pid]["生命"] then
    lib.PicLoadCache(0,63*2,self.x1+128+5*i,self.y1+39,1);
    elseif 25*i<JY.Person[JY.pid]["生命"] then
    lib.PicLoadCache(0,68*2,self.x1+128+5*i,self.y1+39,1);
    elseif 25*i<JY.Person[JY.pid]["生命最大值"] then
    lib.PicLoadCache(0,69*2,self.x1+128+5*i,self.y1+39,1);
    else
    break;
    end
    end
    for i=0,19 do
    if 25*(40+i)<JY.Person[JY.pid]["内力"] then
    lib.PicLoadCache(0,62*2,self.x1+128+5*i,self.y1+59,1);
    elseif 25*(20+i)<JY.Person[JY.pid]["内力"] then
    lib.PicLoadCache(0,65*2,self.x1+128+5*i,self.y1+59,1);
    elseif 25*i<JY.Person[JY.pid]["内力"] then
    lib.PicLoadCache(0,64*2,self.x1+128+5*i,self.y1+59,1);
    elseif 25*i<JY.Person[JY.pid]["内力最大值"] then
    lib.PicLoadCache(0,69*2,self.x1+128+5*i,self.y1+59,1);
    else
    break;
    end
    end
    self.x2=142;
    self.y2=128;
    lib.PicLoadCache(0,89*2,self.x2,self.y2,1);
    lib.PicLoadCache(1,JY.Person[JY.eid]["头像"]*2,self.x2+292-12-64,self.y2+14,1);
    DrawStringS(self.x2+292-88-16*#JY.Person[JY.eid]["名称"]/2,self.y2+14,JY.Person[JY.eid]["名称"],M_White,16);
    DrawString(self.x2+292-88-32,self.y2+38,"生命",M_White,16);
    DrawString(self.x2+292-88-32,self.y2+58,"内力",M_White,16);
    DrawString(self.x2+292-88-32,self.y2+78,"状态",M_White,16);
    for i=0,19 do
    if 25*(40+i)<JY.Person[JY.eid]["生命"] then
    lib.PicLoadCache(0,61*2,self.x2+292-128-5*i-5,self.y2+39,1);
    elseif 25*(20+i)<JY.Person[JY.eid]["生命"] then
    lib.PicLoadCache(0,63*2,self.x2+292-128-5*i-5,self.y2+39,1);
    elseif 25*i<JY.Person[JY.eid]["生命"] then
    lib.PicLoadCache(0,68*2,self.x2+292-128-5*i-5,self.y2+39,1);
    elseif 25*i<JY.Person[JY.eid]["生命最大值"] then
    lib.PicLoadCache(0,69*2,self.x2+292-128-5*i-5,self.y2+39,1);
    else
    break;
    end
    end
    for i=0,19 do
    if 25*(40+i)<JY.Person[JY.eid]["内力"] then
    lib.PicLoadCache(0,62*2,self.x2+292-128-5*i-5,self.y2+59,1);
    elseif 25*(20+i)<JY.Person[JY.eid]["内力"] then
    lib.PicLoadCache(0,65*2,self.x2+292-128-5*i-5,self.y2+59,1);
    elseif 25*i<JY.Person[JY.eid]["内力"] then
    lib.PicLoadCache(0,64*2,self.x2+292-128-5*i-5,self.y2+59,1);
    elseif 25*i<JY.Person[JY.eid]["内力最大值"] then
    lib.PicLoadCache(0,69*2,self.x2+292-128-5*i-5,self.y2+59,1);
    else
    break;
    end
    end
    local v=JY.info[JY.pid];
    if type(v)=='table' then
    local dx,dy;
    local width=48;
    dx=CC.ScreenW/2;
    dy=self.y1+64;
    if v.s_pic>999 then
    lib.PicLoadCache(0,v.s_pic*2,dx,dy,0);
    else
    if v.s_pic>=100 then
    dx=dx+width;
    elseif v.s_pic>=10 then
    dx=dx+width/2;
    end
    local hurt=v.s_pic;
    while hurt>0 do
    local pic_id=1000+hurt%10;
    lib.PicLoadCache(0,pic_id*2,dx,dy,0);
    dx=dx-width;
    hurt=math.modf(hurt/10);
    end
    end
    end
    v=JY.info[JY.eid];
    if type(v)=='table' then
    local dx,dy;
    local width=48;
    dx=CC.ScreenW/2;
    dy=self.y2+64;
    if v.s_pic>999 then
    lib.PicLoadCache(0,v.s_pic*2,dx,dy,0);
    else
    if v.s_pic>=100 then
    dx=dx+width;
    elseif v.s_pic>=10 then
    dx=dx+width/2;
    end
    local hurt=v.s_pic;
    while hurt>0 do
    local pic_id=1000+hurt%10;
    lib.PicLoadCache(0,pic_id*2,dx,dy,0);
    dx=dx-width;
    hurt=math.modf(hurt/10);
    end
    end
    end
    end
    
    if #JY.CENTER_MSG>0 then
    if JY.Status==GAME_START then
    DrawHelp(-1,480,JY.CENTER_MSG);
    else
    DrawHelp(-1,255,JY.CENTER_MSG);
    end
    end
    --人物属性界面
    if JY.bt[11].show or JY.bt[34].show then
    DrawPersonStatus(0);
    end
    --地图选择界面
    if JY.bt[13].show then
    DrawMapSelect();
    end
    if JY.bt[14].show then
    DrawLog();
    end
    if JY.bt[15].show then
    DrawSetting();
    end
    if JY.bt[17].show then
    DrawTitle();
    end
    if JY.bt[18].show then
    DrawWeapon();
    end
    if JY.bt[198].show then
    if JY.bt[198].event==1 then
    DrawHelp(-1,255,"* 确定要关闭游戏吗？ ***");
    elseif JY.bt[198].event==2 then
    DrawHelp(-1,255,"* 确定要转世重生吗？ ***");
   
    end
    lib.PicLoadCache(0,164*2,JY.bt[198].x1-8,JY.bt[198].y1-10,1);
    end
    for i,v in pairs(JY.bt) do
    if v.show then
    if v.enable then
    if v.select then
    lib.PicLoadCache(0,v.pic3*2,v.x1,v.y1,1);
    elseif JY.current==v.id then
    if JY.hold then
    lib.PicLoadCache(0,v.pic3*2,v.x1,v.y1,1);
    else
    lib.PicLoadCache(0,v.pic2*2,v.x1,v.y1,1);
    end
    else
    lib.PicLoadCache(0,v.pic1*2,v.x1,v.y1,1);
    end
    else
    lib.PicLoadCache(0,v.pic4*2,v.x1,v.y1,1);
    end
    if between(v.sp,90,95) then
    if JY.current==v.id and JY.hold then
    lib.PicLoadCache(0,v.sp*2,v.x1+21+1,v.y1+26+1,1);
    else
    lib.PicLoadCache(0,v.sp*2,v.x1+21,v.y1+26,1);
    end
    end
    if #v.txt>0 then
    
    if v.select then
    DrawStringS(v.tx-16*#v.txt/4+1,v.ty-16/2+1,v.txt,C_WHITE,16);
    elseif JY.current==v.id and JY.hold then
    DrawStringS(v.tx-16*#v.txt/4+1,v.ty-16/2+1,v.txt,C_WHITE,16);
    else
    DrawStringS(v.tx-16*#v.txt/4,v.ty-16/2,v.txt,C_WHITE,16);
    end
    end
    end
    end
    if JY.HELPINDEX>0 then
    DrawHelp(MOUSE.x,MOUSE.y+24,JY.bt[JY.HELPINDEX].help,JY.bt[JY.HELPINDEX].helppic);
    end
end


function DrawHelp(x,y,str,pic) --显示带框的字符串
    local size=16;
    local color=C_WHITE;
    local strarray={}
    local num,maxlen;
    maxlen=0
    num,strarray=Split(str,'*')
    for i=1,num do
    local len=#strarray[i];
    if len>maxlen then
    maxlen=len
    end
    end
    if maxlen==0 then
    return;
    end
    local w=size*maxlen/2;
    local h=size*num+6*(num-1);
    if x==-1 then
    x=(CC.ScreenW)/2;
    end
    if y==-1 then
    y=(CC.ScreenH-h)/2;
    end
    if x<0 then
    x=CC.ScreenW-size/2*maxlen+x;
    end
    if y<0 then
    y=CC.ScreenH-size*num+y;
    end
    x=x-w/2;
    x=limitX(x,16,CC.ScreenW-w-16);
    local boxw,boxh;
    boxw=w+80; --88
    boxh=h+16; --24
    local boxx=x-(boxw-w)/2;
    local boxy=y-(boxh-h)/2;
    --Left Top
    lib.SetClip(boxx,boxy,boxx+boxw/2,boxy+boxh/2);
    lib.PicLoadCache(0,12*2,boxx,boxy,1);
    --Left Bot
    lib.SetClip(boxx,boxy+boxh/2,boxx+boxw/2,boxy+boxh);
    lib.PicLoadCache(0,12*2,boxx,boxy+boxh-304,1);
    --Right Top
    lib.SetClip(boxx+boxw/2,boxy,boxx+boxw,boxy+boxh/2);
    lib.PicLoadCache(0,12*2,boxx+boxw-320,boxy,1);
    --Right Bot
    lib.SetClip(boxx+boxw/2,boxy+boxh/2,boxx+boxw,boxy+boxh);
    lib.PicLoadCache(0,12*2,boxx+boxw-320,boxy+boxh-304,1);
    lib.SetClip(0,0,0,0);
    for i=1,num do
    DrawStringS(x,y+(size+6)*(i-1),strarray[i],color,size);
    end
    if pic~=nil then
    lib.PicLoadCache(0,pic*2,x+string.find(strarray[1]," ")*size/2+9,y+9)
    end
end



function DrawPersonStatus(pid)
    local tx,ty=45,JY.bt[11].y1-272;
    lib.PicLoadCache(0,10*2,tx,ty,1);
    local p=JY.Person[pid];
    --head
    lib.PicLoadCache(1,p["头像"]*2,tx+45,ty+34,1);
    --武功
    tx,ty=66,JY.bt[11].y1-138;
    for i=1,5 do
    local r=p["武功"..i]
    if r>0 then
    DrawString(tx,ty,string.format("%-10sLv%02d",JY.Kungfu[r]["名称"],JY.Base["武功等级"..r]),M_White,16);
    ty=ty+16;
    end
    end
    for i,v in pairs({"内功","轻功","特技"}) do
    local r=p[v]
    if r>0 then
    DrawString(tx,ty,string.format("%-10sLv%02d",JY.Kungfu[r]["名称"],JY.Base["武功等级"..r]),M_White,16);
    ty=ty+16;
    end
    end
    if JY.PersonStatusPage==1 then
    DrawString(256,JY.bt[11].y1-255,string.format("Page %02d/%02d",JY.KF_CURRENT_PAGE,JY.KF_MAX_PAGE),M_White,16);
    return;
    end
    if JY.PersonStatusPage==2 then
    DrawRecord();
    return;
    end
    
    tx,ty=45+150,JY.bt[11].y1-256;
    --status
    lib.PicLoadCache(0,36*2,tx-8,ty-4-6,1);
    if string.len(p["外号"])>0 then
    DrawString(tx,ty,string.format("%-18s Lv%d",p["外号"].."·"..p["名称"],p["等级"]),M_White,16);
    else
    DrawString(tx,ty,string.format("%-18s Lv%d",p["名称"],p["等级"]),M_White,16);
    end
    ty=ty+21;
    lib.PicLoadCache(0,25*2,tx-8,ty-4,1);
    DrawString(tx,ty,"生命: "..p["生命"]..'/'..p["生命最大值"],M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,25*2,tx-8,ty-4,1);
    DrawString(tx,ty,"内力: "..p["内力"]..'/'..p["内力最大值"],M_White,16);
    ty=ty+21;
    local damage,ap,pp,dp=GetBasePT(pid,true);
    lib.PicLoadCache(0,25*2,tx-8,ty-4,1);
    DrawString(tx,ty,"伤害: "..damage,M_White,16);
    lib.PicLoadCache(0,25*2,tx-8+96,ty-4,1);
    DrawString(tx+96,ty,"命中: "..ap,M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,25*2,tx-8,ty-4,1);
    DrawString(tx,ty,"格挡: "..pp,M_White,16);
    lib.PicLoadCache(0,25*2,tx-8+96,ty-4,1);
    DrawString(tx+96,ty,"闪避: "..dp,M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,25*2,tx-8,ty-4,1);
    if p["武器"]>0 then
    DrawString(tx,ty,"武器: "..JY.Item[p["武器"]]["名称"],M_White,16);
    else
    DrawString(tx,ty,"武器: 无",M_White,16);
    end
    ty=ty+21;
    
    for i,v in pairs({"膂力","根骨","机敏","悟性","福缘"}) do
    lib.PicLoadCache(0,25*2,tx-8,ty-4,1);
    DrawString(tx,ty,v..": ",M_White,16);
    lib.PicLoadCache(0,(100+limitX(p[v],0,20))*2,tx+48,ty+1,1);
    ty=ty+21;
    end
    if JY.Base["自由属性点"]>0 then
    lib.PicLoadCache(0,28*2,tx-8,ty-4,1);
    DrawString(tx,ty,"自由属性点: "..JY.Base["自由属性点"],M_White,16);
    ty=ty+21;
    end
end


function DrawMapSelect()
    local tx,ty=45,JY.bt[11].y1-272;
    lib.PicLoadCache(0,11*2,tx,ty,1);
    ty=ty+0;
    lib.PicLoadCache(0,1*2,tx+1,ty,1);
    DrawStringS(tx+8,ty+10,"场景选择",C_WHITE,16);
end

function DrawLog()
    local tx,ty=45,JY.bt[14].y1-272;
    local num_per_page=14;
    lib.PicLoadCache(0,11*2,tx,ty,1);
    ty=ty+0;
    lib.PicLoadCache(0,1*2,tx+1,ty,1);
    DrawStringS(tx+8,ty+10,"战绩回顾",C_WHITE,16);
    DrawString(275,JY.bt[14].y1-258,string.format("Page %02d/%02d",JY.LOG_CURRENT_PAGE,JY.LOG_MAX_PAGE),M_White,16);
    tx=tx+10;
    ty=ty+40;
    for i=1+num_per_page*(JY.LOG_CURRENT_PAGE-1),math.min(num_per_page*JY.LOG_CURRENT_PAGE,GetLogNum()) do
        DrawStringColor(tx,ty,ReadLog(i),16);
        ty=ty+16;
    end
end

function DrawStringColor(x,y,str,size)
    local str_t={};
    local color=C_WHITE;
    local tmps=""
    while #str>0 do
    local tv=string.sub(str,1,1);
    if tv=="\\" then
    if #tmps>0 then
    table.insert(str_t,{s=tmps,c=color});
    tmps="";
    end
    if string.sub(str,1,6)=="\\white" then --white
    color=M_White;
    str=string.sub(str,7,-1);
    elseif string.sub(str,1,4)=="\\red" then --red
    color=M_Red;
    str=string.sub(str,5,-1);
    elseif string.sub(str,1,7)=="\\yellow" then --yellow
    color=M_Yellow;
    str=string.sub(str,8,-1);
    elseif string.sub(str,1,7)=="\\orange" then --orange
    color=M_Orange;
    str=string.sub(str,8,-1);
    elseif string.sub(str,1,6)=="\\green" then --M_PaleGreen
    color=M_PaleGreen;
    str=string.sub(str,7,-1);
    else
    str=string.sub(str,2,-1);
    end
    else
    if string.byte(tv)<128 then --英文以及数字
    tmps=tmps..tv;
    str=string.sub(str,2,-1);
    else --汉字
    tmps=tmps..string.sub(str,1,2);
    str=string.sub(str,3,-1);
    end
    end
    end
    if #tmps>0 then
    table.insert(str_t,{s=tmps,c=color});
    tmps="";
    end
    local tx=x;
    for i,v in pairs(str_t) do
    if #v.s>0 then
    DrawString(tx,y,v.s,v.c,size);
    tx=tx+size*#v.s/2;
    end
    end
end


function DrawSetting()
    local tx,ty=45,JY.bt[14].y1-272;
    lib.PicLoadCache(0,11*2,tx,ty,1);
    lib.PicLoadCache(0,1*2,tx+1,ty,1);
    DrawStringS(tx+8,ty+10,"游戏设定",C_WHITE,16);
    tx=60;
    ty=JY.bt[81].y1;
    lib.PicLoadCache(0,32*2,tx,ty,1);
    DrawStringS(tx+10,ty+8,"武功音效",C_WHITE,16);
    ty=JY.bt[83].y1;
    lib.PicLoadCache(0,33*2,tx,ty,1);
    DrawStringS(tx+10,ty+8,"修炼备选武功",C_WHITE,16);
    ty=JY.bt[85].y1;
    lib.PicLoadCache(0,32*2,tx,ty,1);
    DrawStringS(tx+10,ty+8,"开启音乐",C_WHITE,16);
    
    ty=JY.bt[91].y1;
    lib.PicLoadCache(0,32*2,tx,ty,1);
    DrawStringS(tx+10,ty+8,"功能指令",C_WHITE,16);
   
end



function DrawRecord()
    local b=JY.Base;
    local tx,ty=45+150,JY.bt[14].y1-256;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("战斗次数: %d",b["战斗次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("胜利次数: %d",b["胜利次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("攻击次数: %d",b["攻击次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("命中次数: %d",b["命中次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("格挡次数: %d",b["格挡次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("闪避次数: %d",b["闪避次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("睡觉次数: %d",b["睡觉次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("进食次数: %d",b["进食次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("思考次数: %d",b["思考次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("闭关次数: %d",b["闭关次数"]),M_White,16);
    ty=ty+21;
    lib.PicLoadCache(0,27*2,tx-8,ty-4,1);
    DrawString(tx,ty,string.format("潜能合计: %d",b["潜能合计"]),M_White,16);
    ty=ty+21;
end



function DrawTitle()
    local tx,ty=45,JY.bt[11].y1-272;
    lib.PicLoadCache(0,11*2,tx,ty,1);
    ty=ty+0;
    lib.PicLoadCache(0,1*2,tx+1,ty,1);
    DrawStringS(tx+8,ty+10,"称号",C_WHITE,16);
end


function DrawWeapon()
    local tx,ty=45,JY.bt[11].y1-272;
    lib.PicLoadCache(0,11*2,tx,ty,1);
    ty=ty+0;
    lib.PicLoadCache(0,1*2,tx+1,ty,1);
    DrawStringS(tx+8,ty+10,"武器",C_WHITE,16);
end


function DrawLearnKF(kfid)
    local cy=192;
    local sl=100*JY.Base["武功经验"..kfid]/GetSkillExp(kfid);
    --local T={[0]="基础","拳脚","剑法","刀法","枪棍","奇门","","内功","轻功","特技","基础",""};
    cy=cy+264;
    lib.PicLoadCache(0,3*2,0,cy-8,1);
    DrawString(20,cy,string.format("%-12s%-6sLv%02d Exp",JY.Kungfu[kfid]["名称"],JY.Kungfu[kfid]["类型描述"],JY.Base["武功等级"..kfid]),M_White,16);
    DrawString(310,cy,string.format("(%05.2f%%)",sl),M_White,16);
    lib.PicLoadCache(0,(40+math.modf(sl/10)+math.modf(os.clock()*2%2))*2,250,cy+1,1);
end