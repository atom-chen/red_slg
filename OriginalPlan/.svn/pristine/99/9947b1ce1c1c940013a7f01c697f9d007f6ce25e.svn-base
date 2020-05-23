Class = class;

-- 运行状态
BTRunStatus = {
    BTRS_RUNNING = 0,		-- 运行
    BTRS_FINISH = 1,		-- 结束
    BTRS_FAILURE = -1,		-- 失败
};

-- 行为常量表
CBehavior={};
-- 无效的子结点索引
CBehavior.INVALID_INDEX = -1;

-- 预判条件结点
CBTPreconditionNode=Class("CBTPreconditionNode")
function CBTPreconditionNode:ctor(condFunc)
    self._nodeName = "CBTNodePrecondition";
    self._condFunc = condFunc;
end
-- 结点名字
function CBTPreconditionNode:getNodeName()
    return self._nodeName;
end
function CBTPreconditionNode:setNodeName(nodeName)
    self._nodeName = nodeName;
end
function CBTPreconditionNode:externalCondition(input) -- virtual
    if self._condFunc ~= nil then
        --print("CBTPreconditionNode condFunc");
        return self._condFunc(input);
    end

    return false;
end
function CBTPreconditionNode:setCond(condFunc)
    self._condFunc = condFunc;
end

-- 预判条件真结点
CBTPreconditionTRUENode = Class("CBTPreconditionTRUENode", CBTPreconditionNode);
function CBTPreconditionTRUENode:externalCondition(input) -- override
    return true;
end

-- 预判条件假结点
CBTPreconditionFALSENode = Class("CBTPreconditionFALSENode", CBTPreconditionNode);
function CBTPreconditionFALSENode:externalCondition(input) -- override
    return false;
end

-- 预判条件非结点
CBTPreconditionNOTNode = Class("CBTPreconditionNOTNode", CBTPreconditionNode);
function CBTPreconditionNOTNode:ctor(condNode)
    self._condNode = condNode;
end
function CBTPreconditionNOTNode:externalCondition(input) -- override
    print("CBTPreconditionNOTNode:externalCondition", self._condNode:externalCondition(input) == false);
    return self._condNode:externalCondition(input) == false;
end
function CBTPreconditionNOTNode:setCondNode(condNode)
    self._condNode = condNode;
end

-- 预判条件或结点
CBTPreconditionANDNode = Class("CBTPreconditionANDNode", CBTPreconditionNode);
function CBTPreconditionANDNode:ctor(leftNode, rightNode)
    self._leftCondNode = leftNode;
    self._rightCondNode = rightNode;
end
function CBTPreconditionANDNode:externalCondition(input) -- override
    return self._leftCondNode:externalCondition(input) and self._rightCondNode:externalCondition(input);
end
function CBTPreconditionANDNode:setCondNode(leftNode, rightNode)
    self._leftCondNode = leftNode;
    self._rightCondNode = rightNode;
end

-- 预判条件与结点
CBTPreconditionORNode = Class("CBTPreconditionORNode",CBTPreconditionNode);
function CBTPreconditionORNode:ctor(leftNode,rightNode)
    self._leftCondNode = leftNode;
    self._rightCondNode = rightNode;
end
function CBTPreconditionORNode:externalCondition(input) -- override
    return self._leftCondNode:externalCondition(input) or self._rightCondNode:externalCondition(input);
end
function CBTPreconditionORNode:setCondNode(leftNode, rightNode)
    self._leftCondNode = leftNode;
    self._rightCondNode = rightNode;
end

-- 行为树结点
CBTNode = Class("CBTNode");
function CBTNode:ctor()
    self._status = BTRunStatus.BTRS_FINISH;	-- 运行状态
    self._nodeName = "BTNode";		-- 结点名字
    --self._parent = nil;				-- 父结点
    self._conds = {};				-- 条件列表
end

-- 运行状态
function CBTNode:getStatus()
    return self._status;
end
function CBTNode:setStatus(status)
    self._status = status;
end

-- 结点名字
function CBTNode:getNodeName()
    return self._nodeName;
