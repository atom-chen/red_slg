local ConstValue = {}
UpdateApp.Update_Const = ConstValue

ConstValue.updateEvent = {
    eUpdateSucess = "success",
    eUpdateError = "error",
    eUpdateProgress = "progress",
    eUncompressProgress = "uncompressProgress",
    eUpdateState = "state"
}

ConstValue.updateState = {
    kDownStart = "downloadStart",
    kDownDone = "downloadDone",
    kUncompressStart = "uncompressStart",
    kUncompressDone = "uncompressDone",
    unknown = "stateUnknown",
}

ConstValue.updateError = {
    eErrorCreateFile = "errorCreateFile",
    eErorNetwork = "errorNetwork",
    eErrorUncompress = "errorUncompress",
    eErrorUnknown = "errorUnknown",
    eErrorOutOfMemory = "outOfMemory",
    eErrorRemoteFileNotFound = "remoteFileNotFound",
    eErrorNotEnoughStorageSpace = "notEnoughStorageSpace",
    eErrorUncompressFileNoFound = "uncompressFileNoFound",
    eErrorUncompressZipError = "uncompressZipError",
    eErrorUncompressNoSpace = "uncompressNoSpace",
    eErrorSelfQuit = "oneselfQuit",
    eErrorRemoteFileLength = "remoteFileLengthError",
    eErrorFileLengthRespose = "fileLengthResposeError",
    eErrorDownRespose = "downResposeError"
}

ConstValue.tipString = {}

ConstValue.tipString[ConstValue.updateState.kDownStart] = "开始下载"
ConstValue.tipString[ConstValue.updateState.kDownDone] = "下载成功"
ConstValue.tipString[ConstValue.updateState.kUncompressStart] = "开始解压"
ConstValue.tipString[ConstValue.updateState.kUncompressDone] = "解压成功"
ConstValue.tipString[ConstValue.updateState.unknown] = "未知状态"


ConstValue.tipString[ConstValue.updateError.eErrorCreateFile] = "创建文件失败，请检测存储空间是否充足"
ConstValue.tipString[ConstValue.updateError.eErorNetwork] = "网络出现故障,请退出游戏后重试"
ConstValue.tipString[ConstValue.updateError.eErrorUncompress] = "解压资源包错误，请检测存储空间是否充足"
ConstValue.tipString[ConstValue.updateError.eErrorUnknown] = "出现不明错误,请退出游戏后重试"
ConstValue.tipString[ConstValue.updateError.eErrorOutOfMemory] = "内存分配出错，请退出游戏后重试"
ConstValue.tipString[ConstValue.updateError.eErrorRemoteFileNotFound] = "网络资源包错误，请确保网络连接正常"
ConstValue.tipString[ConstValue.updateError.eErrorNotEnoughStorageSpace] = "下载文件出错，请腾出足够空间后重试"
ConstValue.tipString[ConstValue.updateError.eErrorUncompressFileNoFound] = "下载资源出错，请确保网络正常、存储空间充足"
ConstValue.tipString[ConstValue.updateError.eErrorUncompressZipError] = "资源包文件损坏,请尝试重启游戏进行更新"
ConstValue.tipString[ConstValue.updateError.eErrorUncompressNoSpace] = "解压失败，存储空间不足,请腾出足够空间后重试"
ConstValue.tipString[ConstValue.updateError.eErrorRemoteFileLength] = "网络资源包大小异常，请重连网络后进行尝试"
ConstValue.tipString[ConstValue.updateError.eErrorFileLengthRespose] = "获取更新包信息出错，请重连网络后进行尝试"
ConstValue.tipString[ConstValue.updateError.eErrorDownRespose] = "下载更新包出错，请重连网络后进行尝试"