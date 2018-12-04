
function LoadRecord(id) -- 读取游戏进度
    local t1=lib.GetTime();
    --读取R*.idx文件
    local data=Byte.create(4*10);
    Byte.loadfile(data,CC.R_GRPFilename[0],0,4*10);
    local idx={}
    idx[0]=100;
    for i =1,10 do
    idx[i]=Byte.get32(data,4*(i-1)*1);
    end
    --读取R*.grp文件
    JY.Data_Base=Byte.create(idx[1]-idx[0]+CC.PersonSize); --基本数据
    Byte.loadfile(JY.Data_Base,CC.R_GRPFilename[id],idx[0],idx[1]-idx[0]+CC.PersonSize); --基本数据和主角属性
    JY.Base={};
    --设置访问基本数据的方法，这样就可以用访问表的方式访问了．而不用把二进制数据转化为表．节约加载时间和空间
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Base,0,CC.Base_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Base,0,CC.Base_S,k,v);
    end
    }
    setmetatable(JY.Base,meta_t);
    JY.Person[0]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Base,(idx[1]-idx[0]),CC.Person_S,k);
    end,
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Base,(idx[1]-idx[0]),CC.Person_S,k,v);
    end
    }
    setmetatable(JY.Person[0],meta_t);
   
    JY.PersonNum=math.floor((idx[2]-idx[1])/CC.PersonSize); --人物 /读取newgamesave
    --JY.Data_Person_Base=Byte.create(CC.PersonSize*JY.PersonNum);
    JY.Data_Person=Byte.create(CC.PersonSize*JY.PersonNum);
    Byte.loadfile(JY.Data_Person, CC.R_GRPFilename[0],idx[1],CC.PersonSize*JY.PersonNum);
    for i=1,JY.PersonNum-1 do
    JY.Person[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Person,i*CC.PersonSize,CC.Person_S,k);
    end,
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Person,i*CC.PersonSize,CC.Person_S,k,v);
    end
    }
    setmetatable(JY.Person[i],meta_t);
    end
    JY.ForceNum=math.floor((idx[3]-idx[2])/CC.ForceSize); --场景 /读取newgamesave
    JY.Data_Force=Byte.create(CC.ForceSize*JY.ForceNum);
    Byte.loadfile(JY.Data_Force,CC.R_GRPFilename[0],idx[2],CC.ForceSize*JY.ForceNum);
    for i=0,JY.ForceNum-1 do
    JY.Force[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Force,i*CC.ForceSize,CC.Force_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Force,i*CC.ForceSize,CC.Force_S,k,v);
    end
    }
    setmetatable(JY.Force[i],meta_t);
    end
    JY.MapNum=math.floor((idx[4]-idx[3])/CC.MapSize); --场景
    JY.Data_Map=Byte.create(CC.MapSize*JY.MapNum);
    Byte.loadfile(JY.Data_Map,CC.R_GRPFilename[0],idx[3],CC.MapSize*JY.MapNum);
    for i=0,JY.MapNum-1 do
    JY.Map[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Map,i*CC.MapSize,CC.Map_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Map,i*CC.MapSize,CC.Map_S,k,v);
    end
    }
    setmetatable(JY.Map[i],meta_t);
    end
    JY.ItemNum=math.floor((idx[5]-idx[4])/CC.ItemSize); --道具 /读取newgamesave
    JY.Data_Item=Byte.create(CC.ItemSize*JY.ItemNum);
    Byte.loadfile(JY.Data_Item,CC.R_GRPFilename[0],idx[4],CC.ItemSize*JY.ItemNum);
    for i=0,JY.ItemNum-1 do
    JY.Item[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Item,i*CC.ItemSize,CC.Item_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Item,i*CC.ItemSize,CC.Item_S,k,v);
    end
    }
    setmetatable(JY.Item[i],meta_t);
    end
    JY.KungfuNum=math.floor((idx[6]-idx[5])/CC.KungfuSize); --武功 /读取newgamesave
    JY.Data_Kungfu=Byte.create(CC.KungfuSize*JY.KungfuNum);
    Byte.loadfile(JY.Data_Kungfu,CC.R_GRPFilename[0],idx[5],CC.KungfuSize*JY.KungfuNum);
    for i=0,JY.KungfuNum-1 do
    JY.Kungfu[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Kungfu,i*CC.KungfuSize,CC.Kungfu_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Kungfu,i*CC.KungfuSize,CC.Kungfu_S,k,v);
    end
    }
    setmetatable(JY.Kungfu[i],meta_t);
    end
    JY.SkillNum=math.floor((idx[7]-idx[6])/CC.SkillSize); --招式 /读取newgamesave
    JY.Data_Skill=Byte.create(CC.SkillSize*JY.SkillNum);
    Byte.loadfile(JY.Data_Skill,CC.R_GRPFilename[0],idx[6],CC.SkillSize*JY.SkillNum);
    for i=0,JY.SkillNum-1 do
    JY.Skill[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Skill,i*CC.SkillSize,CC.Skill_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Skill,i*CC.SkillSize,CC.Skill_S,k,v);
    end
    }
    setmetatable(JY.Skill[i],meta_t);
    end
    JY.LingwuNum=math.floor((idx[8]-idx[7])/CC.LingwuSize); --领悟 /读取newgamesave
    JY.Data_Lingwu=Byte.create(CC.LingwuSize*JY.LingwuNum);
    Byte.loadfile(JY.Data_Lingwu,CC.R_GRPFilename[0],idx[7],CC.LingwuSize*JY.LingwuNum);
    for i=0,JY.LingwuNum-1 do
    JY.Lingwu[i]={};
    local meta_t={
    __index=function(t,k)
    return GetDataFromStruct(JY.Data_Lingwu,i*CC.LingwuSize,CC.Lingwu_S,k);
    end,
   
    __newindex=function(t,k,v)
    SetDataFromStruct(JY.Data_Lingwu,i*CC.LingwuSize,CC.Lingwu_S,k,v);
    end
    }
    setmetatable(JY.Lingwu[i],meta_t);
    end
       JY.Data_Str=Byte.create(idx[9]-idx[8]);
       Byte.loadfile(JY.Data_Str,CC.R_GRPFilename[0],idx[8],idx[9]-idx[8]);
       JY.StrNum=Byte.get16(JY.Data_Str,0);
       JY.Str={};
       local meta_t={
           __index=function(t,k)
               return Byte.getstr(JY.Data_Str,Byte.get32(JY.Data_Str,2+4*(k-1)),Byte.get32(JY.Data_Str,2+4*k)-Byte.get32(JY.Data_Str,2+4*(k-1)));
           end,
   
           __newindex=function(t,k,v)
               return;
            end
       }
       setmetatable(JY.Str,meta_t);
    collectgarbage();
    
