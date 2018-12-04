--检测文件是否存在
function fileexist(filename) 
    local inp=io.open(filename,"rb");
    if inp==nil then
    return false;
    end
    inp:close();
    return true;
end

--得到文件长度
function filelength(filename) 
    local inp=io.open(filename,"rb");
    if inp==nil then
    return -1;
    end
    local l= inp:seek("end");
    inp:close();
    return l;
end