
--主游戏入口
function JY_Main_sub() --真正的游戏主程序入口
    dofile(CONFIG.ScriptPath .. "mouse.lua");
    SetGlobalConst();
    SetGlobal();
    --禁止访问全程变量
    setmetatable(_G,{ __newindex =function (_,n)
    error("attempt read write to undeclared variable " .. n,2);
    end,
    __index =function (_,n)
    error("attempt read read to undeclared variable " .. n,2);
    end,
    } );
    lib.Debug("JY_Main start.");
   
    math.randomseed(tostring(os.time()):reverse():sub(1, 6)); --初始化随机数发生器
    
    lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRePeatInterval); --设置键盘重复率
   
   
    PicCatchIni();
    lib.GetKey();
    JYOL_Mini_Endless();
end

function JYOL_Mini_Endless()
	
	lib.PicLoadCache(0,9*2,0,0,1);
	Light();
	for i=1,10 do
		lib.GetKey(1);
		lib.Delay(100);
	end
	WaitKey();
	Dark();

    JY.Status=GAME_START;
    JY.co_auto=coroutine.create(Auto);
    JY.co_learn=coroutine.create(Learn);
    JY.co_fight=coroutine.create(Fight);
    if fileexist(CC.R_GRPFilename[1]) then
        LoadRecord(1);
        math.randomseed(JY.Base.Seed);
        JY.Status=GAME_AUTO;
    else
        NewPerson();
    end
    lib.Debug("game start");
    JYOL_Mini_Endless_Cycle();
end


--创建新角色
function NewPerson()
    JY.Leaving={};
    if JY.Status~=GAME_START then
        JY.Status=GAME_START;
        for i=101,9999 do
            table.insert(JY.Leaving,JY.Base["武功等级"..i]);
        end
    end
    LoadRecord(0);
    ResetAttrib();
    JY.Person[JY.pid]["名称"]=IniName();
    OpenPersonIni();
end

--干嘛的
function ResetAttrib()
    JY.pid=0;
    for i,v in pairs({"膂力","根骨","机敏","悟性","福缘"}) do
    JY.Base[v.."加值"]=0;
    end
    JY.Base["潜能"]=500;
    JY.Base["实战"]=0;
    JY.Base["节"]=0;
    JY.Base["秒"]=0;
    JY.Base["分"]=0;
    JY.Base["时"]=0;
    JY.Person[JY.pid]["生命最大值"]=100;
    JY.Person[JY.pid]["内力最大值"]=80;
    JY.Person[JY.pid]["生命"]=JY.Person[JY.pid]["生命最大值"];
    JY.Person[JY.pid]["内力"]=JY.Person[JY.pid]["内力最大值"];
    for i,v in pairs({"膂力","根骨","机敏","悟性","福缘"}) do
        JY.Person[JY.pid][v]=4; 
        JY.Base[v.."成长"]=0; 
    end
    JY.Base["自由属性点"]=10;
    JY.Base["相性"]=math.random(256)-1; 
    SetFreePoint();
    for i=1,5 do
        if JY.Person[JY.pid]["武功"..i]>0 then
            local n=JY.Person[JY.pid]["武功"..i]
            JY.Base["武功等级"..n]=JY.Person[JY.pid]["武功等级"..i];
        end
    end
    for i,v in pairs({"内功","轻功","特技"}) do
        if JY.Person[JY.pid][v]>0 then
        local n=JY.Person[JY.pid][v]
            JY.Base["武功等级"..n]=JY.Person[JY.pid][v.."等级"];
        end
    end 
end

