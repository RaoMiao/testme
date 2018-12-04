function InsertLog(kind,v1,v2)
    if JY.Status==GAME_START then
    return;
    end
    local idx=2162+2;
    local current=GetLogNum()+1;
    if current>1386 then
    current=current-14;
    for i=idx,idx+8*(current-1),8 do
    Byte.set32(JY.Data_Base,i,Byte.get32(JY.Data_Base,i+8*14));
    Byte.set32(JY.Data_Base,i+4,Byte.get32(JY.Data_Base,i+8*14+4));
    end
    end
    SetLogNum(current);
    idx=idx+8*current;
    Byte.set32(JY.Data_Base,idx,0);
    Byte.set32(JY.Data_Base,idx+4,0);
    local tab=os.date("*t");
    Byte.setu16(JY.Data_Base,idx,256*tab.month+tab.day);
    idx=idx+2;
    Byte.setu16(JY.Data_Base,idx,256*tab.hour+tab.min);
    idx=idx+2;
    Byte.setu16(JY.Data_Base,idx,kind+256*v1);
    idx=idx+2;
    Byte.setu16(JY.Data_Base,idx,v2);
    
    local num_per_page=14;
    JY.LOG_MAX_PAGE=1+math.modf((current-1)/num_per_page);
    if not JY.bt[124].enable then
    JY.LOG_CURRENT_PAGE=JY.LOG_MAX_PAGE;
    end
    JY.bt[123].enable=JY.LOG_CURRENT_PAGE>1;
    JY.bt[124].enable=JY.LOG_CURRENT_PAGE<JY.LOG_MAX_PAGE;
end

function ReadLog(id)
    local idx=2162+2;
    if not between(id,1,1386) then
    return "Error: Index over limited";
    end
    idx=idx+8*id;
    local month=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    local day=Byte.getu16(JY.Data_Base,idx)%256;
    idx=idx+2;
    local hour=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    local min=Byte.getu16(JY.Data_Base,idx)%256;
    idx=idx+2;
    local kind=Byte.getu16(JY.Data_Base,idx)%256;
    if kind==1 then
    local lv=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white修为上升至\\greenLv%02d",month,day,hour,min,JY.Person[0]["名称"],lv);
    elseif kind==2 then
    local attrib_t={"生命","内力","膂力","根骨","机敏","悟性","福缘","基本伤害","基本命中","基本格挡","基本闪避"};
    local aid=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    local attrib="";
    if between(aid,1,11) then
    attrib=attrib_t[aid];
    end
    idx=idx+2;
    local value=Byte.getu16(JY.Data_Base,idx);
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white%s上升至\\green%02d",month,day,hour,min,JY.Person[0]["名称"],attrib,value);
    elseif kind==3 then
    local lv=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    idx=idx+2;
    local kfid=Byte.getu16(JY.Data_Base,idx);
    if lv>99 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white修炼\\orange%s\\white登峰造极",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"],lv);
    elseif lv==1 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white领悟了\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"],lv);
    else
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white修炼\\orange%s\\white至\\greenLv%02d",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"],lv);
    end
    elseif kind==4 then
    local flag=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    idx=idx+2;
    local eid=Byte.getu16(JY.Data_Base,idx);
    if flag==0 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white击败\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Person[eid]["名称"]);
    elseif flag==1 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white败于\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Person[eid]["名称"]);
    elseif flag==2 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white击败\\red%s·%s",month,day,hour,min,JY.Person[0]["名称"],JY.Person[eid]["外号"],JY.Person[eid]["名称"]);
    elseif flag==3 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white败于\\red%s·%s",month,day,hour,min,JY.Person[0]["名称"],JY.Person[eid]["外号"],JY.Person[eid]["名称"]);
    else
    return string.format("%02d/%02d %02d:%02d Error: Flag over limited %d",month,day,hour,min,flag);
    end
    elseif kind==5 then
    local flag=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    idx=idx+2;
    local kfid=Byte.getu16(JY.Data_Base,idx);
    if flag==0 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white梦见仙人指点\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"]);
    elseif flag==1 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white本来就会\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"]);
    elseif flag==2 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white醒来发现做了一场梦",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"]);
    elseif flag==3 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white没有学会\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"]);
    else
    return string.format("%02d/%02d %02d:%02d Error: Flag over limited %d",month,day,hour,min,flag);
    end
    elseif kind==6 then
    local flag=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    idx=idx+2;
    local kfid=Byte.getu16(JY.Data_Base,idx);
    if flag==0 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white闭关了",month,day,hour,min,JY.Person[0]["名称"]);
    elseif flag==1 then
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white的\\orange%s\\white还有潜力",month,day,hour,min,JY.Person[0]["名称"],JY.Kungfu[kfid]["名称"]);
    else
    return string.format("%02d/%02d %02d:%02d Error: Flag over limited %d",month,day,hour,min,flag);
    end
    elseif kind==7 then
    elseif kind==8 then
    local tid=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white获得称号\\orange%s",month,day,hour,min,JY.Person[0]["名称"],JY.Item[tid]["名称"]);
    elseif kind==9 then
    local tid=math.modf(Byte.getu16(JY.Data_Base,idx)/256);
    return string.format("%02d/%02d %02d:%02d \\yellow%s\\white获得武器\\green%s",month,day,hour,min,JY.Person[0]["名称"],JY.Item[tid]["名称"]);
    else
    return string.format("%02d/%02d %02d:%02d Error: undefined event %d",month,day,hour,min,kind);
    end
end

function GetLogNum()
    local idx=2162;
    return Byte.getu16(JY.Data_Base,idx);
end

function SetLogNum(num)
    local idx=2162;
    Byte.setu16(JY.Data_Base,idx,num);
end
   