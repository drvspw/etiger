/*
 * Copyright (C) 2001-2010 Jacek Sieka, arnetheduck on gmail point com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * This program has been ported into C by John-John Tedro <johnjohn.tedro@gmail.com>
 */
#if !defined(TIGER_HASH_H)
#define TIGER_HASH_H

#include <stddef.h>
#include <stdint.h>

#if defined(_MSC_VER) || defined(__MINGW32__)
#define _LL(x) x##ll
#define _ULL(x) x##ull
#define I64_FMT "%I64d"
#define U64_FMT "%I64d"
#elif defined(SIZEOF_LONG) && SIZEOF_LONG == 8
#define _LL(x) x##l
#define _ULL(x) x##ul
#define I64_FMT "%ld"
#define U64_FMT "%ld"
#else
#define _LL(x) x##ll
#define _ULL(x) x##ull
#define I64_FMT "%lld"
#define U64_FMT "%lld"
#endif

#define TIGER_BITS (192)
#define TIGER_BYTES (TIGER_BITS / 8)
#define TIGER_STR_BYTES ((TIGER_BYTES*2)+1)
#define TIGER_BLOCK_SIZE (512/8)

#define TIGER_PAD (0x01)
#define TIGER2_PAD (0x80)

#ifdef __cplusplus
extern "C"
{
#endif // __cplusplus

typedef struct tigerhash_t
{
  /** pad character 0x01 for tiger and 0x80 for tiger2 */
  uint8_t pad;

  /** 512 bit blocks for the compress function */
  uint8_t tmp[512/8];
  /** State / final hash value */
  uint64_t res[3];
  /** Total number of bytes compressed */
  uint64_t pos;
  /** S boxes */

  
} tigerhash;



  uint8_t * tiger(const void *data, size_t len);
  void tiger_str(char hashStr[], const void *data, size_t len);

  uint8_t * tiger2(const void *data, size_t len);
  void tiger2_str(char hashStr[], const void *data, size_t len);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // !defined(TIGER_HASH_H)
