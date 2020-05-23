#ifndef _SINGLETON_H_
#define _SINGLETON_H_

#include <assert.h>
#include <cstdio>

namespace GXMISC
{
	template<class T>
	class CSingleton
	{
	public:
		typedef T InstanceType;

	public:
		virtual ~CSingleton() {}

		static T &GetInstance()
		{
			if(!_Instance)
			{
				_Instance = new T;
				assert(_Instance);
			}
			return *_Instance;
		}

		static T &Instance() { return GetInstance(); }

		static void ReleaseInstance()
		{
			if(_Instance)
			{
				DSafeDelete(_Instance);
			}
		}

	protected:
		CSingleton()
		{
		}

		static T *_Instance;
	};

	template <class T>
	T* CSingleton<T>::_Instance = 0;

	template <class T>
	class CManualSingleton
	{
    public:
		typedef T InstanceType;

        static T *SingletonInstance;

		static T *&_Instance()
		{
			return SingletonInstance;
		}

	protected:
		CManualSingleton()
		{
			assert(_Instance() == NULL);
			_Instance() = static_cast<T*>(this);
		}

		~CManualSingleton()
		{
			assert(_Instance() == this);
			_Instance() = NULL;
		}

	public:
		static bool IsInitialized()
		{
			return _Instance() != NULL;
		}

		static T* GetPtrInstance()
		{
			assert(_Instance() != NULL);
			return _Instance();
		}
        
        static T& GetInstance()
        {
            return *_Instance();
        }
	};

	template <class T>
	T* CManualSingleton<T>::SingletonInstance = NULL;

	template <class T>
	class CSimpleSingleton
	{
	public:
		static T *SingletonInstance;
		typedef T InstanceType;
	public:
		static T * Create(bool initFlag = false){
			T * ptr = new T();
			if(NULL != ptr && initFlag){
				if(NULL != SingletonInstance){
					Destory();
				}
				SingletonInstance = ptr;
			}

			return ptr;
		}
		static T* Destory(){
			if(NULL != SingletonInstance){
				delete SingletonInstance;
				SingletonInstance = NULL;
			}
		}
	protected:
		static T *&_Instance(){
			return SingletonInstance;
		}
	private:
		CSimpleSingleton(){}
		virtual ~CSimpleSingleton(){
			Destory();
		}

	public:
		static bool IsInitialized()
		{
			return _Instance() != NULL;
		}

		static T* GetPtrInstance()
		{
			assert(_Instance() != NULL);
			return _Instance();
		}

		static T& GetInstance()
		{
			return *_Instance();
		}
	};

#define DSingletonImpl()	\
	public: \
	static CManualSingleton::InstanceType* GetPtr() { return GetPtrInstance(); }


	template <class T>
	T* CSimpleSingleton<T>::SingletonInstance = NULL;

} // GXMISC

#endif