end

-- 写游戏进度
-- id=0 新进度，=1/2/3 进度
function SaveRecord(id) -- 写游戏进度
    local t1=lib.GetTime()
    --
    --读取R*.idx文件
    local data=Byte.create(4*8);
    Byte.loadfile(data,CC.R_GRPFilename[0],0,4*8);
    local idx={}
    idx[0]=100;
    for i =1,8 do
    idx[i]=Byte.get32(data,4*(i-1));
    end
    
    --写R*.grp文件
    if filelength(CC.R_GRPFilename[id])~=idx[1]+CC.PersonSize then
    creatfile(CC.R_GRPFilename[id]);
    end
    
    --Base
    Byte.savefile(JY.Data_Base,CC.R_GRPFilename[id],idx[0],idx[1]-idx[0]+CC.PersonSize);
     
end

--从数据的结构中翻译数据
--data 二进制数组
--offset data中的偏移
--t_struct 数据的结构，在jyconst中有很多定义
--key 访问的key
function GetDataFromStruct(data,offset,t_struct,key) --从数据的结构中翻译数据，用来取数据
    local t=t_struct[key];
    local r;
    if t[2]==0 then
    if t[3]==4 then
    r=Byte.get32(data,t[1]+offset);
    else
    r=Byte.get16(data,t[1]+offset);
    end
    elseif t[2]==1 then
    if t[3]==4 then
    r=Byte.get32(data,t[1]+offset);
    else
    r=Byte.getu16(data,t[1]+offset);
    end
    elseif t[2]==2 then
    if CC.SrcCharSet==1 then
    r=lib.CharSet(Byte.getstr(data,t[1]+offset,t[3]),0);
    else
    r=Byte.getstr(data,t[1]+offset,t[3]);
    end
    end
    
    return r;
end

function SetDataFromStruct(data,offset,t_struct,key,v) --从数据的结构中翻译数据，保存数据
    local t=t_struct[key];
    
    if t[2]==0 then
    if t[3]==4 then
    Byte.set32(data,t[1]+offset,v);
    else
    Byte.set16(data,t[1]+offset,v);
    end
    elseif t[2]==1 then
    if t[3]==4 then
    Byte.set32(data,t[1]+offset,v);
    else
    Byte.setu16(data,t[1]+offset,v);
    end
    elseif t[2]==2 then
    local s;
    if CC.SrcCharSet==1 then
    s=lib.CharSet(v,1);
    else
    s=v;
    end
    Byte.setstr(data,t[1]+offset,t[3],s);
    end
end


function GetPersonData(offset,t_struct,key)
    if t_struct[key][4] then
    return GetDataFromStruct(JY.Data_Person,offset,t_struct,key);
    else
    return GetDataFromStruct(JY.Data_Person_Base,offset,t_struct,key);
    end
end

function Record(k,v)
    v=v or 1;
    if k=="战斗次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="胜利次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="攻击次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="命中次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="防御次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="格挡次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="闪避次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="睡觉次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="进食次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="思考次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="闭关次数" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="潜能合计" then
    JY.Base[k]=limitX(JY.Base[k]+v,0,99999999);
    elseif k=="伤害" or k=="命中" or k=="格挡" or k=="闪避" then
    if v<1 then
    v=1;
    end
    for i=1,10 do
    if JY.Base[k..i]==0 then
    JY.Base[k..i]=v;
    if i==10 then
    JY.Base[k..1]=0;
    else
    JY.Base[k..(i+1)]=0;
    end
    break;
    end
    end
    local sum,num=0,0;
    for i=1,10 do
    if JY.Base[k..i]>0 then
    sum=sum+JY.Base[k..i];
    num=num+1;
    end
    end
    if num>0 then
    JY.Base["平均"..k]=sum/num;
    else
    JY.Base["平均"..k]=0;
    end
    if v>JY.Base["最大"..k] then
        JY.Base["最大"..k]=v;
    end
    end
end
   