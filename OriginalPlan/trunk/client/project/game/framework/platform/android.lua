
luaj = require(cc.PACKAGE_NAME .. ".lxuaj")

function io.exists(path)
    return CCFileUtils:sharedFileUtils():isFileExist(path)
end

function io.readfile(path)
    return CCFileUtils:sharedFileUtils():getFileData(path)
end
