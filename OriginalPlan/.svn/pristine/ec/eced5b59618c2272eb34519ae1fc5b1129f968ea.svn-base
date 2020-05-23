#ifndef _STREAM_TRAITS_H_
#define _STREAM_TRAITS_H_

#include "types_def.h"
#include "static_construct_enable.h"

namespace GXMISC{
#pragma pack(push, 1)

#ifdef COMP_GCC
#define DEmptyClassImpl	\
	private:\
	char _empty_class[0];
#else
#define DEmptyClassImpl
#endif
	struct IStreamable		// 序列化标记
	{
		DEmptyClassImpl;
	};
	struct IUnStreamable
	{
		DEmptyClassImpl;
	};
	struct IStreamableAll
	{
		DEmptyClassImpl;
	};

	// 具有IUnStreamable功能
	template<typename T>
	struct IUnStreamStaticConstruct : public IUnStreamable
	{
	public:
		typedef T TMyType;
	public:
		IUnStreamStaticConstruct(){ }
		~IUnStreamStaticConstruct(){}

	public:
		struct Helper
		{
			friend struct IUnStreamStaticConstruct<T>;
		public:
			Helper() { T::Setup(); };
			~Helper() { T::Unsetup(); };
			void doVoid()const{}
		};

	protected:
		const static Helper _Helper;

		DEmptyClassImpl;
	};
	template<typename T>
	const typename IUnStreamStaticConstruct<T>::Helper IUnStreamStaticConstruct<T>::_Helper;
	template<typename T>
	struct IUnStreamableStatic : public IUnStreamStaticConstruct<T>
	{
	public:
		typedef T TMyType;

		DEmptyClassImpl;
	};

	// 具有IStreamable和IUnStreamable
	template<typename T>
	struct IStreamStaticConstructAll : public IStreamableAll
	{
	public:
		typedef T TMyType;
	public:
		IStreamStaticConstructAll(){ }
		~IStreamStaticConstructAll(){}

	public:
		struct Helper
		{
			friend struct IStreamStaticConstructAll<T>;
		public:
			Helper() { T::Setup(); };
			~Helper() { T::Unsetup(); };
			void doVoid()const{}
		};

	protected:
		const static Helper _Helper;

		DEmptyClassImpl;
	};
	template<typename T>
	const typename IStreamStaticConstructAll<T>::Helper IStreamStaticConstructAll<T>::_Helper;
	template<typename T>
	struct IStreamableStaticAll : public IStreamStaticConstructAll<T>
	{
	public:
		typedef T TMyType;

		DEmptyClassImpl;
	};
	template<typename T>
	struct ICanStreamable
	{
		enum {
			value = std::is_base_of<GXMISC::IStreamable, T>::value 
			|| std::is_base_of<GXMISC::IStreamableAll, T>::value,
		};
	};

#pragma pack(pop)

}
#endif	// _STREAM_TRAITS_H_