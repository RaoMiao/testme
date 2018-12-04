--产生对话显示需要的字符串，即每隔n个中文字符加一个星号
function GenTalkString(str,n) --产生对话显示需要的字符串
    local tmpstr="";
    local num=0;
    for s in string.gmatch(str .. "*","(.-)%*") do --去掉对话中的所有*. 字符串尾部加一个星号，避免无法匹配
    tmpstr=tmpstr .. s;
    end
   
    local newstr="";
    while #tmpstr>0 do
    num=num+1;
    local w=0;
    while w<#tmpstr do
    local v=string.byte(tmpstr,w+1); --当前字符的值
    if v>=128 then
    w=w+2;
    else
    w=w+1;
    end
    if w >= 2*n-1 then --为了避免跨段中文字符
    break;
    end
    end
   
    if w<#tmpstr then
    if w==2*n-1 and string.byte(tmpstr,w+1)<128 then
    newstr=newstr .. string.sub(tmpstr,1,w+1) .. "*";
    tmpstr=string.sub(tmpstr,w+2,-1);
    else
    newstr=newstr .. string.sub(tmpstr,1,w) .. "*";
    tmpstr=string.sub(tmpstr,w+1,-1);
    end
    else
    newstr=newstr .. tmpstr;
    break;
    end
    end
    return newstr,num;
end


--产生对话显示需要的字符串，即每隔n个中文字符加一个星号
function GenTalkString(str,n) --产生对话显示需要的字符串
    local tmpstr="";
    local num=0;
    for s in string.gmatch(str .. "*","(.-)%*") do --去掉对话中的所有*. 字符串尾部加一个星号，避免无法匹配
    tmpstr=tmpstr .. s;
    end
   
    local newstr="";
    while #tmpstr>0 do
    num=num+1;
    local w=0;
    while w<#tmpstr do
    local v=string.byte(tmpstr,w+1); --当前字符的值
    if v>=128 then
    w=w+2;
    else
    w=w+1;
    end
    if w >= 2*n-1 then --为了避免跨段中文字符
    break;
    end
    end
   
    if w<#tmpstr then
    if w==2*n-1 and string.byte(tmpstr,w+1)<128 then
    newstr=newstr .. string.sub(tmpstr,1,w+1) .. "*";
    tmpstr=string.sub(tmpstr,w+2,-1);
    else
    newstr=newstr .. string.sub(tmpstr,1,w) .. "*";
    tmpstr=string.sub(tmpstr,w+1,-1);
    end
    else
    newstr=newstr .. tmpstr;
    break;
    end
    end
    return newstr,num;
end

function ShowText()
    local MAX_LINE=12; --最大行数
    local MAX_NUM=50; --每行最大字数
    local current=#JY.TEXT; --获取当前行
    if #JY.TEXT_BUFF<=0 then
        return;
    end
    local tv=string.sub(JY.TEXT_BUFF,1,1);
    local v="";
    if tv=="\\" then --控制字符
        if string.sub(JY.TEXT_BUFF,1,2)=="\\n" then --换行
            JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,3,-1);
            if #JY.TEXT[current]>0 then
                table.insert(JY.TEXT,"");
                JY.CURRENT_COLOR=M_White; --换行时，颜色恢复默认
                table.insert(JY.TEXT_COLOR,{[1]={s=1,c=JY.CURRENT_COLOR}});
                current=#JY.TEXT; --获取当前行
                if current>MAX_LINE then --超出最大行数时，remove掉第一行
                    table.remove(JY.TEXT,1);
                    table.remove(JY.TEXT_COLOR,1);
                end
            end
        elseif string.sub(JY.TEXT_BUFF,1,6)=="\\white" then --white
            JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,7,-1);
            JY.CURRENT_COLOR=M_White;
            table.insert(JY.TEXT_COLOR[current],{s=#JY.TEXT[current]+1,c=JY.CURRENT_COLOR});
            ShowText();
        elseif string.sub(JY.TEXT_BUFF,1,4)=="\\red" then --red
            JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,5,-1);
            JY.CURRENT_COLOR=M_Red;
            table.insert(JY.TEXT_COLOR[current],{s=#JY.TEXT[current]+1,c=JY.CURRENT_COLOR});
            ShowText();
        elseif string.sub(JY.TEXT_BUFF,1,7)=="\\yellow" then --yellow
            JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,8,-1);
            JY.CURRENT_COLOR=M_Yellow;
            table.insert(JY.TEXT_COLOR[current],{s=#JY.TEXT[current]+1,c=JY.CURRENT_COLOR});
            ShowText();
        elseif string.sub(JY.TEXT_BUFF,1,7)=="\\orange" then --orange
            JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,8,-1);
            JY.CURRENT_COLOR=M_Orange;
            table.insert(JY.TEXT_COLOR[current],{s=#JY.TEXT[current]+1,c=JY.CURRENT_COLOR});
            ShowText();
        elseif string.sub(JY.TEXT_BUFF,1,6)=="\\green" then --M_PaleGreen
            JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,7,-1);
            JY.CURRENT_COLOR=M_PaleGreen;
            table.insert(JY.TEXT_COLOR[current],{s=#JY.TEXT[current]+1,c=JY.CURRENT_COLOR});
            ShowText();
        end
        return;
    end
    tv=string.sub(JY.TEXT_BUFF,1,1);
    if string.byte(tv)<128 then --英文以及数字
        v=tv;
        JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,2,-1);
    else --汉字
        v=string.sub(JY.TEXT_BUFF,1,2);
        JY.TEXT_BUFF=string.sub(JY.TEXT_BUFF,3,-1);
    end
    if #v>0 then
        if #JY.TEXT[current]+#v>MAX_NUM then --当前行空间不足时，新增一行
            table.insert(JY.TEXT,"");
            table.insert(JY.TEXT_COLOR,{[1]={s=1,c=JY.CURRENT_COLOR}});
            current=#JY.TEXT; --获取当前行
        end
        JY.TEXT[current]=JY.TEXT[current]..v; --加到当前行行尾
        if #JY.TEXT[current]>=MAX_NUM then --到达行尾时，新增一行
            table.insert(JY.TEXT,"");
            table.insert(JY.TEXT_COLOR,{[1]={s=1,c=JY.CURRENT_COLOR}});
            current=#JY.TEXT; --获取当前行
        end
        if current>MAX_LINE then --超出最大行数时，remove掉第一行
            table.remove(JY.TEXT,1);
            table.remove(JY.TEXT_COLOR,1);
        end
    end
end