end
function CBTNode:setNodeName(nodeName)
    self._nodeName = nodeName;
end

--[[
-- 父结点
function CBTNode:getParent()
    return self._parent;
end
function CBTNode:setParent(parent)
    self._parent = parent;
end
]]

-- 结点条件
function CBTNode:addCondition(node)
    table.insert(self._conds, node);
    return self;
end

function CBTNode:removeCondition(node)
    for k,v in ipairs(self._conds) do
    	if v == node then
    	    table.remove(self._conds,k);
    	    break;
    	end
    end
end

function CBTNode:hasCondition(node)
    for k,v in ipairs(self._conds) do
    	if v == node then
    	    return true;
    	end
    end

    return false;
end

function CBTNode:getConds()
    return self._conds;
end

-- 检测条件列表
function CBTNode:checkCondition(input)
    for _,v in ipairs(self._conds) do
    	if not v:externalCondition(input) then
    	    return false;
    	end
    end

    return true;
end

-- 进入
function CBTNode:enter(input) -- virtual
    if self:checkCondition(input) and self:canEnter(input) then
	   self._status = BTRunStatus.BTRS_RUNNING;
	   return true;
    end

    return false;
end
function CBTNode:canEnter(input)
    return true;
end
-- 离开
function CBTNode:leave(input) -- virtual
    self:doLeave(input);
    self._status = BTRunStatus.BTRS_FINISH;
end
function CBTNode:doLeave(input) -- virtual
end
-- 执行
function CBTNode:tick(input, output) -- virtual
    return self:doTick(input, output);
end
function CBTNode:doTick(input, output) -- virtual
    return BTRunStatus.BTRS_FINISH;
end

-- =====================动作结点=====================
CBTActionNode = Class("CBTActionNode", CBTNode);
function CBTActionNode:ctor()
    self._firstTick = true;     -- 第一次执行?
    self._tempOutput = nil;     -- 临时的输出对象引用
end

function CBTActionNode:doExit(input, output)
end
function CBTActionNode:doLeave(input) -- override
    self:doExit(input, self._tempOutput);
    self._firstTick = true;
    self._tempOutput = nil;
end
function CBTActionNode:doEnter(input)
end
function CBTActionNode:doTick(input, output) -- override
    self._tempOutput = output;
    if self._firstTick then
	   self:doEnter(input);
       self._firstTick = false;
    end

    return self:doExecute(input, output);
end
CBTActionNode.doExecute = nil; -- virtual = 0

-- =====================组合结点=====================
CBTCompositeNode = Class("CBTCompositeNode", CBTNode);
function CBTCompositeNode:ctor()
    self._childs = {};	    -- 子结点列表
    self._runningIndex = CBehavior.INVALID_INDEX;	    -- 当前运行的结点索引
    self._lastRunIndex = CBehavior.INVALID_INDEX;	    -- 上次运行的结点索引
    self._runChildStatus = BTRunStatus.BTRS_FINISH;	    -- 子结点运行返回的状态
end

function CBTCompositeNode:clearRunData()
    self._runningIndex = CBehavior.INVALID_INDEX;
    self._lastRunIndex = CBehavior.INVALID_INDEX;
    self._runChildStatus = BTRunStatus.BTRS_FINISH;
    self._status = BTRunStatus.BTRS_FINISH;
end

--[[
function CBTCompositeNode:getChils()
    return self._childs;
end
]]

function CBTCompositeNode:checkRunningIndex()
    return self._runningIndex > 0 and self._runningIndex <= #self._childs;
end

function CBTCompositeNode:checkLastRunIndex()
    return self._lastRunIndex > 0 and self._lastRunIndex <= #self._childs;
end

function CBTCompositeNode:onAddChild(node) end
function CBTCompositeNode:addChild(node)
    table.insert(self._childs, node);
    self:onAddChild(node);
    return self;
end

function CBTCompositeNode:removeChild(node)
    for k,v in ipairs(self._childs) do
    	if v == node then
    	    table.remove(self._childs,k);
    	    break;
    	end
    end
end

function CBTCompositeNode:hasChild(node)
    for k,v in ipairs(self._childs) do
    	if v == node then
    	    return true;
    	end
    end

    return false;
