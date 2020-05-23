#ifndef _UCSTRING_H_
#define _UCSTRING_H_

#include "types_def.h"

namespace GXMISC
{
	/**
	* ¿í×Ö·û´®¿â, ÔÝÊ±Î´Ê¹ÓÃ @TODO
	*/
    typedef std::basic_string<ucchar> CUStringBase;

    class CUString : public CUStringBase
    {
    public:

        CUString () {}

        CUString (const CUStringBase &str) : CUStringBase (str) {}

        CUString (const std::string &str) : CUStringBase ()
        {
            rawCopy(str);
        }

        ~CUString () {}

        CUString &operator= (ucchar c)
        {
            resize (1);
            operator[](0) = c;
            return *this;
        }

        CUString &operator= (const char *str)
        {
            resize (strlen (str));
            for (uint32 i = 0; i < strlen (str); i++)
            {
                operator[](i) = uint8(str[i]);
            }
            return *this;
        }

        CUString &operator= (const std::string &str)
        {
            resize (str.size ());
            for (uint32 i = 0; i < str.size (); i++)
            {
                operator[](i) = uint8(str[i]);
            }
            return *this;
        }

        CUString &operator= (const CUStringBase &str)
        {
            CUStringBase::operator =(str);
            return *this;
        }

        CUString& operator= (const ucchar *str)
        {
            CUStringBase::operator =(str);
            return *this;
        }
        CUString &operator+= (ucchar c)
        {
            resize (size() + 1);
            operator[](size()-1) = c;
            return *this;
        }

        CUString &operator+= (const char *str)
        {
            size_t s = size();
            resize (s + strlen(str));
            for (uint32 i = 0; i < strlen(str); i++)
            {
                operator[](s+i) = uint8(str[i]);
            }
            return *this;
        }

        CUString &operator+= (const std::string &str)
        {
            size_t s = size();
            resize (s + str.size());
            for (uint32 i = 0; i < str.size(); i++)
            {
                operator[](s+i) = uint8(str[i]);
            }
            return *this;
        }

        CUString &operator+= (const CUStringBase &str)
        {
            CUStringBase::operator +=(str);
            return *this;
        }

        const ucchar *c_str() const
        {
            const ucchar *tmp = CUStringBase::c_str();
            const_cast<ucchar*>(tmp)[size()] = 0;
            return tmp;
        }

        void toString (std::string &str) const
        {
            str.resize (size ());
            for (uint32 i = 0; i < str.size (); i++)
            {
                if (operator[](i) > 255)
                    str[i] = '?';
                else
                    str[i] = (char) operator[](i);
            }
        }

        std::string toString () const
        {
            std::string str;
            toString(str);
            return str;
        }

        std::string toUtf8() const
        {
            std::string	res;
            CUString::const_iterator first(begin()), last(end());
            for (; first != last; ++first)
            {
                //ucchar	c = *first;
                uint32 nbLoop = 0;
                if (*first < 0x80)
                    res += char(*first);
                else if (*first < 0x800)
                {
                    ucchar c = *first;
                    c = c >> 6;
                    c = c & 0x1F;
                    res += char(c) | 0xC0;
                    nbLoop = 1;
                }
                else /*if (*first < 0x10000)*/
                {
                    ucchar c = *first;
                    c = c >> 12;
                    c = c & 0x0F;
                    res += char(c) | 0xE0;
                    nbLoop = 2;
                }

                for (uint32 i=0; i<nbLoop; ++i)
                {
                    ucchar	c = *first;
                    c = c >> ((nbLoop - i - 1) * 6);
                    c = c & 0x3F;
                    res += char(c) | 0x80;
                }
            }
            return res;
        }

        void fromUtf8(const std::string &stringUtf8)
        {
            // clear the string
            erase();

            uint8 c;
            ucchar code;
            sint32 iterations = 0;

            std::string::const_iterator first(stringUtf8.begin()), last(stringUtf8.end());
            for (; first != last; )
            {
                c = *first++;
                code = c;

                if ((code & 0xFE) == 0xFC)
                {
                    code &= 0x01;
                    iterations = 5;
                }
                else if ((code & 0xFC) == 0xF8)
                {
                    code &= 0x03;
                    iterations = 4;
                }
                else if ((code & 0xF8) == 0xF0)
                {
                    code &= 0x07;
                    iterations = 3;
                }
                else if ((code & 0xF0) == 0xE0)
                {
                    code &= 0x0F;
                    iterations = 2;
                }
                else if ((code & 0xE0) == 0xC0)
                {
                    code &= 0x1F;
                    iterations = 1;
                }
                else if ((code & 0x80) == 0x80)
                {
                    rawCopy(stringUtf8);
                    return;
                }
                else
                {
                    push_back(code);
                    iterations = 0;
                }

                if (iterations)
                {
                    for (sint32 i = 0; i < iterations; i++)
                    {
                        if (first == last)
                        {
                            rawCopy(stringUtf8);
                            return;
                        }

                        uint8 ch;
                        ch = *first ++;

                        if ((ch & 0xC0) != 0x80)
                        {
                            rawCopy(stringUtf8);
                            return;
                        }

                        code <<= 6;
                        code |= (ucchar)(ch & 0x3F);
                    }
                    push_back(code);
                }
            }
        }

    public:
        static CUString MakeFromUtf8(const std::string &stringUtf8)
        {
            CUString ret;
            ret.fromUtf8(stringUtf8);

            return ret;
        }

    private:

        void rawCopy(const std::string &str)
        {
            resize(str.size());
            std::string::const_iterator first(str.begin()), last(str.end());
            iterator dest(begin());
            for (;first != last; ++first, ++dest)
            {
                *dest = uint8(*first);
            }
        }
    };

    inline CUString operator+(const CUStringBase &ucstr, ucchar c)
    {
        CUString	ret;
        ret= ucstr;
        ret+= c;
        return ret;
    }

    inline CUString operator+(const CUStringBase &ucstr, const char *c)
    {
        CUString	ret;
        ret= ucstr;
        ret+= c;
        return ret;
    }

    inline CUString operator+(const CUStringBase &ucstr, const std::string &c)
    {
        CUString	ret;
        ret= ucstr;
        ret+= c;
        return ret;
    }

    inline CUString operator+(ucchar c, const CUStringBase &ucstr)
    {
        CUString	ret;
        ret= c;
        ret += ucstr;
        return ret;
    }

    inline CUString operator+(const char *c, const CUStringBase &ucstr)
    {
        CUString	ret;
        ret= c;
        ret += ucstr;
        return ret;
    }

    inline CUString operator+(const std::string &c, const CUStringBase &ucstr)
    {
        CUString	ret;
        ret= c;
        ret += ucstr;
        return ret;
    }

    struct CUCStringHashMapTraits
    {
        static const size_t bucket_size = 4;
        static const size_t min_buckets = 8;
        CUCStringHashMapTraits() { }
        size_t operator() (const CUString &id ) const
        {
            return id.size();
        }
        bool operator() (const CUString &id1, const CUString &id2) const
        {
            return id1.size() < id2.size();
        }
    };

    CUString	gxToLower (const CUString &str);
    void		gxToLower (ucchar *str);
    ucchar		gxToLower (ucchar c);

    CUString	gxToUpper (const CUString &str);
    void		gxToUpper (ucchar *str);
    ucchar		gxToUpper (ucchar c);

    uint32 gxUtf8StringSize(const char* buff, uint32 len);
};

#endif