#ifndef TDS_H
#define TDS_H

#include "types_def.h"
#include "interface.h"

namespace GXMISC
{
#ifdef OS_WINDOWS
    typedef uint32 TTss_t;
#else
    typedef pthread_key_t TTss_t;
#endif

    // @todo 对象释放

    /**
    * @brief 本地线程存储 
    */
    template <class ObjType>
    class CTSS : private INoncopyable
    {
    public:
        CTSS ();
        virtual ~CTSS (void);

    public:
        ObjType *operator->() const;
        operator ObjType *(void) const;

    public:
        void        setValue(ObjType& val);
        ObjType&    getValue();
        void        dump (void) const;

    protected:
        ObjType *newObj (void) const;
        ObjType *getObj (void) const;
        ObjType *toObj () const;

    private:
        TTss_t       _key;
    };

}

#include "tds.inl"

#endif // TDS_H