#ifndef _PATH_FINDER_H_
#define _PATH_FINDER_H_

#include <stack>

#include "core/carray.h"

#include "game_pos.h"

/**
* \brief 路径坐标点
*/
struct _PathPoint
{
	/**
	* \brief 坐标
	*/
	TAxisPos pos;
	/**
	* \brief 当前距离
	*/
	sint32 cc;
	/**
	* \brief 路径上一个结点指针
	*/
	_PathPoint *father;
};
/**
* \brief A*寻路算法模板
* 其中step表示步长，radius表示搜索半径
*/
template <sint32 step = 1,sint32 radius = 15, sint32 radiusL=25>
class CAStar
{
protected:
	typedef std::vector<_PathPoint> TPathPointAry;
	static const sint32 FindPathRange = radius;
	static const sint32 FindPathRangeL = radiusL;

	/**
	* \brief 路径头
	*/
	struct _PathQueue
	{
		/**
		* \brief 路径节点头指针
		*/
		_PathPoint *node;
		/**
		* \brief 路径消耗距离
		*/
		sint32 cost;
		/**
		* \brief 构造函数
		* \param node 初始化的路径节点头指针
		* \param cost 当前消耗距离
		*/
		_PathQueue(_PathPoint *node,sint32 cost)
		{
			this->node = node;
			this->cost = cost;
		}
		/**
		* \brief 拷贝构造函数
		* \param queue 待拷贝的源数据
		*/
		_PathQueue(const _PathQueue &queue)
		{
			node = queue.node;
			cost = queue.cost;
		}
		/**
		* \brief 赋值操作符号
		* \param queue 待赋值的源数据
		* \return 返回结构的引用
		*/
		_PathQueue & operator= (const _PathQueue &queue)
		{
			node = queue.node;
			cost = queue.cost;
			return *this;
		}
	};

	/**
	* \brief 定义所有路径的链表
	*/
	typedef std::list<_PathQueue> TPathQueueHead;
	typedef typename TPathQueueHead::iterator iterator;
	typedef typename TPathQueueHead::reference reference;

	/**
	* \brief 估价函数
	* \param midPos 中间临时坐标点
	* \param endPos 最终坐标点
	* \return 估算出的两点之间的距离
	*/
	sint32 judge(const TAxisPos &midPos,const TAxisPos &endPos)
	{
		sint32 distance = abs((long)(midPos.x - endPos.x)) + abs((long)(midPos.y - endPos.y));
		return distance;
	}

	/**
	* \brief 进入路径队列
	* \param queueHead 路径队列头
	* \param pPoint 把路径节点添加到路径中
	* \param currentCost 路径的估算距离
	*/
	void enter_queue(TPathQueueHead &queueHead,_PathPoint *pPoint,sint32 currentCost)
	{
		_PathQueue pNew(pPoint,currentCost);
		if (!queueHead.empty())
		{
			for(iterator it = queueHead.begin(); it != queueHead.end(); it++)
			{
				//队列按cost由小到大的顺序排列
				if ((*it).cost > currentCost)
				{
					queueHead.insert(it,pNew);
					return;
				}
			}
		}
		queueHead.push_back(pNew);
	}

	/**
	* \brief 从路径链表中弹出最近距离
	* \param queueHead 路径队列头
	* \return 弹出的最近路径
	*/
	_PathPoint *exit_queue(TPathQueueHead &queueHead)
	{
		_PathPoint *ret = NULL;
		if (!queueHead.empty())
		{
			reference ref = queueHead.front();
			ret = ref.node;
			queueHead.pop_front();
		}
		return ret;
	}

protected:
	/**
	* \brief 寻路过程中判断中间点是否可达目的地
	*
	*  return (scene->zPosShortRange(tempPos,destPos,radius)
	*      && (!scene->checkBlock(tempPos) //目标点可达，或者是最终目标点
	*        || tempPos == destPos));
	*
	* \param tempPos 寻路过程的中间点
	* \param destPos 目的点坐标
	* \param radius 寻路范围，超出范围的视为目的地不可达
	* \return 返回是否可到达目的地
	*/
	virtual bool moveable(const TAxisPos *tempPos,const TAxisPos *destPos,const sint32 rads = radius) = 0;

public:
	/**
	* \brief 使物件向某一个点移动
	* 带寻路算法的移动
	* \param srcPos 起点坐标
	* \param destPos 目的地坐标
	* \return 移动是否成功
	*/
	bool gotoFindPath(const TAxisPos *srcPos,const TAxisPos *destPos, TLogicMovePosList* ary, sint32 range = radius);