--主菜单
function MainMenu()
    local bt={}
    local x,y=154,120;
    table.insert(bt,{id=1,x1=x,y1=y,x2=x+146,y2=y+36,tx=x+73,ty=y+18,txt="重新开始",pic1=145,pic2=146,pic3=147,pic4=148,enable=true,show=true})
    y=y+42;
    table.insert(bt,{id=2,x1=x,y1=y,x2=x+146,y2=y+36,tx=x+73,ty=y+18,txt="读取存档",pic1=145,pic2=146,pic3=147,pic4=148,enable=true,show=true})
    y=y+42;
    table.insert(bt,{id=3,x1=x,y1=y,x2=x+146,y2=y+36,tx=x+73,ty=y+18,txt="离开游戏",pic1=145,pic2=146,pic3=147,pic4=148,enable=true,show=true})
    if not fileexist(CC.R_GRPFilename[1]) then
        bt[2].enable=false;
    end
    local current=0;
    local hold=false;
    local function redraw()
        lib.PicLoadCache(0,490*2,0,0,1);
        for i,v in pairs(bt) do
            if v.show then
                if v.enable then
                    if current==v.id then
                        if hold then
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
                if #v.txt>0 then
                    if current==v.id and hold then
                        DrawStringS(v.tx-16*#v.txt/4+1,v.ty-16/2+1,v.txt,C_WHITE,16);
                    else
                        DrawStringS(v.tx-16*#v.txt/4,v.ty-16/2,v.txt,C_WHITE,16);
                    end
                end
            end
        end
    end
    
    while true do
        local t1=lib.GetTime();
        redraw();
        ShowScreen();
        local delay=CC.FrameNum-lib.GetTime()+t1;
        if delay>0 then
            lib.Delay(delay);
        end
        getkey();
        current=0;
        hold=false;
        for i,v in pairs(bt) do
            if v.show then
                if v.enable then
                    if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
                        PlayWavE(0);
                        return v.id;
                    elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
                        current=v.id;
                        hold=true;
                    elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
                        current=v.id;
                    end
                else
                    if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
                        PlayWavE(1);
                    end
                end
            end
        end
    end
end


function JYOL_Mini_Endless_Cycle()
    local t0=os.clock();
    local t1;
    local t2;
    if JY.Base["倒计时"]>0 then
        JY.bt[5].txt=string.format("%02d:%02d",math.modf(JY.Base["倒计时"]/60),JY.Base["倒计时"]%60);
    else
        JY.bt[5].txt="Boss";
        SetMainMenu();
    end
    
    while JY.Status>=0 do
        t2=lib.GetTime();
        DrawGame();
        ShowScreen();
        for i=1,JY.SPD do
            JYOL_Mini_Endless_Core();
        end
        --======================--
        JY.Base["节"]=JY.Base["节"]+1;
        if JY.Base["节"]>=20 then 
            JY.Base["节"]=0;
            JY.Base["秒"]=JY.Base["秒"]+1;
            if JY.Base["倒计时"]>0 then
                JY.Base["倒计时"]=JY.Base["倒计时"]-JY.SPD;
                if JY.Base["倒计时"]>0 then
                    JY.bt[5].txt=string.format("%02d:%02d",math.modf(JY.Base["倒计时"]/60),JY.Base["倒计时"]%60);
                else
                    JY.bt[5].txt="Boss";
                    SetMainMenu();
                end
            end
            if JY.Base["秒"]>=60 then 
                JY.Base["秒"]=0;
                JY.Base["分"]=JY.Base["分"]+1;
                if JY.Base["分"]>=60 then 
                    JY.Base["分"]=0;
                    JY.Base["时"]=JY.Base["时"]+1;
                end
                --每分钟自动存档一次
                JY.Base.Seed=math.random(999999);
                SaveRecord(1);
                math.randomseed(JY.Base.Seed);
            end
        end
        local delay=CC.FrameNum-lib.GetTime()+t2;
        if delay>0 then
            lib.Delay(delay);
        end
        getkey();
        ButtonEvent();
        t1=os.clock();
        if t1-t0<0.045 then
            CycleDelay(0.05);
        end
        t0=os.clock();
    end
end


function CycleDelay(delay)
    local t0=os.clock();
    while between(os.clock()-t0,0,delay) do
        getkey();
    end
end

function JYOL_Mini_Endless_Core()
    if #JY.TEXT_BUFF>0 then --显示文本
        ShowText();
    elseif JY.WAIT>0 then
        JY.WAIT=JY.WAIT-1;
    elseif JY.Status==GAME_AUTO then
        coroutine.resume(JY.co_auto);
    elseif JY.Status==GAME_FIGHT then
        coroutine.resume(JY.co_fight);
    elseif JY.Status==GAME_LEARN then
        coroutine.resume(JY.co_learn);
    elseif JY.Status==GAME_START then  
    end
end

function cycle_test()
    while #JY.TEXT_BUFF>0 do
        ShowText();
        DrawGame();
        DrawString(16,32,JY.TEXT_BUFF,C_WHITE,16);
        ShowScreen();
        getkey();
    end
end


function Auto()
    while true do
        GetTitle();
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white正在思考做什么...\\n";
        JY.WAIT=4;
        coroutine.yield();
        local r=math.random(100);
        if JY.Base["指令"]>0 then
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得生无可恋...\\n";
            JY.WAIT=4;
            coroutine.yield();
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定转世重生...\\n";
            JY.WAIT=4;
            coroutine.yield();
            for i=1,6 do
                JY.TEXT_BUFF="........................\\n";
                JY.WAIT=4;
                coroutine.yield();
            end
            JY.Base["指令"]=0;
            NewPerson();
            coroutine.yield();
        elseif JY.Base["当前事件"]>0 then
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去挑战Boss...\\n";
            JY.WAIT=4;
            coroutine.yield();
            MapEvent();
        elseif JY.Base["下个场景"]>0 then 
            EnterMap();
        elseif r<4 then
            Sleep();
        elseif r<7 then
            Thinking();
        elseif r<10 then
            Eating();
        elseif r<12 then
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去和路人聊天...\\n";
            JY.WAIT=4;
            coroutine.yield();
            MapTalk("老头","当日华山论剑，他用\\orange黯然销魂掌\\white，破了我的七十二路\\orange空明拳\\white；我改\\orange降龙十八掌\\white，他伸开食指中指，竟是\\orange六脉神剑\\white商阳剑和中冲剑并用，又胜我一筹。可见天下武功彼此克制，武学之道玄之又玄！\\n");
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white听得心驰目眩...\\n";
            JY.WAIT=4;
            coroutine.yield();
            MapTalk("老太太","玩个石头剪子布都说得这般威风！\\n");
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white目瞪口呆...\\n";
            JY.WAIT=4;
            coroutine.yield();
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white历练上升！\\n";
            JY.WAIT=4;
            coroutine.yield();
            if JY.Person[JY.pid]["等级"]<99 then
                JY.Base["实战"]=JY.Base["实战"]+1;
                CheckLvUp(JY.pid);
            end
        elseif r<15 and CanRetreat() then
            Retreat();
        elseif r<20 then
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white想了半天，还是不知道要做什么...\\n";
            JY.WAIT=4;
            coroutine.yield();
        elseif r<21 then
            Xiaobao();
        elseif r<limitX(25+math.modf(JY.Base["潜能"]/200),25,50) then
            JY.Status=GAME_LEARN;
            coroutine.yield();
        elseif r>100-8*JY.Person[JY.pid]["性别"] then
            Girl();
        else
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去找人比武...\\n";
            JY.WAIT=4;
            coroutine.yield();
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white正在寻找对手...\\n";
            JY.WAIT=4;
            coroutine.yield();
            if r>90 then
                JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white还在寻找对手...\\n";
                JY.WAIT=4;
                coroutine.yield();
            end
            if r>95 then
                JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white没有发现对手...\\n";
                JY.WAIT=4;
                coroutine.yield();
            else
                MapFight();
            end
        end
    end
end

function GetTitle()
	for tid=1,24 do
		if JY.Base["开启称号"..tid]==0 then
			local pass=true;
			--等级
			if JY.Person[0]["等级"]<JY.Item[tid]["需人物等级"] then
				pass=false;
			end
			--关卡
			 if JY.Item[tid]["需通过场景"]>0 then
				local sid=JY.Item[tid]["需通过场景"];
				local sta=1+JY.Item[tid]["需通过场景进度"];
				if JY.Base["开启场景"..sid]<sta then
					pass=false;
				end
			 end
			--武功组合
			for i=1,6 do
				local kfid=JY.Item[tid]["需武功"..i];
				if kfid>0 then
					if JY.Base["武功等级"..kfid]<JY.Item[tid]["需武功等级"] then
						pass=false;
					end
				end
			end
			
			if pass then
				GetTitle_sub(tid);
			end
		end
	end
end

function GetTitle_sub(tid)
    local p=JY.Person[0];
    PlayWavE(11);
    JY.Base["开启称号"..tid]=1;
    InsertLog(8,tid,0);
    JY.TEXT_BUFF=string.format("\\yellow%s\\white获得称号\\orange%s\\white！\\n",p["名称"],JY.Item[tid]["名称"]);
    JY.WAIT=4;
    coroutine.yield();
    for i,v in pairs({"生命","内力"}) do
        if JY.Item[tid][v]>0 then
            p[v.."最大值"]=p[v.."最大值"]+JY.Item[tid][v];
            p[v]=p[v.."最大值"];
            JY.TEXT_BUFF=string.format("\\yellow"..p["名称"].."\\white%s上限上升到%d \\green(%+d)\\white！\\n",v,p[v],JY.Item[tid][v]);
            InsertLog(2,i,p[v]);
            JY.WAIT=4;
            coroutine.yield();
        end
    end
    for i,v in pairs({"伤害","命中","格挡","闪避"}) do
        if JY.Item[tid][v]>0 then
            JY.Base["基本"..v]=JY.Base["基本"..v]+JY.Item[tid][v];
            JY.TEXT_BUFF=string.format("\\yellow"..p["名称"].."\\white基本%s上升到%d \\green(%+d)\\white！\\n",v,JY.Base["基本"..v],JY.Item[tid][v]);
            InsertLog(2,i+7,JY.Base["基本"..v]);
            JY.WAIT=4;
            coroutine.yield();
        end
    end
end

function GetWeapon(tid)
	tid=tid-100;
	if between(tid,01,24) and JY.Base["开启武器"..tid]==0 then
		local p=JY.Person[0];
		PlayWavE(11);
		JY.Base["开启武器"..tid]=1;
		InsertLog(9,tid+100,0);
		JY.TEXT_BUFF=string.format("\\yellow%s\\white获得武器\\green%s\\white！\\n",p["名称"],JY.Item[tid+100]["名称"]);
		JY.WAIT=4;
		coroutine.yield();
	end
end

function Xiaobao()
    local name_t={"韦小宝","韦小宝","韦小宝","韦小宝","莫小宝","宋小宝"};
    local xb_name=name_t[math.random(#name_t)];
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white结识了\\yellow"..xb_name.."\\white，相谈甚欢...\\n";
    JY.WAIT=4;
    coroutine.yield();
    for i=1,4+math.random(8) do
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white被\\yellow"..xb_name.."\\white忽悠中............\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white潜能减少............\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.Base["潜能"]=limitX(JY.Base["潜能"]-10,0,9999);
    end
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white与\\yellow"..xb_name.."\\white友好度上升...\\n";
    JY.WAIT=4;
    coroutine.yield();
end

function Girl()
    local str_l={"描眉","画眉","傅粉","梳妆","自恋",
    "绣花","绣鸳鸯","绣粉蝶","绣荷包","绣花","绣花","绣花","绣花","绣花"}
    local r;
    if JY.Person[JY.pid]["性别"]>1 then
        r=math.random(9);
    else
        r=math.random(#str_l);
    end
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去"..str_l[r].."...\\n";
    JY.WAIT=4;
    coroutine.yield();
    for i=1,6+math.random(6)*JY.Person[JY.pid]["性别"] do
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white"..str_l[r].."中............\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
    if r>5 then
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得自己绣的真美...\\n";
    else
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得自己真的很美...\\n";
    end
    JY.WAIT=4;
    coroutine.yield();
end



function Sleep()
    Record("睡觉次数");
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去睡觉...\\n";
    local r=math.random(100);
    JY.WAIT=4;
    coroutine.yield();
    JY.TEXT_BUFF="zZzZzZ\\n";
    JY.WAIT=4;
    coroutine.yield();
    JY.TEXT_BUFF="zZzZzZzZzZzZ\\n";
    JY.WAIT=4;
    coroutine.yield();
    JY.TEXT_BUFF="zZzZzZzZzZzZzZzZzZ\\n";
    JY.WAIT=4;
    coroutine.yield();
    if between(r,97,100) then
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white梦到仙人指点了一套武功";
        JY.WAIT=4;
        coroutine.yield();
        local kf_t={};
        for i=1,JY.KungfuNum-1 do
            if JY.Kungfu[i]["做梦"]>0 then
                table.insert(kf_t,i);
                if JY.Kungfu[i].Lv<5 then
                    table.insert(kf_t,i);
                    if JY.Kungfu[i].Lv<3 then
                        table.insert(kf_t,i);
                    end
                end
            end
        end
        local kfid=TableRandom(kf_t);
        if kfid<=0 then
            kfid=110;
        end
        JY.TEXT_BUFF="，似乎叫做\\orange"..JY.Kungfu[kfid]["名称"].."\\white。\\n";
        JY.WAIT=4;
        coroutine.yield();
        InsertLog(5,0,kfid);
        JY.TEXT_BUFF="zZzZzZ\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.TEXT_BUFF="zZzZzZzZzZzZ\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.TEXT_BUFF="zZzZzZzZzZzZzZzZzZ\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white睡醒了";
        JY.WAIT=4;
        coroutine.yield();
        if JY.Base["武功等级"..kfid]>0 then
            JY.TEXT_BUFF="，发现自己本来就会\\orange"..JY.Kungfu[kfid]["名称"].."\\white。\\n";
            InsertLog(5,1,kfid);   
        elseif JY.Kungfu[kfid].Lv>7 or math.random(60)>10+JY.Person[JY.pid]["福缘"] then
            JY.TEXT_BUFF="，发现原来真的只是做了一场梦。\\n";
            InsertLog(5,2,kfid);
        elseif CheckKungfu(kfid) and CheckXX(kfid) and math.random(50)<20+JY.Person[JY.pid]["悟性"]-JY.Kungfu[kfid].Lv*2 then
            JY.TEXT_BUFF="，发现自己真的学会了\\orange"..JY.Kungfu[kfid]["名称"].."\\white！\\n";
            JY.Base["武功等级"..kfid]=1;
            InsertLog(3,JY.Base["武功等级"..kfid],kfid);
            PlayWavE(11);
        else
            JY.TEXT_BUFF="，发现梦中学会的武功全都忘记了。\\n";
            InsertLog(5,3,kfid);
        end
        JY.WAIT=4;
        coroutine.yield();
    else
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white睡醒了";
        JY.WAIT=4;
        coroutine.yield();
        if r<50 then
            JY.TEXT_BUFF="，做了个噩梦。\\n";
            JY.WAIT=4;
            coroutine.yield();
        else
            JY.TEXT_BUFF="，睡得好香啊。\\n";
            JY.WAIT=4;
            coroutine.yield();
        end
    end
    JY.Person[JY.pid]["生命"]=JY.Person[JY.pid]["生命最大值"];
    JY.Person[JY.pid]["内力"]=JY.Person[JY.pid]["内力最大值"];
end



function Eating()
    Record("进食次数");
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得饿了...\\n";
    JY.WAIT=4;
    coroutine.yield();
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white正在思考吃什么...\\n";
    JY.WAIT=4;
    coroutine.yield();
    for i=1,3+math.random(3) do
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white思考中............\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
    local str_l={"红烧肉","汤包","烧饼","麻花","包子","五香驴肉","刀削面","羊肉泡馍","锅盔","拉面","烤羊肉","抓饭","煎包","烧麦","酥油饼","棕子","八宝饭","豆皮","热干面","臭豆腐","月饼","龙抄手","担担面","汤圆","夫妻肺片","糍粑","卤牛肉","过桥米线","切糕","冷面","饺子","麻辣烫","打卤面","炸酱面","冰糖葫芦","花生酥","闷黄鱼","鸡蛋灌饼","烤肉","烤全羊","凤爪","牛肉干","柿饼","凉皮","鱼香肉丝","水煮鱼","小葱拌豆腐","皮蛋","烤鸭","烤红薯"}
    local r=math.random(#str_l);
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去吃\\orange"..str_l[r].."\\white...\\n";
    JY.WAIT=4;
    coroutine.yield();
    for i=1,3+math.random(3) do
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white进食中............\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
    r=math.random(10);
    if r<8 then
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white吃饱了！\\n";
        JY.WAIT=4;
        coroutine.yield();
    else
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white感觉还能再吃一点！\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
    JY.Person[JY.pid]["生命"]=JY.Person[JY.pid]["生命最大值"];
    JY.Person[JY.pid]["内力"]=JY.Person[JY.pid]["内力最大值"];
end



function Thinking()
    Record("思考次数");
    local str_l={"人生的意义","人与自然的关系","自己的未来","武林的和平"}
    local str_s={"人生","自然","未来","和平"}
    local r=math.random(#str_l);
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white正在思考"..str_l[r].."...\\n";
    JY.WAIT=4;
    coroutine.yield();
    for i=1,3+math.random(3) do
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white思考"..str_s[r].."中............\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
    r=math.random(10);
    if r<4 then
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white似乎想明白了什么，历练上升！\\n";
        JY.WAIT=4;
        coroutine.yield();
        if JY.Person[JY.pid]["等级"]<99 then
            JY.Base["实战"]=JY.Base["实战"]+10;
            CheckLvUp(JY.pid);
        end
    elseif r==4 then
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white突然感到十分空虚...\\n";
        JY.WAIT=4;
        coroutine.yield();
        for i=1,6+math.random(3) do
            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white空虚中............\\n";
            JY.WAIT=4;
            coroutine.yield();
        end
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white终于恢复正常了...\\n";
        JY.WAIT=4;
        coroutine.yield();
    else
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white想着想着睡着了...\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
end

function Retreat()
    Record("闭关次数");
    JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white决定去闭关...\\n";
    JY.WAIT=4;
    coroutine.yield();
    StartEFT(41);
    for i=1,5+math.random(5) do
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white闭关中............\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.Base["潜能"]=limitX(JY.Base["潜能"]-25,0,9999);
    end
    local r=math.random(100);
    if r<15 then --睡觉
        StopEFT();
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得困了...\\n";
        JY.WAIT=4;
        coroutine.yield();
        Sleep();
    elseif r<30 then --进食
        StopEFT();
        Eating();
    elseif r<45 then --思考
        StopEFT();
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white走神了...\\n";
        JY.WAIT=4;
        coroutine.yield();
        Thinking();
    else
        local kf_t={};
        local lw_kfid;
        for i=1,JY.LingwuNum-1 do
            lw_kfid=JY.Lingwu[i]["武功"];
            if lw_kfid>0 and JY.Base["武功等级"..lw_kfid]==0 and CheckKungfu(lw_kfid) then
                table.insert(kf_t,i);
            end
        end
        local lw=TableRandom(kf_t);
        lw_kfid=JY.Lingwu[lw]["武功"];
        local qz=JY.Lingwu[lw]["前置1"];
        if lw>0 and JY.Base["武功等级"..qz]>=5 then
            InsertLog(6,0,0);
            local flag=true;
            for idx=1,7 do
                StopEFT();
                qz=JY.Lingwu[lw]["前置"..idx];
                if qz>0 then
                    if JY.Base["武功等级"..qz]>0 then
                        local str="\\orange"..JY.Kungfu[qz]["名称"].."\\white";
                        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white从"..str.."中得到灵感...\\n";
                        JY.WAIT=4;
                        coroutine.yield();
                        StartEFT(qz);
                        for i=1,5+math.random(5) do
                            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white研习"..str.."中............\\n";
                            JY.WAIT=4;
                            coroutine.yield();
                            JY.Base["潜能"]=limitX(JY.Base["潜能"]-10,0,9999);
                        end
                        if JY.Base["武功等级"..qz]<JY.Lingwu[lw]["等级"..idx] then
                            StopEFT();
                            JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得"..str.."似乎还有可以提升的空间...\\n";
                            flag=false;
                            JY.WAIT=4;
                            coroutine.yield();
                            InsertLog(6,1,qz);
                            break;
                        end
                    else
                        StopEFT();
                        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white觉得似乎还欠缺点什么...\\n";
                        flag=false;
                        JY.WAIT=4;
                        coroutine.yield();
                        break;
                    end
                end
            end
            StopEFT();
            if flag then
                PlayWavE(11);
                JY.Base["武功等级"..lw_kfid]=1;
                InsertLog(3,JY.Base["武功等级"..lw_kfid],lw_kfid);
                JY.TEXT_BUFF=string.format("\\yellow%s\\white在闭关中领悟出\\orange%s\\n",JY.Person[JY.pid]["名称"],JY.Kungfu[lw_kfid]["名称"]);
                JY.WAIT=4;
                coroutine.yield();
                return;
            end
        else
            for i=1,5+math.random(5) do
                JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white闭关中............\\n";
                JY.WAIT=4;
                coroutine.yield();
                JY.Base["潜能"]=limitX(JY.Base["潜能"]-25,0,9999);
            end
        end
        StopEFT();
        PlayWavE(2);
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white没有什么收获...\\n";
        JY.WAIT=4;
        coroutine.yield();
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white闭关结束...\\n";
        JY.WAIT=4;
        coroutine.yield();
    end
end

function CanRetreat()
    if JY.Base["潜能"]<1200 then
        return false;
    end
    for i=1,JY.LingwuNum-1 do
        local lw_kfid=JY.Lingwu[i]["武功"];
        if lw_kfid>0 and JY.Base["武功等级"..lw_kfid]==0 then
            return true;
        end
    end
    return false;
end

function EnterMap()
    local sid=JY.Base["下个场景"];
    local status=JY.Base["开启场景"..sid];
    local mid=1;
    if not between(status,1,6) then
        status=1;
        JY.Base["开启场景"..sid]=1;
    end
    mid=JY.Force[sid]["地图"..status];
    JY.Base["当前场景"]=sid;
    JY.Base["下个场景"]=0;
    JY.Base["当前地图"]=mid;
    JY.Base["倒计时"]=JY.Base.BossTimer;
    JY.CENTER_MSG="";
    JY.bt[5].txt=string.format("%02d:%02d",math.modf(JY.Base["倒计时"]/60),JY.Base["倒计时"]%60);
    JY.TEXT_BUFF=string.format("\\yellow%s\\white来到\\yellow%s\\n",JY.Person[JY.pid]["名称"],JY.Force[sid]["名称"]);
    SetMainMenu();
    JY.WAIT=4;
    coroutine.yield();
end

function MapFight()
    local e_level=0;
    local min=60*JY.Base["时"]+JY.Base["分"];
    if JY.Map[JY.Base["当前地图"]]["小Boss1"]>0 and math.random(100)<10 then
        local t_eid={};
        for i=1,10 do
            local v=JY.Map[JY.Base["当前地图"]]["小Boss"..i];
            if v>0 then
                table.insert(t_eid,v);
            end
        end
        JY.eid=TableRandom(t_eid);
        e_level=1;
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white发现对手\\yellow"..JY.Person[JY.eid]["名称"].."\\n";
    else
        local t_eid={};
        for i=1,20 do
            local v=JY.Map[JY.Base["当前地图"]]["杂兵"..i];
            if v>0 then
                table.insert(t_eid,v);
            end
        end
        JY.eid=TableRandom(t_eid);
        JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white发现对手"..JY.Person[JY.eid]["名称"].."\\n";
    end
    JY.WAIT=4;
    coroutine.yield();
    CallFight(e_level);
end


function MapEvent()
    local sid=JY.Base["当前场景"];
    local m=JY.Map[JY.Base["当前地图"]]
    local pass=true;
    for i=1,10 do
    JY.CENTER_MSG="";
    local eid=m["通关Boss"..i];
       if eid>0 then
           JY.eid=eid;
           if m["战斗前剧情"..i]>0 then
               JY.TEXT_BUFF=JY.Str[m["战斗前剧情"..i]];
           else
               JY.TEXT_BUFF=JY.Str[1];
           end
           JY.TEXT_BUFF=GenEventStr(JY.TEXT_BUFF);
           JY.WAIT=4;
           coroutine.yield();
           if CallFight(2) then
               if m["战斗后剧情"..i]>0 then
                   JY.TEXT_BUFF=JY.Str[m["战斗后剧情"..i]];
                   Y.TEXT_BUFF=GenEventStr(JY.TEXT_BUFF);
                   JY.WAIT=4;
                   coroutine.yield();
               end
           else
               pass=false;
               break;
           end
       end
    end
    if pass then
        JY.Base["开启场景"..sid]=JY.Base["开启场景"..sid]+1;
        if JY.Base["开启场景"..sid]>6 then
            JY.Base["开启场景"..sid]=6
        end
        JY.Base["当前地图"]=JY.Force[sid]["地图"..JY.Base["开启场景"..sid]];
        SetMapEntry();
    end
    JY.Base["当前事件"]=0;
    JY.Base["倒计时"]=JY.Base.BossTimer;
    JY.bt[5].txt=string.format("%02d:%02d",math.modf(JY.Base["倒计时"]/60),JY.Base["倒计时"]%60);
    SetMainMenu();
end


function GenEventStr(str)
	str=string.gsub(str,"$N",JY.Person[JY.pid]["名称"]);
	str=string.gsub(str,"$C",JY.Person[JY.pid]["外号"]);
	str=string.gsub(str,"$n",JY.Person[JY.eid]["名称"]);
	str=string.gsub(str,"$c",JY.Person[JY.eid]["外号"]);
	return str;
end

function MapTalk(name,s)
    if name=="主角" then
        name=JY.Person[JY.pid]["名称"];
    end
    if #name==0 then
        JY.TEXT_BUFF=s.."\\n";
    else
        JY.TEXT_BUFF="\\yellow"..name.."\\white: "..s.."\\n";
    end
    JY.WAIT=4;
    coroutine.yield();
end


function CallFight(e_level)
	JY.Status=GAME_FIGHT;
	coroutine.yield();
	local qn=1;
	local ll=1;
	local win=false;
	Record("战斗次数");
	if JY.Person[JY.pid]["生命"]>0 then --胜利了
		win=true;
		Record("胜利次数");
		if math.random(100)<40+20*e_level then
			local t_kf={};
			if JY.Person[JY.eid]["掉落武器"]>0 then
				table.insert(t_kf,1);	--掉落武器
			else
				table.insert(t_kf,0);
			end
			for i=1,5 do
				if JY.Person[JY.eid]["掉宝"..i]>1 then
					table.insert(t_kf,JY.Person[JY.eid]["掉宝"..i])
				else
					table.insert(t_kf,0);
				end
			end
			local kfid=TableRandom(t_kf);
			if kfid==0 then

			elseif e_level>1 then
				InsertLog(4,2,JY.eid);
			else
				InsertLog(4,0,JY.eid);
			end
			if kfid==1 then
				local tid=JY.Person[JY.eid]["掉落武器"]
				if math.random()<JY.Item[tid]["暴率"]/1000 then
					GetWeapon(tid);
				end
			elseif kfid>0 and JY.Base["武功等级"..kfid]==0 and CheckKungfu(kfid) and CheckXX(kfid) then
				if math.random()<JY.Kungfu[kfid]["暴率"]/1000 then
					PlayWavE(11);
					JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white在战斗中领悟了\\orange"..JY.Kungfu[kfid]["名称"].."\\n";
					JY.WAIT=4;
					coroutine.yield();
					if JY.Kungfu[kfid]["性别"]==4 and JY.Person[JY.pid]["性别"]~=2 then
						
					else
						JY.Base["武功等级"..kfid]=1;
						InsertLog(3,JY.Base["武功等级"..kfid],kfid);
					end
				end
			end
		end
		qn=JY.Person[JY.eid]["生命最大值"]+math.random(10)-math.random(10);
	else
		if e_level>1 then
			InsertLog(4,3,JY.eid);
		end
		qn=1+math.modf((JY.Person[JY.eid]["生命最大值"]-JY.Person[JY.eid]["生命"])/2);
	end
	if JY.Person[JY.pid]["等级"]/3>JY.Person[JY.eid]["等级"] then
		qn=1+math.floor(qn*10/(10+JY.Person[JY.pid]["等级"]/3-JY.Person[JY.eid]["等级"]));
	end
	if qn>600 then
		qn=150+math.floor(qn/4);
	elseif qn>300 then
		qn=100+math.floor(qn/3);
	elseif qn>100 then
		qn=50+math.floor(qn/2);
	end
	if e_level>1 and win then
		JY.Person[JY.pid]["生命"]=limitX(math.modf((JY.Person[JY.pid]["生命"]*1+JY.Person[JY.pid]["生命最大值"])/2),1,JY.Person[JY.pid]["生命最大值"]);
		JY.Person[JY.pid]["内力"]=limitX(math.modf((JY.Person[JY.pid]["内力"]*1+JY.Person[JY.pid]["内力最大值"])/2),1,JY.Person[JY.pid]["内力最大值"]);
	else
		JY.Person[JY.pid]["生命"]=JY.Person[JY.pid]["生命最大值"];
		JY.Person[JY.pid]["内力"]=JY.Person[JY.pid]["内力最大值"];
	end
	JY.pid=0;
	JY.Base["潜能"]=limitX(JY.Base["潜能"]+qn,0,9999);
	JY.TEXT_BUFF=string.format("\\yellow%s\\white得到潜能%d点。\\n",JY.Person[JY.pid]["名称"],qn);
	JY.WAIT=4;
	coroutine.yield();
	Record("潜能合计",qn);
	if e_level>1 then
		ll=9;
	elseif e_level>0 then
		ll=3;
	else
		ll=1;
	end
	if JY.Person[JY.pid]["等级"]/3>JY.Person[JY.eid]["等级"]+4 then
		ll=1;
	elseif JY.Person[JY.pid]["等级"]/3<JY.Person[JY.eid]["等级"] then
		if win then
			ll=ll+3;
		end
	else
		if win then
			ll=ll+1;
		end
	end
	if math.random(100)<JY.Person[JY.pid]["福缘"] then 
		ll=ll+1;
	end
	JY.TEXT_BUFF="\\yellow"..JY.Person[JY.pid]["名称"].."\\white历练上升！\\n";
	JY.WAIT=4;
	coroutine.yield();
	if JY.Person[JY.pid]["等级"]<99 then
		JY.Base["实战"]=JY.Base["实战"]+ll;
		CheckLvUp(JY.pid);
	end
	return win;
end



function CheckXX(kfid)
	local k=JY.Kungfu[kfid];
 	local kfxx=0;
 	for i=1,#k["名称"] do
		kfxx=kfxx+string.byte(k["名称"],i);
 	end
 	kfxx=kfxx%128
 	local xx=math.abs(JY.Base["相性"]-kfxx*2)%256;
 	xx=math.min(xx,256-xx);
 	xx=limitX(xx*k.Lv/7,0,128);
 	if math.random()>0.97^xx then
        return false;
    else
        return true;
    end
end

function CheckKungfu(kfid,flag)
    --flag bixie/kuihua
    local p=JY.Person[JY.pid];
    local k=JY.Kungfu[kfid];
    
    if p["性别"]==0 then
        if k["性别"]==1 or k["性别"]==3 or k["性别"]==5 or k["性别"]==7 then
            return true;
        end
        --bixie/kuihua
        if flag then
            if k["性别"]==4 then
                return true;
            end
        end
    elseif p["性别"]==1 then
        if k["性别"]==2 or k["性别"]==3 or k["性别"]==6 or k["性别"]==7 then
            return true;
        end
    elseif p["性别"]==2 then
        if k["性别"]==4 or k["性别"]==5 or k["性别"]==6 or k["性别"]==7 then
            return true;
        end  
    elseif p["名称"]=="大武侠" and (p["性别"]==0 or p["性别"]==1) then
        if k["性别"]==1 or k["性别"]==2 or k["性别"]==3 or k["性别"]==5 or k["性别"]==6 or k["性别"]==7 then
            return true;
        end   
    end
    return false;
end

function SetMapEntry()
	for i=1,24 do
		if JY.Base["开启场景"..i]==0 then
			local flag=true;
			for j=1,10 do
				if JY.Force[i]["前置地图"..j]>0 then
					local sid=JY.Force[i]["前置地图"..j];
					local sta=1+JY.Force[i]["前置地图进度"..j];
					if JY.Base["开启场景"..sid]<sta then
						flag=false;
						break;
					end
				end
			end
			if flag then
				PlayWavE(11);
				JY.Base["开启场景"..i]=1;
				JY.TEXT_BUFF=string.format("\\yellow%s\\white开放！\\n",JY.Force[i]["名称"]);
				JY.WAIT=4;
				coroutine.yield();
			end
		end
	end
end


function Fight()
    while true do
        Fight_sub();
        JY.Status=GAME_AUTO;
        coroutine.yield();
    end
end




function Fight_sub()
    JY.info={};
    JY.info[JY.pid]={
    is_def=false;
    s_pic=0;
    };
    JY.info[JY.eid]={
    is_def=false;
    s_pic=0
    };
    JY.Person[JY.eid]["生命"]=JY.Person[JY.eid]["生命最大值"];
    JY.Person[JY.eid]["内力"]=JY.Person[JY.eid]["内力最大值"];
    JY.Person[JY.pid]["招架"]=0;
    JY.Person[JY.pid]["招架等级"]=0;
    for i=1,5 do
        if JY.Person[JY.pid]["武功"..i]>0 then
            JY.Person[JY.pid]["招架"]=JY.Person[JY.pid]["武功"..i];
            JY.Person[JY.pid]["招架等级"]=JY.Person[JY.pid]["武功等级"..i]
            break;
        end
    end
    JY.Person[JY.eid]["招架"]=0;
    JY.Person[JY.eid]["招架等级"]=0;
    for i=1,5 do
        if JY.Person[JY.eid]["武功"..i]>0 then
            JY.Person[JY.eid]["招架"]=JY.Person[JY.eid]["武功"..i];
            JY.Person[JY.eid]["招架等级"]=JY.Person[JY.eid]["武功等级"..i]
            break;
        end
    end
    local id1,id2=JY.pid,JY.eid;
    if math.random()<(JY.Person[id2]["机敏"]+JY.Person[id2]["福缘"])/(JY.Person[id1]["机敏"]+JY.Person[id1]["福缘"]+JY.Person[id2]["机敏"]+JY.Person[id2]["福缘"]) then
        id1,id2=id2,id1;
    end
    JY.WAIT=8;
    coroutine.yield();
    DoAction(id1,id2,"TYPE_REGULAR");
    JY.info[JY.pid]={
    is_def=false;
    s_pic=0;
    };
    JY.info[JY.eid]={
    is_def=false;
    s_pic=0
    };
    JY.WAIT=8;
    coroutine.yield();
end

function DoAction(pid,eid,action_type)
    local guard_msg={
    [1]="$N注视著$n的行动，企图寻找机会出手。\\n",
    [2]="$N正盯著$n的一举一动，随时准备发动攻势。\\n",
    [3]="$N缓缓地移动脚步，想要找出$n的破绽。\\n",
    [4]="$N目不转睛地盯著$n的动作，寻找进攻的最佳时机。\\n",
    [5]="$N慢慢地移动著脚步，伺机出手。\\n",
    };
    local riposte_msg={
    [1]="$N一击不中，露出了破绽！\\n",
    [2]="$n见$N攻击失误，趁机发动攻击！\\n"
    };
    local beast_msg = {
    [1]="$N怒吼一声，扑了过来攻击$n！\\n",
    [2]="$N对着$n大吼，想杀死$n！\\n",
    [3]="$N发出连串低吼，突然暴起攻击$n！\\n",
    [4]="$N对着$n一声怒鸣，飞冲了过来！\\n" ,
    [5]="$N怒鸣几声，突然暴起攻击$n！\\n" ,
    [6]="$N一声锐鸣，猛然向$n发起攻击！\\n" ,
    };
    local limb_damage={
    --人类身体部位
    [1]={"头部",100},
    [2]={"颈部",90},
    [3]={"胸口",90},
    [4]={"后心",80},
    [5]={"左肩",50},
    [6]={"右肩",55},
    [7]={"左臂",40},
    [8]={"右臂",45},
    [9]={"左手",20},
    [10]={"右手",30},
    [11]={"腰间",60},
    [12]={"小腹",70},
    [13]={"左腿",40},
    [14]={"右腿",50},
    [15]={"左脚",35},
    [16]={"右脚",40},
    --动物身体部位
    [17]={"身体",80},
    [18]={"前脚",40},
    [19]={"后脚",50},
    [20]={"腿部",40},
    [21]={"尾巴",10},
    [22]={"翅膀",50},
    [23]={"爪子",40},
    };
    local limb_t={};
    for i=1,16 do
        if limb_damage[i][2]+30>JY.Person[pid]["福缘"]*5 then
            table.insert(limb_t,10);
        elseif limb_damage[i][2]+30>JY.Person[pid]["福缘"]*4 then
            table.insert(limb_t,5);
        else
            table.insert(limb_t,2);
        end
    end
    local beast=0;
    local limb_index=PercentRandom(limb_t);
    local limb=limb_damage[limb_index][1];
    local N_str,n_str,w_str,i_str,l_str;
    N_str="\\yellow"..JY.Person[pid]["名称"].."\\white";
    n_str="\\yellow"..JY.Person[eid]["名称"].."\\white";
    w_str="无形掌力";
    i_str="无形掌力";
    local weapon;
    weapon=JY.Person[pid]["武器"];
    if weapon>0 then
        w_str=JY.Item[weapon]["名称"]
    end
    weapon=JY.Person[eid]["武器"];
    if weapon>0 then
        i_str=JY.Item[weapon]["名称"]
    end
    l_str=limb;
    if JY.Person[pid]["生命"]<=0 then
        return;
    end
    JY.info[pid].is_def=false;
    if action_type=="TYPE_REGULAR" then
        if math.random(10)<3 then 
            JY.info[pid].is_def=true;
            JY.info[pid].s_pic=1014;
            PlayWavE(6);
            JY.TEXT_BUFF=GenFightStr(guard_msg[math.random(5)],N_str,n_str,w_str,i_str,l_str);
            JY.WAIT=4;
            coroutine.yield();
            if pid==0 then
                Record("防御次数");
            end
    
            JY.info[pid].s_pic=0;
            DoAction(eid,pid,"TYPE_REGULAR");
            return;
        elseif math.random()>0.3+0.6*JY.Person[pid]["生命"]/JY.Person[pid]["生命最大值"] then
            beast=math.random(#beast_msg);
        end
    end
    local atk_kf_id,atk_skill_id,msg,ap,dp,pp,damage,damage_type,nl_cost;
    local damage2,ap2,pp2,dp2;
    atk_kf_id,atk_skill_id,damage_type,msg,ap,damage,nl_cost=Query_Action(pid);
    damage2,ap2,pp2,dp2=GetBasePT(pid,false);
    damage=damage*0.7+damage2*0.3;
    ap=ap*0.7+ap2*0.3;
       weapon=JY.Person[pid]["武器"];
       local use_weapon=false;
       if weapon>0 then
           if JY.Item[weapon]["类型"]==JY.Kungfu[atk_kf_id]["类型描述"] then
               w_str=JY.Item[weapon]["名称"];
               use_weapon=true;
           end
       end
       if use_weapon then
           w_str="\\green"..w_str.."\\white";
           damage=damage+JY.Item[weapon]["伤害"];
           ap=ap+JY.Item[weapon]["命中"];
       else
           w_str=JY.Kungfu[atk_kf_id]["武器"];
       end
    local kfid,lv;
    for i,v in pairs({"内功","轻功","特技"}) do
        kfid=JY.Person[pid][v];
        lv=JY.Person[pid][v.."等级"];
        if kfid>0 then
            if pid==0 then
                lv=QueryMySkillLv(kfid);
            end
            ap=ap+JY.Kungfu[kfid].AP*(5+lv);
            damage=damage+JY.Kungfu[kfid].Damage*(5+lv);
        end
    end
    dp=0;
    pp=0;
    kfid=JY.Person[eid]["招架"];
    lv=JY.Person[eid]["招架等级"];
    if kfid>0 then
        if eid==0 then
            lv=QueryMySkillLv(kfid,061);
        end
        dp=JY.Kungfu[kfid].DP*(5+lv);
        pp=JY.Kungfu[kfid].PP*(5+lv);
    end
    damage2,ap2,pp2,dp2=GetBasePT(eid,false);
    pp=pp*0.7+pp2*0.3;
    dp=dp*0.7+dp2*0.3;
    weapon=JY.Person[eid]["武器"];
    i_str=JY.Kungfu[kfid]["武器"];
    if weapon>0 then
        pp=pp+JY.Item[weapon]["格挡"];
        dp=dp+JY.Item[weapon]["闪避"];
        if JY.Item[weapon]["类型"]==JY.Kungfu[kfid]["类型描述"] then
            i_str="\\green"..JY.Item[weapon]["名称"].."\\white";
        end
    end
    
    for i,v in pairs({"内功","轻功","特技"}) do
        kfid=JY.Person[eid][v];
        lv=JY.Person[eid][v.."等级"];
        if kfid>0 then
            if eid==0 then
                lv=QueryMySkillLv(kfid);
            end
            dp=dp+JY.Kungfu[kfid].DP*(5+lv);
            pp=pp+JY.Kungfu[kfid].PP*(5+lv);
        end
    end
    --ap/dp/pp/damage修正
    ap=ap/10;
    dp=dp/10;
    pp=pp/10;
    damage=damage/10;
    if atk_skill_id>0 then
        ap=ap*JY.Skill[atk_skill_id].AP/1000;
        dp=dp*JY.Skill[atk_skill_id].VsDP/1000;
        pp=pp*JY.Skill[atk_skill_id].VsPP/1000;
        damage=damage*JY.Skill[atk_skill_id].Damage/1000;
    end
    damage=(damage)*(JY.Person[pid]["膂力"]/(JY.Person[pid]["膂力"]+JY.Person[eid]["根骨"]*1.5));
    damage=damage-math.modf(1.26^JY.Person[eid]["根骨"]-1);
    --内力影响
    damage=damage+limitX(JY.Person[pid]["内力"]/15,0,100)-limitX(JY.Person[eid]["生命最大值"]/10,0,100);
    damage=limitX(damage,1,damage/4+JY.Person[pid]["内力"]*10);
    --
    ap=ap*math.max(5,JY.Person[pid]["福缘"])/8+JY.Person[pid]["福缘"]*10;
    dp=dp*(JY.Person[eid]["机敏"])/20;
    pp=pp*(JY.Person[eid]["机敏"])/20;
    
    dp=math.modf(limitX(dp,0,dp/2+JY.Person[eid]["内力"]*10));
    pp=math.modf(limitX(pp,0,pp/2+JY.Person[eid]["内力"]*10));
    damage=damage+limb_damage[limb_index][2]*0.5;
    if pid==0 then
        damage=damage + JY.Base["基本伤害"];
        ap=ap + JY.Base["基本命中"];
    else
        damage=damage + JY.Person[pid]["等级"]/2+(1.1^JY.Person[pid]["等级"])*JY.Person[pid]["膂力"]/4;
        ap=ap + JY.Person[pid]["等级"]/2+(1.1^JY.Person[pid]["等级"])*JY.Person[pid]["福缘"]/4;
    end
    if eid==0 then
        pp=pp + JY.Base["基本格挡"];
        dp=dp + JY.Base["基本闪避"];
    else
        pp=pp + JY.Person[eid]["等级"]/2+(1.1^JY.Person[eid]["等级"])*JY.Person[eid]["机敏"]/4;
        dp=dp + JY.Person[eid]["等级"]/2+(1.1^JY.Person[eid]["等级"])*JY.Person[eid]["机敏"]/4;
    end
    
    if action_type=="TYPE_QUICK" then --命中上升，攻击下降
        msg="紧跟着"..msg;
        ap=ap*1.2;
        damage=damage*0.8;
    elseif JY.info[eid].is_def then --防守
        ap=ap*0.8;
        damage=damage*0.75;
    elseif beast>0 then
        msg=beast_msg[beast]..msg;
        damage=damage*1.2;
        ap=ap*2.0;
    end
        damage=math.modf(damage)+math.random(10)-math.random(10);
    if damage<1 then
        damage=1;
    end
    if ap<1 then
        ap=1;
    end
    if pid==0 then
        Record("伤害",damage);
        Record("命中",ap);
    elseif eid==0 then
        Record("格挡",pp);
        Record("闪避",dp);
    end
    
    JY.info[pid].s_pic=atk_kf_id+1100;
    PlayWavE(JY.Kungfu[atk_kf_id]["音效"]);
    JY.Person[pid]["内力"]=limitX(JY.Person[pid]["内力"]-nl_cost,0,JY.Person[pid]["内力最大值"]);
    JY.TEXT_BUFF=GenFightStr(msg,N_str,n_str,w_str,i_str,l_str);
    JY.WAIT=4;
    coroutine.yield();
    if pid==0 then
        Record("攻击次数");
    end
    JY.info[pid].s_pic=0;
    local dodge_msg;
    local dodge_or_parry=PercentRandom({dp,pp});
    if dodge_or_parry==1 then --DP
        dodge_msg=Query_Dodge(eid);
    else
        dodge_msg=Query_Parry(eid);
    end
    local damage_msg;
    if math.random()>limitX(ap/(ap+pp+dp),0.10,0.95) then --基础命中率为10%-95%
        if dodge_or_parry==1 then --DP
            PlayWavE(79);
            JY.info[eid].s_pic=1013;
        else
            PlayWavE(30);
            JY.info[eid].s_pic=1012;
        end
        JY.TEXT_BUFF=GenFightStr(dodge_msg.."\\n",N_str,n_str,w_str,i_str,l_str);
        JY.WAIT=8;
        coroutine.yield();
        if eid==0 then
            if dodge_or_parry==1 then --DP
                Record("闪避次数");
            else
                Record("格挡次数");
            end
        end
        JY.info[eid].s_pic=0;
        if action_type=="TYPE_RIPOSTE" then
    
        elseif JY.info[eid].is_def then
            JY.TEXT_BUFF=GenFightStr(riposte_msg[math.random(2)],N_str,n_str,w_str,i_str,l_str); --反击
            JY.WAIT=4;
            coroutine.yield();
            DoAction(eid,pid,"TYPE_RIPOSTE");
            if JY.Person[pid]["生命"]<=0 then
                PlayWavE(38);
                JY.info[eid].s_pic=1020;
                JY.info[pid].s_pic=1021;
                JY.TEXT_BUFF=GenFightStr(Query_Winner_Msg(),n_str,N_str,w_str,i_str,l_str);
                JY.WAIT=8;
                coroutine.yield();
            else
                DoAction(eid,pid,"TYPE_QUICK");
            end
        else
            DoAction(eid,pid,"TYPE_REGULAR");
        end
    else
        damage_msg=Query_Damage_Msg(damage,damage_type);
        if damage>JY.Person[eid]["生命"]/4 then
            PlayWavE(36);
        else
            PlayWavE(35);
        end
        if damage>999 then
            damage=999
        end
        JY.info[eid].s_pic=damage;
        JY.TEXT_BUFF=GenFightStr(damage_msg,N_str,n_str,w_str,i_str,l_str);
        JY.WAIT=8;
        coroutine.yield();
        if pid==0 then
            Record("命中次数");
        end
        JY.info[eid].s_pic=0;
   
   
        while damage>0 and JY.Person[eid]["生命"]>0 do
            if damage<10 then
                JY.Person[eid]["生命"]=JY.Person[eid]["生命"]-damage;
                if JY.Person[eid]["生命"]<0 then
                    JY.Person[eid]["生命"]=0;
                end
                damage=0;
                coroutine.yield();
            else
                JY.Person[eid]["生命"]=JY.Person[eid]["生命"]-10;
                damage=damage-10;
                coroutine.yield();
            end
        end
        if action_type=="TYPE_RIPOSTE" then

        elseif JY.Person[eid]["生命"]<=0 then
            PlayWavE(38);
            JY.info[pid].s_pic=1020;
            JY.info[eid].s_pic=1021;
            JY.TEXT_BUFF=GenFightStr(Query_Winner_Msg(),N_str,n_str,w_str,i_str,l_str);
            JY.WAIT=8;
            coroutine.yield();
        else
            JY.TEXT_BUFF=Query_Status_Msg(eid);
            JY.WAIT=8;
            coroutine.yield();
            DoAction(eid,pid,"TYPE_REGULAR");
        end
    end
end

function GenFightStr(str,N_str,n_str,w_str,i_str,l_str)
    str=string.gsub(str,"$N",N_str);
    str=string.gsub(str,"$n",n_str);
    str=string.gsub(str,"$p",n_str);
    str=string.gsub(str,"$w",w_str);
    str=string.gsub(str,"$i",i_str);
    str=string.gsub(str,"$l",l_str);
    return str;
end

function CheckSex(sex,sex_r)
    if sex==0 then
        if sex_r==1 or sex_r==3 or sex_r==5 or sex_r==7 then
            return true;
        end
    elseif sex==1 then
        if sex_r==2 or sex_r==3 or sex_r==6 or sex_r==7 then
            return true;
        end
    elseif sex==2 then
        if sex_r==4 or sex_r==5 or sex_r==6 or sex_r==7 then
            return true;
        end
    end
    return false;
end


function Query_Action(pid)
    local kfid,lv=0,0;
    local p=JY.Person[pid];
    local kf={};
    for i=1,5 do
        if p["武功"..i]>0 then
            table.insert(kf,1+p["武功等级"..i]*5);
        else
            table.insert(kf,0);
        end
    end
    local r=PercentRandom(kf);
    if r>0 then
        kfid=p["武功"..r];
        lv=p["武功等级"..r];
    end
    if kfid<=0 then
        kfid=001;
        lv=limitX(p["等级"],0,20);
    end
    if pid==0 then
        lv=QueryMySkillLv(kfid);
    end
    local nl_cost=lv+JY.Kungfu[kfid]["内力消耗"]*math.modf(1+lv/5);
    
       local function CheckPairs(sid)
           local kid;
           for i=1,6 do
               kid=JY.Skill[sid]["需武功"..i];
               if kid>0 then
                   local pass=false;
                   for i,v in pairs({"武功1","武功2","武功3","武功4","武功5","内功","轻功","特技"}) do
                       if p[v]==kid then
                           pass=true;
                           break;
                       end
                   end
                   if not pass then
                       return false;
                   end
               end
               kid=JY.Skill[sid]["忌武功"..i];
               if kid>0 then
                   for i,v in pairs({"武功1","武功2","武功3","武功4","武功5","内功","轻功","特技"}) do
                       if p[v]==kid then
                           return false;
                       end
                   end
               end
           end
           return true;
       end
    --select skill
    local skill_t={};
    local n=0
    for i,v in pairs(JY.Skill) do
        if v["武功"]==kfid then
            if v["类型"]=="攻击" and between(lv,v["等级1"],v["等级2"]) and CheckSex(p["性别"],v["性别"]) and CheckPairs(i) then
                table.insert(skill_t,i);
                n=n+1;
            end
        end
    end
    local skillid=0;
    local skillname=""
    if n==1 then
        skillid=skill_t[1];
    elseif n>1 then
        skillid=skill_t[math.random(n)];
    else
    
    end
    
    if skillid>0 then
        skillname=JY.Skill[skillid]["名称"];
    if string.len(JY.Skill[skillid]["名称"])>0 then
        skillname=JY.Kungfu[kfid]["名称"].."·"..skillname;
    else
        skillname=JY.Kungfu[kfid]["名称"];
    end

    local hurttype="伤害";
        hurttype=JY.Skill[skillid]["子类型"];
        if string.len(hurttype)>4 then
            hurttype=string.sub(hurttype,4*math.random((#hurttype)/4)-3);
            hurttype=string.sub(hurttype,1,4);
        end
    
        JY.Person[pid]["招架"]=kfid;
        JY.Person[pid]["招架等级"]=lv;
        return kfid,skillid,hurttype,JY.Skill[skillid]["文本"],JY.Kungfu[kfid].AP*(5+lv),JY.Kungfu[kfid].Damage*(5+lv),nl_cost;
    else
        return kfid,0,"伤害","$N使出\\orange"..JY.Kungfu[kfid]["名称"].."\\white，",JY.Kungfu[kfid].AP*(5+lv),JY.Kungfu[kfid].Damage*(5+lv),nl_cost;
    end
end



function Query_Dodge(pid)
    local function Query_Dodge_Sub(kfid)
        local skill_t={};
        for i,v in pairs(JY.Skill) do
            if v["武功"]==kfid then
                if v["类型"]=="闪避" then
                    table.insert(skill_t,i);
                end
            end
        end
        local skillid=TableRandom(skill_t);
        if skillid>0 then
            return JY.Skill[skillid]["文本"];
        else
            return "";
        end
    end
    local msg={};
    local pt={};
    local T={"招架","内功","轻功","特技"};
    for i,v in pairs(T) do
        local kfid=JY.Person[pid][v];
        local kflv=JY.Person[pid][v.."等级"];
        if kfid>0 then
            table.insert(msg,Query_Dodge_Sub(kfid));
        else
            table.insert(msg,"");
        end
        if kfid>0 and #msg[i]>0 then
            table.insert(pt,JY.Kungfu[kfid].DP*(5+kflv))
        else
            table.insert(pt,0);
        end
    end
    local r=PercentRandom(pt);
    if r>0 then
        return msg[r];
    else
        return Query_Dodge_Sub(51);
    end
end


function Query_Parry(pid)
    local function Query_Parry_Sub(kfid)
        local skill_t={};
        for i,v in pairs(JY.Skill) do
            if v["武功"]==kfid then
                if v["类型"]=="招架" then
                    table.insert(skill_t,i);
                end
            end
        end
        local skillid=TableRandom(skill_t);
        if skillid>0 then
            return JY.Skill[skillid]["文本"];
        else
            return "";
        end
    end
    local msg={};
    local pt={};
    local T={"招架","内功","轻功","特技"};
    for i,v in pairs(T) do
        local kfid=JY.Person[pid][v];
        local kflv=JY.Person[pid][v.."等级"];
        if kfid>0 then
            table.insert(msg,Query_Parry_Sub(kfid));
        else
            table.insert(msg,"");
        end
        if kfid>0 and #msg[i]>0 then
            table.insert(pt,JY.Kungfu[kfid].PP*(5+kflv))
        else
            table.insert(pt,0);
        end
    end
    local r=PercentRandom(pt);
    if r>0 then
        return msg[r];
    else
        return "但是被格开了。";
    end
end



function Query_Damage_Msg(damage,damage_type)
    if damage==0 then 
        return "结果没有造成任何伤害。\\n";
    end
    if damage_type=="割伤" or damage_type=="擦伤" or damage_type=="刀伤" or damage_type=="砍伤" then
        if damage<15 then
            return "结果只是轻轻地划破$p的皮肉。\\n";
        elseif damage<30 then
            return "结果在$p$l划出一道细长的血痕。\\n";
        elseif damage<60 then
            return "结果「嗤」地一声划出一道伤口！\\n";
        elseif damage<120 then
            return "结果「嗤」地一声划出一道血淋淋的伤口！\\n";
        elseif damage<240 then
            return "结果「嗤」地一声划出一道又长又深的伤口，溅得$N满脸鲜血！\\n";
        else
            return "结果只听见$n一声惨嚎，$w已在$p$l划出一道深及见骨的可怕伤口！！\\n";
        end
    elseif damage_type=="拉伤" or damage_type=="鞭伤" or damage_type=="抽伤" then
        if damage<15 then
            return "结果只是轻轻地划过了$n的皮肤。\\n";
        elseif damage<30 then
            return "结果在$n的$l抽出一道细长的血印。\\n";
        elseif damage<60 then
            return "结果「啪」地一声$w将$n的$l皮肤扯开，形成一道尺许长的伤口！\\n";
        elseif damage<120 then
            return "只听$n「啊」地一声吐出一口鲜血，原来$p$l内的骨头已经被$w的劲力抽裂！\\n";
        elseif damage<240 then
            return "结果随着「咔」地一声，$w已将$n$l处的骨头硬生生地抽断，断骨从肉里冒了出来！\\n";
        else
            return "结果$n一声惨嚎，$w已从$p$l处撕下了一大片血淋淋的皮肉，鲜血溅得满地！！\\n";
        end
    elseif damage_type=="抓伤" then
        if damage<15 then
            return "结果只是在$n$l处轻轻刮过，没有什么伤害。\\n";
        elseif damage<30 then
            return "结果$n皱了皱眉，$p的$l已经被拉出了一道浅浅的血痕。\\n";
        elseif damage<60 then
            return "结果拉下来$n$l的一点皮肉，疼得$p「哇哇」怪叫了起来！\\n";
        elseif damage<120 then
            return "结果「唰」地一声，$n的$l上顿时被抓出五道血痕，鲜血流了出来！\\n";
        elseif damage<160 then
            return "结果$n疼得大叫一声，$p$l上被抓出了几道深深的血沟，鲜血直流！\\n";
        elseif damage<200 then
            return "结果只听见$n一声惨嚎，$N的手爪已在$p的$l处刺出了五个血肉模糊的窟窿！\\n";
        elseif damage<240 then
            return "结果「啊」地一声惨叫，$n身上$l处被$N抓下了一大片皮肉，鲜血横飞满地！\\n";
        else
            return "结果$n一声凄惨的嘶叫，$l处被连皮带肉扯下一大块，露出了白森森的骨头！！\\n";
        end
    elseif damage_type=="震伤" then
        if damage<15 then
            return "结果$n受到$N的劲力一震，闷哼一声。\\n";
        elseif damage<30 then
            return "结果$n被$N以劲力一震，「嘿」地一声退了两步。\\n";
        elseif damage<60 then
            return "结果$n被$N以劲力一震，胸口有如受到一记重锤，连退了五六步！\\n";
        elseif damage<120 then
            return "结果$N的劲力一下震得$n连退了好几步，差一点摔倒！\\n";
        elseif damage<240 then
            return "结果$n被$N的劲力震得全身气血倒流，口中鲜血狂喷而出！\\n";
        else
            return "结果$n被$N的劲力震得眼前一黑，内脏碎裂，身子凭空飞了出去！！\\n";
        end
    elseif damage_type=="刺伤" then
        if damage<30 then
            return "结果只是轻轻地刺破$p的皮肉。\\n";
        elseif damage<60 then
            return "结果在$p$l刺出一个创口。\\n";
        elseif damage<120 then
            return "结果「噗」地一声刺入了$n$l寸许！\\n";
        elseif damage<180 then
            return "结果「噗」地一声刺进$n的$l，使$p不由自主地退了几步！\\n";
        elseif damage<240 then
            return "结果「噗嗤」地一声，$w已在$p$l刺出一个血肉模糊的血窟窿！\\n";
        else
            return "结果只听见$n一声惨嚎，$w已在$p的$l对穿而出，鲜血溅得满地！！\\n";
        end
    elseif damage_type=="摔伤" or damage_type=="撞伤" then
        if damage<30 then
            return "结果$n脚下不稳，在地上擦破了点儿皮。\\n";
        elseif damage<60 then
            return "结果「啪」地一声，$n在地上摔了个屁礅。\\n";
        elseif damage<120 then
            return "结果$n一不小心，被$N重重摔倒在地！\\n";
        elseif damage<180 then
            return "结果$n被一下摔倒在地，「噗地」一声喷出了一大口鲜血！\\n";
        elseif damage<240 then
            return "结果被$N这一下摔在地上，骨头「卡嚓」一声断了！\\n";
        else
            return "结果只听见$n一声惨嚎，被$N摔得血肉横飞，惨不忍睹！！\\n";
        end
    elseif damage_type=="挫伤" or damage_type=="砸伤" then
        if damage<30 then
            return "结果只是轻轻地碰撞到了$n一下，没有造成什么伤害。\\n";
        elseif damage<60 then
            return "结果$w只将$n的$l砸出一块瘀红。\\n";
        elseif damage<120 then
            return "结果「啪」地一声，$w打中$n的$l，登时肿了一块老高！\\n";
        elseif damage<180 then
            return "结果$w重重得击中$n的$l，打得$p倒退数步，「哇」地吐出一大口鲜血！\\n";
        elseif damage<240 then
            return "结果只听见「硼」地一声巨响，$w打在$n身上，将$p像一捆稻草般击飞出去！\\n";
        else
            return "结果$w一下打在$n的身上，几声骨碎声中，$p象散了架似的瘫了下去！！\\n";
        end
    elseif damage_type=="瘀伤" then
        if damage<15 then
            return "结果只是轻轻地碰到，比拍苍蝇稍微重了点。\\n";
        elseif damage<30 then
            return "结果在$p的$l造成一处瘀青。\\n";
        elseif damage<75 then
            return "结果一击命中，$n的$l登时肿了一块老高！\\n";
        elseif damage<120 then
            return "结果一击命中，$n闷哼了一声显然吃了不小的亏！\\n";
        elseif damage<150 then
            return "结果「砰」地一声，$n退了两步！\\n";
        elseif damage<180 then
            return "结果这一下「砰」地一声打得$n连退了好几步，差一点摔倒！\\n";
        elseif damage<240 then
            return "结果重重地击中，$n「哇」地一声吐出一口鲜血！\\n";
        else
            return "结果只听见「砰」地一声巨响，$n像一捆稻草般飞了出去！！\\n";
        end  
    elseif damage_type=="内伤" then
        if damage<30 then
            return "结果只是把$n打得退了半步，毫发无损。\\n";
        elseif damage<60 then
            return "结果$n痛哼一声，在$p的$l造成一处瘀伤。\\n";
        elseif damage<90 then
            return "结果一击命中，把$n打得痛得弯下腰去！\\n";
        elseif damage<120 then
            return "结果$n闷哼了一声，脸上一阵青一阵白，显然受了点内伤！\\n";
        elseif damage<180 then
            return "结果$n脸色一下变得惨白，昏昏沉沉接连退了好几步！\\n";
        elseif damage<225 then
            return "结果重重地击中，$n「哇」地一声吐出一口鲜血！\\n";
        elseif damage<270 then
            return "结果「轰」地一声，$n全身气血倒流，口中鲜血狂喷而出！\\n";
        else
            return "结果只听见几声喀喀轻响，$n一声惨叫，像滩软泥般塌了下去！！\\n";
        end
    else
        if damage<30 then
            return "结果只是勉强造成一处轻微"..damage_type.."。\\n";
        elseif damage<60 then
            return "结果造成轻微的"..damage_type.."。\\n";
        elseif damage<90 then
            return "结果造成一处"..damage_type.."。\\n";
        elseif damage<150 then
            return "结果造成一处严重"..damage_type.."！\\n";
        elseif damage<180 then
            return "结果造成颇为严重的"..damage_type.."！\\n";
        elseif damage<210 then
            return "结果造成相当严重的"..damage_type.."！\\n";
        elseif damage<240 then
            return "结果造成十分严重的"..damage_type.."！\\n";
        elseif damage<270 then
            return "结果造成极其严重的"..damage_type.."！\\n";
        else
            return "结果造成非常可怕的严重"..damage_type.."！！\\n";
        end
    end
end

function Query_Winner_Msg()
    local num=7;
    local winner_msg={
        "$N哈哈大笑，愉快地说道：承让了！\\n",
        "$N双手一拱，笑著说道：知道我的利害了吧！\\n",
        "$N哈哈大笑，双手一拱，笑著说道：承让！\\n",
        "$N胜了这招，向后跃开三尺，笑道：承让！\\n",
        "$n脸色微变，说道：佩服，佩服！\\n",
        "$n向后退了几步，说道：这场比试算我输了，佩服，佩服！\\n",
        "$n向后一纵，躬身做揖说道：阁下武艺不凡，果然高明！\\n",
    }
    return winner_msg[math.random(num)];
end


function Query_Status_Msg(pid)
    local ratio=math.modf(100*JY.Person[pid]["生命"]/JY.Person[pid]["生命最大值"]);
    local name=JY.Person[pid]["名称"];
    if ratio==100 then
        return name.."看起来气血充盈，并没有受伤。\\n";
    elseif ratio>95 then
        return name.."似乎受了点轻伤，不过光从外表看不大出来。\\n";
    elseif ratio>90 then
        return name.."看起来可能受了点轻伤。\\n";
    elseif ratio>80 then
        return name.."受了几处伤，不过似乎并不碍事。\\n";
    elseif ratio>60 then
        return "\\yellow"..name.."受伤不轻，看起来状况并不太好。\\n";
    elseif ratio>40 then
        return "\\yellow"..name.."气息粗重，动作开始散乱，看来所受的伤著实不轻。\\n";
    elseif ratio>30 then
        return "\\orange"..name.."已经伤痕累累，正在勉力支撑著不倒下去。\\n";
    elseif ratio>20 then
        return "\\orange"..name.."受了相当重的伤，只怕会有生命危险。\\n";
    elseif ratio>10 then
        return "\\red"..name.."伤重之下已经难以支撑，眼看就要倒在地上。\\n";
    elseif ratio>5 then
        return "\\red"..name.."受伤过重，已经奄奄一息，命在旦夕了。\\n";
    else
        return "\\red"..name.."受伤过重，已经有如风中残烛，随时都可能断气。\\n";
    end
end


function QueryMySkillLv(kfid,basic)
    return limitX(JY.Base["武功等级"..kfid],1,20+JY.Person[JY.pid]["悟性"]);
end


function Learn()
    while true do
        Learn_sub();
        StopEFT();
        JY.Status=GAME_AUTO;
        coroutine.yield();
    end
end

function Learn_sub()
    local p=JY.Person[JY.pid];
    local kfid=0;
    local str1="\\yellow%s\\white决定去修炼武功...\\n";
    local str2="\\yellow%s\\white正在思考修炼什么...\\n";
    local str3="\\yellow%s\\white考虑了半天，还是没想好要修炼什么...\\n";
    local str4="\\yellow%s\\white决定修炼\\orange%s\\n";
    local str5="\\n\\yellow%s\\white正在修炼\\orange%s\\white";
    local str6="\\n\\yellow%s\\white潜能耗尽，修炼武功结束...\\n";
    local str7="\\n\\orange%s\\white等级上升！\\n";
    local str8="\\orange%s\\white已修炼至登峰造极！\\n";
    local str9="\\orange%s\\white已修炼至化境！\\n";
    local str10="\\yellow%s\\white修炼武功结束...\\n";
    local str_l={[81]="抚琴",[82]="下棋",[83]="临帖",[84]="作画",[85]="烧菜",[86]="吟诗",[87]="煮茶",[88]="养花"};
    if JY.Base["潜能"]>1000 and math.random(20)==1 then --随机添加 没有学过的生活技能
        local ys_t={0,0};
        for i=81,88 do
            if JY.Base["武功等级"..i]==0 and CheckXX(i) then
                table.insert(ys_t,i);
            end
        end
        kfid=TableRandom(ys_t);
    end
    if kfid==0 then --没有初次修炼生活的技能， 那么正常开始随机修炼的武功
        local t_kf={};
        for i,v in pairs({"武功1","武功2","武功3","武功4","武功5","内功","轻功","特技"}) do
            if p[v]>0 then
                table.insert(t_kf,p[v]);
                if CheckXX(p[v]) then
                    if JY.Base["武功等级"..p[v]]<25 then --等级小于25，几率上升
                        table.insert(t_kf,p[v]);
                    end
                    if JY.Base["武功等级"..p[v]]<15 then --等级小于15，几率上升
                        table.insert(t_kf,p[v]);
                        table.insert(t_kf,p[v]);
                    end
                    if JY.Base["武功等级"..p[v]]<5 then --等级小于5，几率上升
                        table.insert(t_kf,p[v]);
                        table.insert(t_kf,p[v]);
                        table.insert(t_kf,p[v]);
                    end
                end
                if JY.Base["武功等级"..p[v]]<20 then --等级小于20，几率上升
                    table.insert(t_kf,p[v]);
                end
                if JY.Base["武功等级"..p[v]]<10 then --等级小于10，几率上升
                    table.insert(t_kf,p[v]);
                    table.insert(t_kf,p[v]);
                    table.insert(t_kf,p[v]);
                end
            end
        end
        if JY.Base["修炼备选"]>0 then
            for i=81,JY.KungfuNum-1 do
                if between(JY.Base["武功等级"..i],1,19) and CheckXX(i) and math.random(10)==1 then
                    table.insert(t_kf,i);
                end
            end
        end
        kfid=TableRandom(t_kf);
    end
    --一定几率不修炼
    if JY.Base["潜能"]<=200 or math.random(10)<3 then
        kfid=0;
    elseif math.random(20)==3 then
        kfid=0;
    end
    if between(kfid,81,88) then --艺术类
        str1="\\yellow%s\\white决定去"..str_l[kfid].."...\\n";
        str5="\\n\\yellow%s\\white正在"..str_l[kfid];
        str6="\\n\\yellow%s\\white停止"..str_l[kfid].."...\\n";
        str7="\\n\\orange%s\\white等级上升！\\n";
        str8="\\orange%s\\white已至登峰造极！\\n";
        str9="\\orange%s\\white已至化境！\\n";
        str10="\\yellow%s\\white"..str_l[kfid].."结束...\\n";
        JY.TEXT_BUFF=string.format(str1,JY.Person[JY.pid]["名称"]);
        JY.WAIT=4;
        coroutine.yield();
    else --其他
        JY.TEXT_BUFF=string.format(str1,JY.Person[JY.pid]["名称"]);
        JY.WAIT=4;
        coroutine.yield();
        JY.TEXT_BUFF=string.format(str2,JY.Person[JY.pid]["名称"]);
        JY.WAIT=4;
        coroutine.yield();
        if kfid>0 then --正常武功
            JY.TEXT_BUFF=string.format(str4,JY.Person[JY.pid]["名称"],JY.Kungfu[kfid]["名称"]);
            JY.WAIT=4;
            coroutine.yield();
        else --没有武功
            JY.TEXT_BUFF=string.format(str3,JY.Person[JY.pid]["名称"]);
            JY.WAIT=4;
            coroutine.yield();
        return;
    end
    end
    
    JY.LEARN_KFID=kfid;
    StartEFT(JY.LEARN_KFID);
    local frame=24;
    while true do
    JY.TEXT_BUFF=string.format(str5,JY.Person[JY.pid]["名称"],JY.Kungfu[kfid]["名称"]);
    coroutine.yield();
   
    for i=1,frame do
    JY.TEXT_BUFF=".";
   
   JY.Base["潜能"]=JY.Base["潜能"]-2-math.modf(i/100)
   
    --JY.WAIT=1;
    coroutine.yield();
    if JY.Base["潜能"]<2+math.modf(i/100) then
    JY.Base["潜能"]=0;
    PlayWavE(2);
    JY.TEXT_BUFF=string.format(str6,JY.Person[JY.pid]["名称"]);
    JY.WAIT=8;
    coroutine.yield();
    JY.LEARN_KFID=0;
    return;
    end
    end
    local exp_add=math.modf(frame*100/(24-JY.Person[0]["悟性"]));
    JY.Base["武功经验"..kfid]=JY.Base["武功经验"..kfid]+exp_add;
    local next_exp=GetSkillExp(kfid);
    if JY.Base["武功经验"..kfid]>=next_exp then
    JY.Base["武功经验"..kfid]=0;
    JY.Base["武功等级"..kfid]=JY.Base["武功等级"..kfid]+1;
    UpdateKFLv();
    InsertLog(3,JY.Base["武功等级"..kfid],kfid);
    PlayWavE(11);
    JY.TEXT_BUFF=string.format(str7,JY.Kungfu[kfid]["名称"]);
    JY.WAIT=4;
    coroutine.yield();
    if JY.Base["武功等级"..kfid]>=20 then
    if JY.Base["武功等级"..kfid]>=30 then
    JY.TEXT_BUFF=string.format(str9,JY.Kungfu[kfid]["名称"]);
    else
    JY.TEXT_BUFF=string.format(str8,JY.Kungfu[kfid]["名称"]);
    end
    JY.WAIT=4;
    coroutine.yield();
    if JY.Base["武功等级"..kfid]==20 or JY.Base["武功等级"..kfid]==30 or JY.Base["武功等级"..kfid]==40 then
    AddKFAttrib(JY.pid,kfid);
    end
    end
    JY.TEXT_BUFF=string.format(str10,JY.Person[JY.pid]["名称"]);
    JY.WAIT=8;
    coroutine.yield();
    JY.LEARN_KFID=0;
    return;
    end
    end
end

function UpdateKFLv()
    local p=JY.Person[0];
    for i=1,5 do
    local r=p["武功"..i]
    if r>0 then
    p["武功等级"..i]=JY.Base["武功等级"..r]
    end
    end
    for i,v in pairs({"内功","轻功","特技"}) do
    local r=p[v]
    if r>0 then
    p[v.."等级"]=JY.Base["武功等级"..r]
    end
    end
end


function AddKFAttrib(pid,kfid)
    local p=JY.Person[pid];
    for i,v in pairs({"生命","内力"}) do
        if JY.Kungfu[kfid][v]>0 then
            p[v.."最大值"]=p[v.."最大值"]+JY.Kungfu[kfid][v];
            p[v]=p[v.."最大值"];
            JY.TEXT_BUFF=string.format("\\yellow"..p["名称"].."\\white%s上限上升到%d \\green(%+d)\\white！\\n",v,p[v],JY.Kungfu[kfid][v]);
            InsertLog(2,i,p[v]);
            JY.WAIT=4;
            coroutine.yield();
        end
    end
    for i,v in pairs({"伤害","命中","格挡","闪避"}) do
        if JY.Kungfu[kfid][v]>0 then
            JY.Base["基本"..v]=JY.Base["基本"..v]+JY.Kungfu[kfid][v];
            JY.TEXT_BUFF=string.format("\\yellow"..p["名称"].."\\white基本%s上升到%d \\green(%+d)\\white！\\n",v,JY.Base["基本"..v],JY.Kungfu[kfid][v]);
            InsertLog(2,i+7,JY.Base["基本"..v]);
            JY.WAIT=4;
            coroutine.yield();
        end
    end
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



function GetBasePT(pid,flag)
    local p=JY.Person[pid];
    local damage,ap,pp,dp=0,0,0,0;
    for i=1,5 do
    local kfid=p["武功"..i];
    local lv=p["武功等级"..i]+5;
    if kfid>0 then
    damage=math.max(damage,JY.Kungfu[kfid].Damage*lv);
    ap=math.max(ap,JY.Kungfu[kfid].AP*lv);
    pp=math.max(pp,JY.Kungfu[kfid].PP*lv);
    dp=math.max(dp,JY.Kungfu[kfid].DP*lv);
    end
    end
    if flag then
    for i,v in pairs({"内功","轻功","特技"}) do
    local kfid=p[v];
    local lv=p[v.."等级"]+5;
    if kfid>0 then
    damage=damage+JY.Kungfu[kfid].Damage*lv;
    ap=ap+JY.Kungfu[kfid].AP*lv;
    pp=pp+JY.Kungfu[kfid].PP*lv;
    dp=dp+JY.Kungfu[kfid].DP*lv;
    end
    end
    if p["武器"]>0 then
    damage=damage+JY.Item[p["武器"]]["伤害"];
    ap=ap+JY.Item[p["武器"]]["命中"];
    end
    damage=math.modf(damage/10)+JY.Base["基本伤害"];
    ap=math.modf(ap/10)+JY.Base["基本命中"];
    pp=math.modf(pp/10)+JY.Base["基本格挡"];
    dp=math.modf(dp/10)+JY.Base["基本闪避"];
    end
    return damage,ap,pp,dp;
end


function StartEFT(kfid)
    local dh_raw= {
    [1]={810,12}, --拳掌
    [2]={890,5}, --铁掌
    [3]={990,10}, --指法
    [4]={640,12}, --毒功
    [11]={800,9}, --御剑
    [12]={600,13}, --刺叶子
    [13]={570,20}, --刺苍蝇
    [21]={770,7}, --耍刀
    [31]={780,14}, --枪棍
    [32]={740,9}, --暗器1
    [33]={750,5}, --暗器2
    [34]={760,8}, --暗器3
    [71]={920,18}, --内功
    [81]={660,11}, --轻功1
    [82]={690,4}, --轻功2
    [83]={680,7}, --轻功3
    [84]={850,5}, --闪避
    [101]={630,3}, --弹琴
    [102]={910,4}, --下棋
    [103]={870,3}, --书法
    [104]={1010,3}, --作画
    [105]={540,3}, --煮茶
    [106]={950,7}, --浇花
    [107]={860,6}, --烧菜
    [108]={550,13}, --采药
    [109]={620,3}, --丹药
    [110]={730,1}, --看道经
    [111]={731,1}, --看棋谱
    [112]={732,1}, --看医术
    [113]={733,1}, --看书
    [114]={734,1}, --看挂轴
    [115]={735,1}, --看佛经
    [116]={736,1}, --看书法
    [117]={830,5}, --劈材
    [118]={840,4}, --扫地
    [119]={880,4}, --挑水
    [120]={900,3}, --洗衣
    [121]={940,4}, --研墨
    --
    [201]={960,6}, --硬功1
    [202]={970,15}, --硬功2
    [203]={700,25}, --锻炼成功
    [204]={700,30}, --锻炼失败
    }
    local v=JY.Kungfu[kfid]["修炼动画"];
    if type(dh_raw[v])=="table" then
    JY.EFT1=dh_raw[v][1];
    JY.EFT2=dh_raw[v][2];
    end
end


function StopEFT()
    JY.EFT1=0;
    JY.EFT2=0;
end

function GetSkillExp(kfid)
    local hard=7*(JY.Kungfu[kfid].Lv-1)+JY.Kungfu[kfid].Hard/7;	--修炼难度系数
    local lv=JY.Base["武功等级"..kfid];
    hard=hard+10*math.modf(lv/10);
    return math.modf(10*(lv+5)^(2+hard/50)+hard^2);
end