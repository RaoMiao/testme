--主程序入口
function JY_Main() --主程序入口
    os.remove("debug.txt"); --清除以前的debug输出
    xpcall(JY_Main_sub,myErrFun); --捕获调用错误
end
  
--错误处理函数
function myErrFun(err) --错误处理，打印错误信息
    lib.Debug(err); --输出错误信息
    lib.Debug(debug.traceback()); --输出调用堆栈信息
end


--清理lua内存
function CleanMemory() 
    if CONFIG.CleanMemory==1 then
    collectgarbage("collect");
    end
end

--限制x的范围
function limitX(x,minv,maxv) 
    if x<minv then
    x=minv;
    elseif x>maxv then
    x=maxv;
    end
    return x
end


function between(v,Min,Max)
    if Min>Max then
    Min,Max=Max,Min;
    end
    if v>=Min and v<=Max then
    return true;
    end
    return false;
end

--等待键盘输入
function WaitKey(flag) --等待键盘输入
    local keyPress=-1;
    while true do
    local eventtype,keypress,x,y=lib.GetKey(1);
    if eventtype==1 or eventtype==3 then
    MOUSE.status='IDLE';
    break;
    end
    lib.Delay(20);
    end
    lib.Delay(100);
    return keyPress;
end


function Light(frame) --场景变亮
    frame=frame or CC.FrameNum;
    if JY.Dark then
    JY.Dark=false;
    lib.ShowSlow(frame,0);
    lib.GetKey();
    end
end

--场景变黑
function Dark(frame) 
    frame=frame or CC.FrameNum;
    if not JY.Dark then
    JY.Dark=true;
    lib.ShowSlow(frame,1);
    lib.GetKey();
    end
end

--播放MP3
function PlayBGM(id)
    id=id or 0
    JY.CurrentBGM=id;
    if JY.EnableMusic==0 then
    return ;
    end
    if id>=0 then
    lib.PlayMIDI(string.format(CC.BGMFile,id));
    end
end

function StopBGM()
    JY.CurrentBGM=-1;
    lib.PlayMIDI("");
end

--播放音效e**
function PlayWavE(id) --播放音效e**
    if JY.EnableSound==0 then
    return ;
    end
   
    if JY.Base["开启音乐"]==1 then
       lib.PlayMIDI(CONFIG.SoundPath .. "game.mp3");
    else
       lib.PlayMIDI("");
    end
   
    if id>=0 then
        if id<2 or JY.Base["开启音效"]>0 then
           lib.PlayWAV(string.format(CC.EFile,id));
        end
    end
end


function PlayWavA(id) --播放音效e**
    if JY.EnableSound==0 then
    return ;
    end
    if id>=0 then
    lib.PlayWAV(string.format(CC.ATKFile,id));
    end
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