	/**
	* \brief 使物件向某一个点移动
	* 带寻路算法的移动
	* \param srcPos 起点坐标
	* \param destPos 目的地坐标
	* \return 移动是否成功
	*/
	bool gotoFindPathL(const TAxisPos *srcPos,const TAxisPos *destPos, TLogicMovePosList* ary);
};

template <sint32 step,sint32 radius, sint32 radiusL>
bool CAStar<step, radius, radiusL>::gotoFindPathL( const TAxisPos *srcPos,const TAxisPos *destPos, TLogicMovePosList* ary )
{
	return gotoFindPath(srcPos, destPos, ary, radiusL);
}

template <sint32 step,sint32 radius, sint32 radiusL>
bool CAStar<step, radius, radiusL>::gotoFindPath(const TAxisPos *srcPos,const TAxisPos *destPos, TLogicMovePosList* ary, sint32 range)
{
	if(*srcPos == *destPos)
	{
		return false;
	}

	static GXMISC::CArray<sint32, 410*410> AstarDisMap; 
	static GXMISC::CArray<_PathPoint,410*410*8+1> AstarStack;

	// DisMap是以destPos为中心的边长为2 * radius + 1 的正方形
	const sint32 Width = (2 * range + 1);
	const sint32 Height = (2 * range + 1);
	const sint32 MaxNum = Width * Height;

	// 把所有路径距离初始化为最大值
	AstarDisMap.resize(MaxNum);
	memset(&AstarDisMap[0], 0x11, MaxNum*sizeof(sint32));
	AstarStack.resize(MaxNum * 8 + 1);

	TPathQueueHead queueHead;
	// 从开始坐标进行计算
	_PathPoint *root = &AstarStack[MaxNum * 8];
	root->pos = *srcPos;
	root->cc = 0;
	root->father = NULL;
	enter_queue(queueHead,root,root->cc + judge(root->pos,*destPos));

	sint32 count = 0;
	// 无论如何,循环超过MaxNum次则放弃
	while(count < MaxNum)
	{
		root = exit_queue(queueHead);
		if (NULL == root)
		{
			// 目标点不可达
			return false;
		}

		if (root->pos == *destPos)
		{
			// 找到到达目的地的路径
			break;
		}

		const TAdjust adjust[8] =
		{
			{  1 * step,0 * step  },
			{  0 * step,-1 * step  },
			{  0 * step,1 * step  },
			{  -1 * step,0 * step  },
			{  1 * step,-1 * step  },
			{  -1 * step,-1 * step  },
			{  -1 * step,1 * step  },
			{  1 * step,1 * step  }
		};

		for(sint32 i = 0; i < 8; i++)
		{
			// 分别对周围8个格点进行计算路径
			bool bCanWalk = true;
			TAxisPos tempPos = root->pos;
			tempPos += adjust[i];

			if (moveable(&tempPos,destPos,range))
			{
				// 对路径进行回溯
				_PathPoint *p = root;
				while(p)
				{
					if (p->pos == tempPos)
					{
						// 发现坐标点已经在回溯路径中，不能向前走
						bCanWalk = false;
						break;
					}
					p = p->father;
				}

				// 如果路径回溯成功，表示这个点是可行走的
				if (bCanWalk)
				{
					sint32 cost = root->cc + 1;
					sint32 index = (tempPos.y - destPos->y + range) * Width + (tempPos.x - destPos->x + range);
					if (index >= 0
						&& index < MaxNum
						&& cost < AstarDisMap[index])
					{
						// 这条路径比上次计算的路径还要短，需要加入到最短路径队列中
						AstarDisMap[index] = cost;
						_PathPoint *pNewEntry = &AstarStack[count * 8 + i];
						pNewEntry->pos = tempPos;
						pNewEntry->cc = cost;
						pNewEntry->father = root;
						enter_queue(queueHead,pNewEntry,pNewEntry->cc + judge(pNewEntry->pos,*destPos));
					}
				}
			}
		}

		count++;
	}

	if (count < MaxNum)
	{
		std::stack<_PathPoint*> backStack;
		while(root)
		{
			if(root->father != NULL)
			{
				backStack.push(root);
			}

			root = root->father;
		}

		// 回溯路径
		while (!backStack.empty())
		{
			ary->push_back(backStack.top()->pos);
			backStack.pop();
		}

		return true;
	}

	return false;
}

#endif