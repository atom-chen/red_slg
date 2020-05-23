/**
* Name: 梁岳传
* Date: 2011-6-14 8:01:58
* Description: 使类可静态构造对象
*/
#ifndef _STATIC_CONSTRUCT_ENABLE_H_
#define _STATIC_CONSTRUCT_ENABLE_H_

namespace GXMISC
{
	/**
	* @brief 静态构造类
	*/
#pragma pack(push, 1)
	template<typename T>
	struct IStaticConstruct
	{
	public:
		IStaticConstruct(){ }
		~IStaticConstruct(){}

	public:
		struct Helper
		{
			friend struct IStaticConstruct<T>;
		public:
			Helper() { T::Setup(); };
			~Helper() { T::Unsetup(); };
			void print()const{}
		};

	protected:
		const static Helper _Helper;
	};

	template<typename T>
	const typename IStaticConstruct<T>::Helper IStaticConstruct<T>::_Helper;

#pragma pack(pop)

	/**
	* @brief 静态构造声明宏
	* 在类的内部定义此宏, 则可以使用静态构造函数setup()和unsetup()
	* 如:
	* class Test
	* {
	*     StaticConstructEnable(Test);
	* 
	* private:
	*     static void Setup(){}
	*     static void UnSetup(){}
	* };
	* 其中Test::setup()会在main()之前调用
	* Test::unsetup()会在mian()之后调用
	*/
#define StaticConstructEnable(T)	\
	template class GXMISC::IStaticConstruct<T>;	\
//	friend class GXMISC::IStaticConstruct<T>::Helper;

}		// namespace GXMISC

#endif