end

CBTCompositeNode.doTick = nil; -- virtual = 0

-- =====================序列结点=====================
CBTSequenceNode = Class("CBTSequenceNode", CBTCompositeNode);
function CBTSequenceNode:canEnter(input)
    
    assert(#self._childs > 0);
    
    if self._runningIndex == CBehavior.INVALID_INDEX then
    	assert(self._lastRunIndex == CBehavior.INVALID_INDEX);
    	self._lastRunIndex = self._runningIndex;
    	self._runningIndex = 1;
    elseif self._runningIndex ~= 1 then
	   assert(self:checkLastRunIndex());
    end
    
    assert(self:checkRunningIndex());

    local runIndex = self._runningIndex;

    -- 检测当前子结点是否可以进入
    local runNode = self._childs[runIndex];
    if not runNode:enter(input) then
	   return false;
    end

    return true;
end
function CBTSequenceNode:doLeave(input)
    if self:checkRunningIndex() then
    	local runNode = self._childs[self._runningIndex];
    	runNode:leave(input);
    end
    
    self:clearRunData();
end
function CBTSequenceNode:doTick(input,output)
    local status = BTRunStatus.BTRS_FINISH;
    local runNode = self._childs[self._runningIndex];
    status = runNode:tick(input, output);
    if status == BTRunStatus.BTRS_FINISH then
    	runNode:leave(input);
    	self._lastRunIndex = self._runningIndex;
    	self._runningIndex = self._runningIndex+1;
    	if self._runningIndex > #self._childs then
    	    self._runningIndex = CBehavior.INVALID_INDEX;
    	else
    	    status = BTRunStatus.BTRS_RUNNING;
    	end
    elseif status == BTRunStatus.BTRS_FAILURE then
    	status = BTRunStatus.BTRS_FINISH;
    end
    self._status = status;
    self._runChildStatus = status;

    return status;
end

-- =====================优先选择结点=====================
CBTSelectorNode = Class("CBTSelectorNode", CBTCompositeNode);
function CBTSelectorNode:canEnter(input)
    self._lastRunIndex = self._runningIndex;
    self._runningIndex = CBehavior.INVALID_INDEX;

    for k,v in ipairs(self._childs) do
    	if v:enter(input) then
    	    self._runningIndex = k;
    	    return true;
    	end
    end
    
    return false;
end
function CBTSelectorNode:doLeave(input)
    if self:checkLastRunIndex() then
    	local runNode = self._childs[self._lastRunIndex];
    	runNode:leave(input);
    end

    self:clearRunData();
end
function CBTSelectorNode:doTick(input, output)
    assert(self._runningIndex ~= CBehavior.INVALID_INDEX);

    local status = BTRunStatus.BTRS_FINISH;

    if self:checkRunningIndex() then
    	if self._lastRunIndex ~= self._runningIndex then
    	    if self:checkLastRunIndex() then
        		local runNode = self._childs[self._lastRunIndex];
        		runNode:leave(input);
    	    end

    	    self._lastRunIndex = self._runningIndex;
    	end
    end

    if self:checkLastRunIndex() then
    	local runNode = self._childs[self._lastRunIndex];
    	status = runNode:tick(input, output);
    	if status == BTRunStatus.BTRS_FINISH or status == BTRunStatus.BTRS_FAILURE then
            runNode:leave(input);
            self:clearRunData();
    	end
    end

    self._runChildStatus = status;

    return status;
end

-- =====================非优先选择结点=====================
CBTNoneSelectorNode = Class("CBTNoneSelectorNode", CBTSelectorNode);
function CBTNoneSelectorNode:canEnter(input)
    if self:checkRunningIndex() then
    	local runNode = self._childs[self._runningIndex];
    	if runNode:enter(input) then
    	    return true;
    	end
    end

    return self.supper:enter(input);
end

-- =====================并行结点=====================
CBTParallelNode = Class("CBTParallelNode", CBTCompositeNode);
function CBTParallelNode:onAddChild(node)
    node:setStatus(BTRunStatus.BTRS_RUNNING);
end
function CBTParallelNode:canEnter(input)
    for _,v in ipairs(self._childs) do
    	if v:getStatus() == BTRunStatus.BTRS_RUNNING then
    	    if not v:enter(input) then
    		  return false;
    	    end
    	end
    end

    return true;
end
function CBTParallelNode:doLeave(input)
    for _,v in ipairs(self._childs) do
    	v:leave(input);
    	v:setStatus(BTRunStatus.BTRS_RUNNING);
    end

    self:clearRunData();
end
CBTParallelNode.doTick = nil; -- virtual = 0

-- =====================并行或结点=====================
-- 有子结点完成则表示完成
CBTParallelOrNode = Class("CBTParallelOrNode", CBTParallelNode);
function CBTParallelOrNode:doTick(input, output)
    for _,v in ipairs(self._childs) do
    	local status = v:getStatus();
    	if status == BTRunStatus.BTRS_RUNNING then
    	    status = v:tick(input, output);
    	end
        self._runChildStatus = status;
    	if status ~= BTRunStatus.BTRS_RUNNING then
            self._status = BTRunStatus.BTRS_FINISH;
    	    return BTRunStatus.BTRS_FINISH;
    	end
    end

    self._status = BTRunStatus.BTRS_RUNNING;
    return BTRunStatus.BTRS_RUNNING;
end

-- =====================并行与结点=====================
-- 所有子结点完成则表示完成
CBTParallelAndNode = Class("CBTParallelAndNode", CBTParallelNode);
function CBTParallelAndNode:doTick(input, output)
    local finishCount = 0;
    for _,v in ipairs(self._childs) do
    	local status = v:getStatus();
    	if status == BTRunStatus.BTRS_RUNNING then
    	    status = v:tick(input, output);
    	end
        self._runChildStatus = status;
    	if status ~= BTRunStatus.BTRS_RUNNING then
    	    finishCount = finishCount+1;
    	end
    end
    
    if finishCount == #self._childs then
	   return BTRunStatus.BTRS_FINISH;
    end

    return BTRunStatus.BTRS_RUNNING;
end

-- =====================循环结点=====================
CBTLoopNode = Class("CBTLoopNode", CBTCompositeNode);
function CBTLoopNode:ctor(maxLoopCount)
    self._maxLoopCount = maxLoopCount;
    self._currentLoopCount = 0;
end

function CBTLoopNode:canEnter(input)
    if self._maxLoopCount == nil or self._currentLoopCount >= self._maxLoopCount then
	   return false;
    end

    local runNode = self._childs[1];
    if runNode:enter(input) then
	   return true;
    end

    return false;
end

function CBTLoopNode:doLeave(input)
    local runNode = self._childs[1];
    runNode:leave(input);

    self._currentLoopCount = 0;
    self:clearRunData();
end

function CBTLoopNode:doTick(input, output)
    local status = BTRunStatus.BTRS_FINISH;

    local runNode = self._childs[1];
    status = runNode:tick(input, output);
    if status == BTRunStatus.BTRS_FINISH then
    	if self._maxLoopCount ~= nil then
    	    self._currentLoopCount = self._currentLoopCount+1;
    	    if self._currentLoopCount == self._maxLoopCount then
    		  status = BTRunStatus.BTRS_FINISH;
    	    end
    	else
    	    status = BTRunStatus.BTRS_RUNNING;
    	end
    end

    if status ~= BTRunStatus.BTRS_RUNNING then
        status = BTRunStatus.BTRS_FINISH;
        self._currentLoopCount = 0;
    end

    self._runChildStatus = status;

    return status;
end

-- =====================行为树=====================
CBehaviorTree=Class("CBehaviorTree", CBTSelectorNode);
function CBehaviorTree:ctor()
    self.interval = 1/20;
    self.totalDt = 0;
    self:setNodeName("Root");
end

function CBehaviorTree:update(dt, input, output)
    self.totalDt = self.totalDt + dt;
    if self.totalDt >= self.interval then
        input.dt = self.totalDt;
        if self:enter(input) then
            self:tick(input, output);
        end
        self.totalDt = 0;
    end
end
