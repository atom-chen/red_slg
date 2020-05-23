#ifndef _SERVICE_PROFILE_H_
#define _SERVICE_PROFILE_H_

// @TODO 重新设计, 性能统计
// 采用加锁内存访问, 而不是采用消息通道

#define SERVICE_LOOP_PROFILE_TIME 1				// 主循环统计时间
#define SERVICE_READ_PROFILE_VAR_TIME 10		// 读统计变量的时间
#define SERVICE_TASK_PROFILE_TIME 5

#endif