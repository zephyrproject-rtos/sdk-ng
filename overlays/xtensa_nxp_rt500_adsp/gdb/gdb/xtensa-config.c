/* Configuration for the Xtensa architecture for GDB, the GNU debugger.

   Copyright (c) 2003-2022 Cadence Design Systems, Inc.

   Permission is hereby granted, free of charge, to any person obtaining
   a copy of this software and associated documentation files (the
   "Software"), to deal in the Software without restriction, including
   without limitation the rights to use, copy, modify, merge, publish,
   distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to
   the following conditions:

   The above copyright notice and this permission notice shall be included
   in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */

#define XTENSA_CONFIG_VERSION 0x60

#include "defs.h"
#include "xtensa-config.h"
#include "xtensa-tdep.h"



/* Masked registers.  */
xtensa_reg_mask_t xtensa_submask0[] = { { 43, 0, 1 } };
const xtensa_mask_t xtensa_mask0 = { 1, xtensa_submask0 };
xtensa_reg_mask_t xtensa_submask1[] = { { 43, 1, 1 } };
const xtensa_mask_t xtensa_mask1 = { 1, xtensa_submask1 };
xtensa_reg_mask_t xtensa_submask2[] = { { 43, 2, 1 } };
const xtensa_mask_t xtensa_mask2 = { 1, xtensa_submask2 };
xtensa_reg_mask_t xtensa_submask3[] = { { 43, 3, 1 } };
const xtensa_mask_t xtensa_mask3 = { 1, xtensa_submask3 };
xtensa_reg_mask_t xtensa_submask4[] = { { 43, 4, 1 } };
const xtensa_mask_t xtensa_mask4 = { 1, xtensa_submask4 };
xtensa_reg_mask_t xtensa_submask5[] = { { 43, 5, 1 } };
const xtensa_mask_t xtensa_mask5 = { 1, xtensa_submask5 };
xtensa_reg_mask_t xtensa_submask6[] = { { 43, 6, 1 } };
const xtensa_mask_t xtensa_mask6 = { 1, xtensa_submask6 };
xtensa_reg_mask_t xtensa_submask7[] = { { 43, 7, 1 } };
const xtensa_mask_t xtensa_mask7 = { 1, xtensa_submask7 };
xtensa_reg_mask_t xtensa_submask8[] = { { 43, 8, 1 } };
const xtensa_mask_t xtensa_mask8 = { 1, xtensa_submask8 };
xtensa_reg_mask_t xtensa_submask9[] = { { 43, 9, 1 } };
const xtensa_mask_t xtensa_mask9 = { 1, xtensa_submask9 };
xtensa_reg_mask_t xtensa_submask10[] = { { 43, 10, 1 } };
const xtensa_mask_t xtensa_mask10 = { 1, xtensa_submask10 };
xtensa_reg_mask_t xtensa_submask11[] = { { 43, 11, 1 } };
const xtensa_mask_t xtensa_mask11 = { 1, xtensa_submask11 };
xtensa_reg_mask_t xtensa_submask12[] = { { 43, 12, 1 } };
const xtensa_mask_t xtensa_mask12 = { 1, xtensa_submask12 };
xtensa_reg_mask_t xtensa_submask13[] = { { 43, 13, 1 } };
const xtensa_mask_t xtensa_mask13 = { 1, xtensa_submask13 };
xtensa_reg_mask_t xtensa_submask14[] = { { 43, 14, 1 } };
const xtensa_mask_t xtensa_mask14 = { 1, xtensa_submask14 };
xtensa_reg_mask_t xtensa_submask15[] = { { 43, 15, 1 } };
const xtensa_mask_t xtensa_mask15 = { 1, xtensa_submask15 };
xtensa_reg_mask_t xtensa_submask16[] = { { 41, 0, 4 } };
const xtensa_mask_t xtensa_mask16 = { 1, xtensa_submask16 };
xtensa_reg_mask_t xtensa_submask17[] = { { 41, 5, 1 } };
const xtensa_mask_t xtensa_mask17 = { 1, xtensa_submask17 };
xtensa_reg_mask_t xtensa_submask18[] = { { 41, 18, 1 } };
const xtensa_mask_t xtensa_mask18 = { 1, xtensa_submask18 };
xtensa_reg_mask_t xtensa_submask19[] = { { 41, 4, 1 } };
const xtensa_mask_t xtensa_mask19 = { 1, xtensa_submask19 };
xtensa_reg_mask_t xtensa_submask20[] = { { 41, 16, 2 } };
const xtensa_mask_t xtensa_mask20 = { 1, xtensa_submask20 };
xtensa_reg_mask_t xtensa_submask21[] = { { 41, 8, 4 } };
const xtensa_mask_t xtensa_mask21 = { 1, xtensa_submask21 };
xtensa_reg_mask_t xtensa_submask22[] = { { 45, 0, 32 }, { 46, 0, 8 } };
const xtensa_mask_t xtensa_mask22 = { 2, xtensa_submask22 };
xtensa_reg_mask_t xtensa_submask23[] = { { 105, 8, 4 } };
const xtensa_mask_t xtensa_mask23 = { 1, xtensa_submask23 };
xtensa_reg_mask_t xtensa_submask24[] = { { 70, 7, 1 } };
const xtensa_mask_t xtensa_mask24 = { 1, xtensa_submask24 };
xtensa_reg_mask_t xtensa_submask25[] = { { 68, 32, 32 } };
const xtensa_mask_t xtensa_mask25 = { 1, xtensa_submask25 };
xtensa_reg_mask_t xtensa_submask26[] = { { 68, 0, 32 } };
const xtensa_mask_t xtensa_mask26 = { 1, xtensa_submask26 };
xtensa_reg_mask_t xtensa_submask27[] = { { 70, 0, 7 } };
const xtensa_mask_t xtensa_mask27 = { 1, xtensa_submask27 };
xtensa_reg_mask_t xtensa_submask28[] = { { 70, 8, 1 } };
const xtensa_mask_t xtensa_mask28 = { 1, xtensa_submask28 };
xtensa_reg_mask_t xtensa_submask29[] = { { 70, 17, 32 } };
const xtensa_mask_t xtensa_mask29 = { 1, xtensa_submask29 };
xtensa_reg_mask_t xtensa_submask30[] = { { 70, 13, 4 } };
const xtensa_mask_t xtensa_mask30 = { 1, xtensa_submask30 };
xtensa_reg_mask_t xtensa_submask31[] = { { 70, 9, 4 } };
const xtensa_mask_t xtensa_mask31 = { 1, xtensa_submask31 };
xtensa_reg_mask_t xtensa_submask32[] = { { 69, 32, 4 } };
const xtensa_mask_t xtensa_mask32 = { 1, xtensa_submask32 };
xtensa_reg_mask_t xtensa_submask33[] = { { 69, 28, 4 } };
const xtensa_mask_t xtensa_mask33 = { 1, xtensa_submask33 };
xtensa_reg_mask_t xtensa_submask34[] = { { 69, 0, 27 } };
const xtensa_mask_t xtensa_mask34 = { 1, xtensa_submask34 };
xtensa_reg_mask_t xtensa_submask35[] = { { 69, 27, 1 } };
const xtensa_mask_t xtensa_mask35 = { 1, xtensa_submask35 };
xtensa_reg_mask_t xtensa_submask36[] = { { 71, 5, 2 } };
const xtensa_mask_t xtensa_mask36 = { 1, xtensa_submask36 };
xtensa_reg_mask_t xtensa_submask37[] = { { 71, 4, 1 } };
const xtensa_mask_t xtensa_mask37 = { 1, xtensa_submask37 };
xtensa_reg_mask_t xtensa_submask38[] = { { 71, 3, 1 } };
const xtensa_mask_t xtensa_mask38 = { 1, xtensa_submask38 };
xtensa_reg_mask_t xtensa_submask39[] = { { 71, 2, 1 } };
const xtensa_mask_t xtensa_mask39 = { 1, xtensa_submask39 };
xtensa_reg_mask_t xtensa_submask40[] = { { 71, 1, 1 } };
const xtensa_mask_t xtensa_mask40 = { 1, xtensa_submask40 };
xtensa_reg_mask_t xtensa_submask41[] = { { 71, 0, 1 } };
const xtensa_mask_t xtensa_mask41 = { 1, xtensa_submask41 };


/* Register map.  */
xtensa_register_t xtensa_rmap[] =
{
  /*    idx ofs bi sz al targno  flags cp typ group name  */
  XTREG_END
};



#ifdef XTENSA_CONFIG_INSTANTIATE
XTENSA_CONFIG_INSTANTIATE(xtensa_rmap,16)
#endif

xtensa_gdbarch_tdep xtensa_tdep (xtensa_rmap);
