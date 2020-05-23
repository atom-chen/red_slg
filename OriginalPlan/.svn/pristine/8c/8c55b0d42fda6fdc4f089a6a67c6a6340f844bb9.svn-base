function CreateCppRootDir(targetpath, filename, servername)
    os.remove(targetpath..filename);

    os.execute("echo cppapi.rootpath = \""..servername.."\"; >"..targetpath..filename);
end

CreateCppRootDir("", "cppapi.txt", "test/bbb/ttt/");