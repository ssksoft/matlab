if ~libisloaded('wrapper_matlab')
    loadlibrary('wrapper_matlab.dll');
end

libfunctionsview('wrapper_matlab')
x = libpointer('int32Ptr',1);
y = libpointer('int32Ptr',0);

[res,st,st2] = calllib('wrapper_matlab','wrapper_matlab',x,y)
%
unloadlibrary wrapper_matlab