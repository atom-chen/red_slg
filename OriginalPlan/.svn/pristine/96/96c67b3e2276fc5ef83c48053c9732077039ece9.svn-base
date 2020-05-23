#include "stdcore.h"
#include "debug.h"
#include "tds.h"
#include "types_def.h"

namespace GXMISC
{
    template <class ObjType>
    CTSS<ObjType>::CTSS ()
    {
#ifdef OS_WINDOWS
        _key = TlsAlloc ();
        TlsSetValue (_key, NULL);
#else
        gxVerify(pthread_key_create (&_key, NULL) == 0);
        pthread_setspecific(_key, NULL);
#endif
    }

    template <class ObjType>
    CTSS<ObjType>::~CTSS (void)
    {
#ifdef OS_WINDOWS
        gxVerify ((TlsFree (_key) != 0 || dump()));
#else // OS_WINDOWS
        gxVerify ((pthread_key_delete (_key) == 0 || dump()));
#endif // OS_WINDOWS
    }

    template <class ObjType>
    ObjType * CTSS<ObjType>::operator-> () const
    {
        return this->getObj ();
    }

    template <class ObjType>
    CTSS<ObjType>::operator ObjType *(void) const
    {
        return this->getObj ();
    }

    template <class ObjType>
    ObjType * CTSS<ObjType>::newObj (void) const
    {
        ObjType *temp = NULL;
        temp = new ObjType();
        return temp;
    }

    template <class ObjType>
    void CTSS<ObjType>::dump (void) const
    {
        // @todo 显示调试信息
    }
    
    template <class ObjType>
    ObjType * CTSS<ObjType>::getObj( void ) const
    {
        ObjType* obj = toObj();
        if(obj == NULL)
        {
            obj = newObj();
            gxAssert(obj != NULL);
        }

        return obj;
    }

    template <class ObjType>
    ObjType * CTSS<ObjType>::toObj() const
    {
#ifdef OS_WINDOWS
        return (ObjType*)TlsGetValue (_key);
#else // OS_WINDOWS
        ObjType *ret = (ObjType*)pthread_getspecific (_key);
        return ret;
#endif // OS_WINDOWS
    }

    template <class ObjType>
    void CTSS<ObjType>::setValue( ObjType& val )
    {
        ObjType* obj = getObj();
        (*obj) = val;

    }

    template <class ObjType>
    ObjType& CTSS<ObjType>::getValue()
    {
        ObjType* obj = getObj();
        return *obj;
    }

} // GXMISC
