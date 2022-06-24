/* Configuration for the Xtensa architecture for GDB, the GNU debugger.

   Copyright (c) 2003-2017 Tensilica Inc.

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
xtensa_reg_mask_t xtensa_submask0[] = { { 44, 0, 1 } };
const xtensa_mask_t xtensa_mask0 = { 1, xtensa_submask0 };
xtensa_reg_mask_t xtensa_submask1[] = { { 44, 1, 1 } };
const xtensa_mask_t xtensa_mask1 = { 1, xtensa_submask1 };
xtensa_reg_mask_t xtensa_submask2[] = { { 44, 2, 1 } };
const xtensa_mask_t xtensa_mask2 = { 1, xtensa_submask2 };
xtensa_reg_mask_t xtensa_submask3[] = { { 44, 3, 1 } };
const xtensa_mask_t xtensa_mask3 = { 1, xtensa_submask3 };
xtensa_reg_mask_t xtensa_submask4[] = { { 44, 4, 1 } };
const xtensa_mask_t xtensa_mask4 = { 1, xtensa_submask4 };
xtensa_reg_mask_t xtensa_submask5[] = { { 44, 5, 1 } };
const xtensa_mask_t xtensa_mask5 = { 1, xtensa_submask5 };
xtensa_reg_mask_t xtensa_submask6[] = { { 44, 6, 1 } };
const xtensa_mask_t xtensa_mask6 = { 1, xtensa_submask6 };
xtensa_reg_mask_t xtensa_submask7[] = { { 44, 7, 1 } };
const xtensa_mask_t xtensa_mask7 = { 1, xtensa_submask7 };
xtensa_reg_mask_t xtensa_submask8[] = { { 44, 8, 1 } };
const xtensa_mask_t xtensa_mask8 = { 1, xtensa_submask8 };
xtensa_reg_mask_t xtensa_submask9[] = { { 44, 9, 1 } };
const xtensa_mask_t xtensa_mask9 = { 1, xtensa_submask9 };
xtensa_reg_mask_t xtensa_submask10[] = { { 44, 10, 1 } };
const xtensa_mask_t xtensa_mask10 = { 1, xtensa_submask10 };
xtensa_reg_mask_t xtensa_submask11[] = { { 44, 11, 1 } };
const xtensa_mask_t xtensa_mask11 = { 1, xtensa_submask11 };
xtensa_reg_mask_t xtensa_submask12[] = { { 44, 12, 1 } };
const xtensa_mask_t xtensa_mask12 = { 1, xtensa_submask12 };
xtensa_reg_mask_t xtensa_submask13[] = { { 44, 13, 1 } };
const xtensa_mask_t xtensa_mask13 = { 1, xtensa_submask13 };
xtensa_reg_mask_t xtensa_submask14[] = { { 44, 14, 1 } };
const xtensa_mask_t xtensa_mask14 = { 1, xtensa_submask14 };
xtensa_reg_mask_t xtensa_submask15[] = { { 44, 15, 1 } };
const xtensa_mask_t xtensa_mask15 = { 1, xtensa_submask15 };
xtensa_reg_mask_t xtensa_submask16[] = { { 42, 0, 4 } };
const xtensa_mask_t xtensa_mask16 = { 1, xtensa_submask16 };
xtensa_reg_mask_t xtensa_submask17[] = { { 42, 5, 1 } };
const xtensa_mask_t xtensa_mask17 = { 1, xtensa_submask17 };
xtensa_reg_mask_t xtensa_submask18[] = { { 42, 18, 1 } };
const xtensa_mask_t xtensa_mask18 = { 1, xtensa_submask18 };
xtensa_reg_mask_t xtensa_submask19[] = { { 42, 4, 1 } };
const xtensa_mask_t xtensa_mask19 = { 1, xtensa_submask19 };
xtensa_reg_mask_t xtensa_submask20[] = { { 42, 16, 2 } };
const xtensa_mask_t xtensa_mask20 = { 1, xtensa_submask20 };
xtensa_reg_mask_t xtensa_submask21[] = { { 42, 8, 4 } };
const xtensa_mask_t xtensa_mask21 = { 1, xtensa_submask21 };
xtensa_reg_mask_t xtensa_submask22[] = { { 112, 8, 4 } };
const xtensa_mask_t xtensa_mask22 = { 1, xtensa_submask22 };
xtensa_reg_mask_t xtensa_submask23[] = { { 47, 7, 1 } };
const xtensa_mask_t xtensa_mask23 = { 1, xtensa_submask23 };
xtensa_reg_mask_t xtensa_submask24[] = { { 47, 0, 7 }, { 47, 8, 7 } };
const xtensa_mask_t xtensa_mask24 = { 2, xtensa_submask24 };
xtensa_reg_mask_t xtensa_submask25[] = { { 50, 28, 1 } };
const xtensa_mask_t xtensa_mask25 = { 1, xtensa_submask25 };
xtensa_reg_mask_t xtensa_submask26[] = { { 49, 0, 4 } };
const xtensa_mask_t xtensa_mask26 = { 1, xtensa_submask26 };
xtensa_reg_mask_t xtensa_submask27[] = { { 49, 4, 4 } };
const xtensa_mask_t xtensa_mask27 = { 1, xtensa_submask27 };
xtensa_reg_mask_t xtensa_submask28[] = { { 49, 12, 4 } };
const xtensa_mask_t xtensa_mask28 = { 1, xtensa_submask28 };
xtensa_reg_mask_t xtensa_submask29[] = { { 49, 8, 4 } };
const xtensa_mask_t xtensa_mask29 = { 1, xtensa_submask29 };
xtensa_reg_mask_t xtensa_submask30[] = { { 50, 0, 27 } };
const xtensa_mask_t xtensa_mask30 = { 1, xtensa_submask30 };
xtensa_reg_mask_t xtensa_submask31[] = { { 50, 27, 1 } };
const xtensa_mask_t xtensa_mask31 = { 1, xtensa_submask31 };
xtensa_reg_mask_t xtensa_submask32[] = { { 79, 5, 2 } };
const xtensa_mask_t xtensa_mask32 = { 1, xtensa_submask32 };
xtensa_reg_mask_t xtensa_submask33[] = { { 79, 4, 1 } };
const xtensa_mask_t xtensa_mask33 = { 1, xtensa_submask33 };
xtensa_reg_mask_t xtensa_submask34[] = { { 79, 3, 1 } };
const xtensa_mask_t xtensa_mask34 = { 1, xtensa_submask34 };
xtensa_reg_mask_t xtensa_submask35[] = { { 79, 2, 1 } };
const xtensa_mask_t xtensa_mask35 = { 1, xtensa_submask35 };
xtensa_reg_mask_t xtensa_submask36[] = { { 79, 1, 1 } };
const xtensa_mask_t xtensa_mask36 = { 1, xtensa_submask36 };
xtensa_reg_mask_t xtensa_submask37[] = { { 79, 0, 1 } };
const xtensa_mask_t xtensa_mask37 = { 1, xtensa_submask37 };


/* Register map.  */
xtensa_register_t rmap[] = 
{
  /*    idx ofs bi sz al targno  flags cp typ group name  */
  XTREG(  0,  0,32, 4, 4,0x0020,0x0006,-2, 9,0x0100,pc,          0,0,0,0,0,0)
  XTREG(  1,  4,32, 4, 4,0x0100,0x0006,-2, 1,0x0002,ar0,         0,0,0,0,0,0)
  XTREG(  2,  8,32, 4, 4,0x0101,0x0006,-2, 1,0x0002,ar1,         0,0,0,0,0,0)
  XTREG(  3, 12,32, 4, 4,0x0102,0x0006,-2, 1,0x0002,ar2,         0,0,0,0,0,0)
  XTREG(  4, 16,32, 4, 4,0x0103,0x0006,-2, 1,0x0002,ar3,         0,0,0,0,0,0)
  XTREG(  5, 20,32, 4, 4,0x0104,0x0006,-2, 1,0x0002,ar4,         0,0,0,0,0,0)
  XTREG(  6, 24,32, 4, 4,0x0105,0x0006,-2, 1,0x0002,ar5,         0,0,0,0,0,0)
  XTREG(  7, 28,32, 4, 4,0x0106,0x0006,-2, 1,0x0002,ar6,         0,0,0,0,0,0)
  XTREG(  8, 32,32, 4, 4,0x0107,0x0006,-2, 1,0x0002,ar7,         0,0,0,0,0,0)
  XTREG(  9, 36,32, 4, 4,0x0108,0x0006,-2, 1,0x0002,ar8,         0,0,0,0,0,0)
  XTREG( 10, 40,32, 4, 4,0x0109,0x0006,-2, 1,0x0002,ar9,         0,0,0,0,0,0)
  XTREG( 11, 44,32, 4, 4,0x010a,0x0006,-2, 1,0x0002,ar10,        0,0,0,0,0,0)
  XTREG( 12, 48,32, 4, 4,0x010b,0x0006,-2, 1,0x0002,ar11,        0,0,0,0,0,0)
  XTREG( 13, 52,32, 4, 4,0x010c,0x0006,-2, 1,0x0002,ar12,        0,0,0,0,0,0)
  XTREG( 14, 56,32, 4, 4,0x010d,0x0006,-2, 1,0x0002,ar13,        0,0,0,0,0,0)
  XTREG( 15, 60,32, 4, 4,0x010e,0x0006,-2, 1,0x0002,ar14,        0,0,0,0,0,0)
  XTREG( 16, 64,32, 4, 4,0x010f,0x0006,-2, 1,0x0002,ar15,        0,0,0,0,0,0)
  XTREG( 17, 68,32, 4, 4,0x0110,0x0006,-2, 1,0x0002,ar16,        0,0,0,0,0,0)
  XTREG( 18, 72,32, 4, 4,0x0111,0x0006,-2, 1,0x0002,ar17,        0,0,0,0,0,0)
  XTREG( 19, 76,32, 4, 4,0x0112,0x0006,-2, 1,0x0002,ar18,        0,0,0,0,0,0)
  XTREG( 20, 80,32, 4, 4,0x0113,0x0006,-2, 1,0x0002,ar19,        0,0,0,0,0,0)
  XTREG( 21, 84,32, 4, 4,0x0114,0x0006,-2, 1,0x0002,ar20,        0,0,0,0,0,0)
  XTREG( 22, 88,32, 4, 4,0x0115,0x0006,-2, 1,0x0002,ar21,        0,0,0,0,0,0)
  XTREG( 23, 92,32, 4, 4,0x0116,0x0006,-2, 1,0x0002,ar22,        0,0,0,0,0,0)
  XTREG( 24, 96,32, 4, 4,0x0117,0x0006,-2, 1,0x0002,ar23,        0,0,0,0,0,0)
  XTREG( 25,100,32, 4, 4,0x0118,0x0006,-2, 1,0x0002,ar24,        0,0,0,0,0,0)
  XTREG( 26,104,32, 4, 4,0x0119,0x0006,-2, 1,0x0002,ar25,        0,0,0,0,0,0)
  XTREG( 27,108,32, 4, 4,0x011a,0x0006,-2, 1,0x0002,ar26,        0,0,0,0,0,0)
  XTREG( 28,112,32, 4, 4,0x011b,0x0006,-2, 1,0x0002,ar27,        0,0,0,0,0,0)
  XTREG( 29,116,32, 4, 4,0x011c,0x0006,-2, 1,0x0002,ar28,        0,0,0,0,0,0)
  XTREG( 30,120,32, 4, 4,0x011d,0x0006,-2, 1,0x0002,ar29,        0,0,0,0,0,0)
  XTREG( 31,124,32, 4, 4,0x011e,0x0006,-2, 1,0x0002,ar30,        0,0,0,0,0,0)
  XTREG( 32,128,32, 4, 4,0x011f,0x0006,-2, 1,0x0002,ar31,        0,0,0,0,0,0)
  XTREG( 33,132,32, 4, 4,0x0200,0x0006,-2, 2,0x1100,lbeg,        0,0,0,0,0,0)
  XTREG( 34,136,32, 4, 4,0x0201,0x0006,-2, 2,0x1100,lend,        0,0,0,0,0,0)
  XTREG( 35,140,32, 4, 4,0x0202,0x0006,-2, 2,0x1100,lcount,      0,0,0,0,0,0)
  XTREG( 36,144, 6, 4, 4,0x0203,0x0006,-2, 2,0x1100,sar,         0,0,0,0,0,0)
  XTREG( 37,148,20, 4, 4,0x0228,0x0006,-2, 2,0x1100,prefctl,     0,0,0,0,0,0)
  XTREG( 38,152, 3, 4, 4,0x0248,0x0006,-2, 2,0x1002,windowbase,  0,0,0,0,0,0)
  XTREG( 39,156, 8, 4, 4,0x0249,0x0006,-2, 2,0x1002,windowstart, 0,0,0,0,0,0)
  XTREG( 40,160,32, 4, 4,0x02b0,0x0002,-2, 2,0x1000,configid0,   0,0,0,0,0,0)
  XTREG( 41,164,32, 4, 4,0x02d0,0x0002,-2, 2,0x1000,configid1,   0,0,0,0,0,0)
  XTREG( 42,168,19, 4, 4,0x02e6,0x0006,-2, 2,0x1100,ps,          0,0,0,0,0,0)
  XTREG( 43,172,32, 4, 4,0x03e7,0x0006,-2, 3,0x0110,threadptr,   0,0,0,0,0,0)
  XTREG( 44,176,16, 4, 4,0x0204,0x0006,-1, 2,0x1100,br,          0,0,0,0,0,0)
  XTREG( 45,180,32, 4, 4,0x020c,0x0006,-1, 2,0x1100,scompare1,   0,0,0,0,0,0)
  XTREG( 46,184,32, 4, 4,0x03e6,0x000e,-1, 3,0x0110,expstate,    0,0,0,0,0,0)
  XTREG( 47,188,15, 4, 4,0x03f0,0x0006, 1, 3,0x0100,ae_ovf_sar,  0,0,0,0,0,0)
  XTREG( 48,192,32, 4, 4,0x03f1,0x0006, 1, 3,0x0110,ae_bithead,  0,0,0,0,0,0)
  XTREG( 49,196,16, 4, 4,0x03f2,0x0006, 1, 3,0x0100,ae_ts_fts_bu_bp,0,0,0,0,0,0)
  XTREG( 50,200,29, 4, 4,0x03f3,0x0006, 1, 3,0x0100,ae_cw_sd_no, 0,0,0,0,0,0)
  XTREG( 51,204,32, 4, 4,0x03f6,0x0006, 1, 3,0x0110,ae_cbegin0,  0,0,0,0,0,0)
  XTREG( 52,208,32, 4, 4,0x03f7,0x0006, 1, 3,0x0110,ae_cend0,    0,0,0,0,0,0)
  XTREG( 53,212,32, 4, 4,0x03f8,0x0006, 1, 3,0x0110,ae_cbegin1,  0,0,0,0,0,0)
  XTREG( 54,216,32, 4, 4,0x03f9,0x0006, 1, 3,0x0110,ae_cend1,    0,0,0,0,0,0)
  XTREG( 55,220,64, 8, 8,0x1000,0x0006, 1, 4,0x0101,aed0,
            "03:04:04:01","03:04:04:cf",0,0,0,0)
  XTREG( 56,228,64, 8, 8,0x1001,0x0006, 1, 4,0x0101,aed1,
            "03:04:14:01","03:04:14:cf",0,0,0,0)
  XTREG( 57,236,64, 8, 8,0x1002,0x0006, 1, 4,0x0101,aed2,
            "03:04:24:01","03:04:24:cf",0,0,0,0)
  XTREG( 58,244,64, 8, 8,0x1003,0x0006, 1, 4,0x0101,aed3,
            "03:04:34:01","03:04:34:cf",0,0,0,0)
  XTREG( 59,252,64, 8, 8,0x1004,0x0006, 1, 4,0x0101,aed4,
            "03:04:44:01","03:04:44:cf",0,0,0,0)
  XTREG( 60,260,64, 8, 8,0x1005,0x0006, 1, 4,0x0101,aed5,
            "03:04:54:01","03:04:54:cf",0,0,0,0)
  XTREG( 61,268,64, 8, 8,0x1006,0x0006, 1, 4,0x0101,aed6,
            "03:04:64:01","03:04:64:cf",0,0,0,0)
  XTREG( 62,276,64, 8, 8,0x1007,0x0006, 1, 4,0x0101,aed7,
            "03:04:74:01","03:04:74:cf",0,0,0,0)
  XTREG( 63,284,64, 8, 8,0x1008,0x0006, 1, 4,0x0101,aed8,
            "03:04:84:01","03:04:84:cf",0,0,0,0)
  XTREG( 64,292,64, 8, 8,0x1009,0x0006, 1, 4,0x0101,aed9,
            "03:04:94:01","03:04:94:cf",0,0,0,0)
  XTREG( 65,300,64, 8, 8,0x100a,0x0006, 1, 4,0x0101,aed10,
            "03:04:a4:01","03:04:a4:cf",0,0,0,0)
  XTREG( 66,308,64, 8, 8,0x100b,0x0006, 1, 4,0x0101,aed11,
            "03:04:b4:01","03:04:b4:cf",0,0,0,0)
  XTREG( 67,316,64, 8, 8,0x100c,0x0006, 1, 4,0x0101,aed12,
            "03:04:c4:01","03:04:c4:cf",0,0,0,0)
  XTREG( 68,324,64, 8, 8,0x100d,0x0006, 1, 4,0x0101,aed13,
            "03:04:d4:01","03:04:d4:cf",0,0,0,0)
  XTREG( 69,332,64, 8, 8,0x100e,0x0006, 1, 4,0x0101,aed14,
            "03:04:e4:01","03:04:e4:cf",0,0,0,0)
  XTREG( 70,340,64, 8, 8,0x100f,0x0006, 1, 4,0x0101,aed15,
            "03:04:f4:01","03:04:f4:cf",0,0,0,0)
  XTREG( 71,348,64, 8, 8,0x1010,0x0006, 1, 4,0x0101,u0,
            "0b:9f:24:70:16:3d:00:6c:a4:c5:77:39","0b:9f:24:70:16:2d:00:6c:a4:c5:77:39",0,0,0,0)
  XTREG( 72,356,64, 8, 8,0x1011,0x0006, 1, 4,0x0101,u1,
            "0b:9f:64:70:16:3d:00:6c:a4:c5:77:39","0b:9f:64:70:16:2d:00:6c:a4:c5:77:39",0,0,0,0)
  XTREG( 73,364,64, 8, 8,0x1012,0x0006, 1, 4,0x0101,u2,
            "0b:9f:a4:70:16:3d:00:6c:a4:c5:77:39","0b:9f:a4:70:16:2d:00:6c:a4:c5:77:39",0,0,0,0)
  XTREG( 74,372,64, 8, 8,0x1013,0x0006, 1, 4,0x0101,u3,
            "0b:9f:e4:70:16:3d:00:6c:a4:c5:77:39","0b:9f:e4:70:16:2d:00:6c:a4:c5:77:39",0,0,0,0)
  XTREG( 75,380, 8, 1, 1,0x1014,0x0006, 1, 4,0x0101,aep0,
            "03:52:64:01:06:5e:f0:06:01:e6:fc:03:52:44:00:03:52:24:01","03:52:64:01:03:52:04:00:06:5e:f4:06:01:e6:fc:03:52:24:01",0,0,0,0)
  XTREG( 76,381, 8, 1, 1,0x1015,0x0006, 1, 4,0x0101,aep1,
            "03:52:64:01:06:5e:f1:06:01:e6:fc:03:52:44:00:03:52:24:01","03:52:64:01:03:52:04:00:06:5e:f5:06:01:e6:fc:03:52:24:01",0,0,0,0)
  XTREG( 77,382, 8, 1, 1,0x1016,0x0006, 1, 4,0x0101,aep2,
            "03:52:64:01:06:5e:f2:06:01:e6:fc:03:52:44:00:03:52:24:01","03:52:64:01:03:52:04:00:06:5e:f6:06:01:e6:fc:03:52:24:01",0,0,0,0)
  XTREG( 78,383, 8, 1, 1,0x1017,0x0006, 1, 4,0x0101,aep3,
            "03:52:64:01:06:5e:f3:06:01:e6:fc:03:52:44:00:03:52:24:01","03:52:64:01:03:52:04:00:06:5e:f7:06:01:e6:fc:03:52:24:01",0,0,0,0)
  XTREG( 79,384, 7, 4, 4,0x1019,0x0006, 1, 3,0x0100,fcr_fsr,
            "03:14:04:01:0b:1f:15:70:06:3d:e3:6d:c4:c7:7f:39:03:04:04:01:03:14:04:cf","03:14:04:01:03:04:04:cf:0b:1f:15:70:06:1d:e3:6d:c4:c7:7f:39:03:14:04:cf",0,0,0,0)
  XTREG( 80,388,32, 4, 4,0x0259,0x000d,-2, 2,0x1000,mmid,        0,0,0,0,0,0)
  XTREG( 81,392, 2, 4, 4,0x0260,0x0007,-2, 2,0x1000,ibreakenable,0,0,0,0,0,0)
  XTREG( 82,396, 6, 4, 4,0x0263,0x0007,-2, 2,0x1000,atomctl,     0,0,0,0,0,0)
  XTREG( 83,400,32, 4, 4,0x0268,0x0007,-2, 2,0x1000,ddr,         0,0,0,0,0,0)
  XTREG( 84,404,32, 4, 4,0x0280,0x0007,-2, 2,0x1000,ibreaka0,    0,0,0,0,0,0)
  XTREG( 85,408,32, 4, 4,0x0281,0x0007,-2, 2,0x1000,ibreaka1,    0,0,0,0,0,0)
  XTREG( 86,412,32, 4, 4,0x0290,0x0007,-2, 2,0x1000,dbreaka0,    0,0,0,0,0,0)
  XTREG( 87,416,32, 4, 4,0x0291,0x0007,-2, 2,0x1000,dbreaka1,    0,0,0,0,0,0)
  XTREG( 88,420,32, 4, 4,0x02a0,0x0007,-2, 2,0x1000,dbreakc0,    0,0,0,0,0,0)
  XTREG( 89,424,32, 4, 4,0x02a1,0x0007,-2, 2,0x1000,dbreakc1,    0,0,0,0,0,0)
  XTREG( 90,428,32, 4, 4,0x02b1,0x0007,-2, 2,0x1000,epc1,        0,0,0,0,0,0)
  XTREG( 91,432,32, 4, 4,0x02b2,0x0007,-2, 2,0x1000,epc2,        0,0,0,0,0,0)
  XTREG( 92,436,32, 4, 4,0x02b3,0x0007,-2, 2,0x1000,epc3,        0,0,0,0,0,0)
  XTREG( 93,440,32, 4, 4,0x02b4,0x0007,-2, 2,0x1000,epc4,        0,0,0,0,0,0)
  XTREG( 94,444,32, 4, 4,0x02b5,0x0007,-2, 2,0x1000,epc5,        0,0,0,0,0,0)
  XTREG( 95,448,32, 4, 4,0x02c0,0x0007,-2, 2,0x1000,depc,        0,0,0,0,0,0)
  XTREG( 96,452,19, 4, 4,0x02c2,0x0007,-2, 2,0x1000,eps2,        0,0,0,0,0,0)
  XTREG( 97,456,19, 4, 4,0x02c3,0x0007,-2, 2,0x1000,eps3,        0,0,0,0,0,0)
  XTREG( 98,460,19, 4, 4,0x02c4,0x0007,-2, 2,0x1000,eps4,        0,0,0,0,0,0)
  XTREG( 99,464,19, 4, 4,0x02c5,0x0007,-2, 2,0x1000,eps5,        0,0,0,0,0,0)
  XTREG(100,468,32, 4, 4,0x02d1,0x0007,-2, 2,0x1000,excsave1,    0,0,0,0,0,0)
  XTREG(101,472,32, 4, 4,0x02d2,0x0007,-2, 2,0x1000,excsave2,    0,0,0,0,0,0)
  XTREG(102,476,32, 4, 4,0x02d3,0x0007,-2, 2,0x1000,excsave3,    0,0,0,0,0,0)
  XTREG(103,480,32, 4, 4,0x02d4,0x0007,-2, 2,0x1000,excsave4,    0,0,0,0,0,0)
  XTREG(104,484,32, 4, 4,0x02d5,0x0007,-2, 2,0x1000,excsave5,    0,0,0,0,0,0)
  XTREG(105,488, 2, 4, 4,0x02e0,0x0007,-2, 2,0x1000,cpenable,    0,0,0,0,0,0)
  XTREG(106,492,32, 4, 4,0x02e2,0x000b,-2, 2,0x1000,interrupt,   0,0,0,0,0,0)
  XTREG(107,496,32, 4, 4,0x02e2,0x000d,-2, 2,0x1000,intset,      0,0,0,0,0,0)
  XTREG(108,500,32, 4, 4,0x02e3,0x000d,-2, 2,0x1000,intclear,    0,0,0,0,0,0)
  XTREG(109,504,32, 4, 4,0x02e4,0x0007,-2, 2,0x1000,intenable,   0,0,0,0,0,0)
  XTREG(110,508,32, 4, 4,0x02e7,0x0007,-2, 2,0x1000,vecbase,     0,0,0,0,0,0)
  XTREG(111,512, 6, 4, 4,0x02e8,0x0007,-2, 2,0x1000,exccause,    0,0,0,0,0,0)
  XTREG(112,516,12, 4, 4,0x02e9,0x0003,-2, 2,0x1000,debugcause,  0,0,0,0,0,0)
  XTREG(113,520,32, 4, 4,0x02ea,0x000f,-2, 2,0x1000,ccount,      0,0,0,0,0,0)
  XTREG(114,524,32, 4, 4,0x02eb,0x0003,-2, 2,0x1000,prid,        0,0,0,0,0,0)
  XTREG(115,528,32, 4, 4,0x02ec,0x000f,-2, 2,0x1000,icount,      0,0,0,0,0,0)
  XTREG(116,532, 4, 4, 4,0x02ed,0x0007,-2, 2,0x1000,icountlevel, 0,0,0,0,0,0)
  XTREG(117,536,32, 4, 4,0x02ee,0x0007,-2, 2,0x1000,excvaddr,    0,0,0,0,0,0)
  XTREG(118,540,32, 4, 4,0x02f0,0x000f,-2, 2,0x1000,ccompare0,   0,0,0,0,0,0)
  XTREG(119,544,32, 4, 4,0x02f1,0x000f,-2, 2,0x1000,ccompare1,   0,0,0,0,0,0)
  XTREG(120,548,32, 4, 4,0x02f4,0x0007,-2, 2,0x1000,misc0,       0,0,0,0,0,0)
  XTREG(121,552,32, 4, 4,0x02f5,0x0007,-2, 2,0x1000,misc1,       0,0,0,0,0,0)
  XTREG(122,556,32, 4, 4,0x0000,0x0006,-2, 8,0x0100,a0,          0,0,0,0,0,0)
  XTREG(123,560,32, 4, 4,0x0001,0x0006,-2, 8,0x0100,a1,          0,0,0,0,0,0)
  XTREG(124,564,32, 4, 4,0x0002,0x0006,-2, 8,0x0100,a2,          0,0,0,0,0,0)
  XTREG(125,568,32, 4, 4,0x0003,0x0006,-2, 8,0x0100,a3,          0,0,0,0,0,0)
  XTREG(126,572,32, 4, 4,0x0004,0x0006,-2, 8,0x0100,a4,          0,0,0,0,0,0)
  XTREG(127,576,32, 4, 4,0x0005,0x0006,-2, 8,0x0100,a5,          0,0,0,0,0,0)
  XTREG(128,580,32, 4, 4,0x0006,0x0006,-2, 8,0x0100,a6,          0,0,0,0,0,0)
  XTREG(129,584,32, 4, 4,0x0007,0x0006,-2, 8,0x0100,a7,          0,0,0,0,0,0)
  XTREG(130,588,32, 4, 4,0x0008,0x0006,-2, 8,0x0100,a8,          0,0,0,0,0,0)
  XTREG(131,592,32, 4, 4,0x0009,0x0006,-2, 8,0x0100,a9,          0,0,0,0,0,0)
  XTREG(132,596,32, 4, 4,0x000a,0x0006,-2, 8,0x0100,a10,         0,0,0,0,0,0)
  XTREG(133,600,32, 4, 4,0x000b,0x0006,-2, 8,0x0100,a11,         0,0,0,0,0,0)
  XTREG(134,604,32, 4, 4,0x000c,0x0006,-2, 8,0x0100,a12,         0,0,0,0,0,0)
  XTREG(135,608,32, 4, 4,0x000d,0x0006,-2, 8,0x0100,a13,         0,0,0,0,0,0)
  XTREG(136,612,32, 4, 4,0x000e,0x0006,-2, 8,0x0100,a14,         0,0,0,0,0,0)
  XTREG(137,616,32, 4, 4,0x000f,0x0006,-2, 8,0x0100,a15,         0,0,0,0,0,0)
  XTREG(138,620, 1, 1, 1,0x0010,0x0006,-2, 6,0x1010,b0,
            0,0,&xtensa_mask0,0,0,0)
  XTREG(139,621, 1, 1, 1,0x0011,0x0006,-2, 6,0x1010,b1,
            0,0,&xtensa_mask1,0,0,0)
  XTREG(140,622, 1, 1, 1,0x0012,0x0006,-2, 6,0x1010,b2,
            0,0,&xtensa_mask2,0,0,0)
  XTREG(141,623, 1, 1, 1,0x0013,0x0006,-2, 6,0x1010,b3,
            0,0,&xtensa_mask3,0,0,0)
  XTREG(142,624, 1, 1, 1,0x0014,0x0006,-2, 6,0x1010,b4,
            0,0,&xtensa_mask4,0,0,0)
  XTREG(143,625, 1, 1, 1,0x0015,0x0006,-2, 6,0x1010,b5,
            0,0,&xtensa_mask5,0,0,0)
  XTREG(144,626, 1, 1, 1,0x0016,0x0006,-2, 6,0x1010,b6,
            0,0,&xtensa_mask6,0,0,0)
  XTREG(145,627, 1, 1, 1,0x0017,0x0006,-2, 6,0x1010,b7,
            0,0,&xtensa_mask7,0,0,0)
  XTREG(146,628, 1, 1, 1,0x0018,0x0006,-2, 6,0x1010,b8,
            0,0,&xtensa_mask8,0,0,0)
  XTREG(147,629, 1, 1, 1,0x0019,0x0006,-2, 6,0x1010,b9,
            0,0,&xtensa_mask9,0,0,0)
  XTREG(148,630, 1, 1, 1,0x001a,0x0006,-2, 6,0x1010,b10,
            0,0,&xtensa_mask10,0,0,0)
  XTREG(149,631, 1, 1, 1,0x001b,0x0006,-2, 6,0x1010,b11,
            0,0,&xtensa_mask11,0,0,0)
  XTREG(150,632, 1, 1, 1,0x001c,0x0006,-2, 6,0x1010,b12,
            0,0,&xtensa_mask12,0,0,0)
  XTREG(151,633, 1, 1, 1,0x001d,0x0006,-2, 6,0x1010,b13,
            0,0,&xtensa_mask13,0,0,0)
  XTREG(152,634, 1, 1, 1,0x001e,0x0006,-2, 6,0x1010,b14,
            0,0,&xtensa_mask14,0,0,0)
  XTREG(153,635, 1, 1, 1,0x001f,0x0006,-2, 6,0x1010,b15,
            0,0,&xtensa_mask15,0,0,0)
  XTREG(154,636, 4, 4, 4,0x2006,0x0006,-2, 6,0x1010,psintlevel,
            0,0,&xtensa_mask16,0,0,0)
  XTREG(155,640, 1, 4, 4,0x2007,0x0006,-2, 6,0x1010,psum,
            0,0,&xtensa_mask17,0,0,0)
  XTREG(156,644, 1, 4, 4,0x2008,0x0006,-2, 6,0x1010,pswoe,
            0,0,&xtensa_mask18,0,0,0)
  XTREG(157,648, 1, 4, 4,0x2009,0x0006,-2, 6,0x1010,psexcm,
            0,0,&xtensa_mask19,0,0,0)
  XTREG(158,652, 2, 4, 4,0x200a,0x0006,-2, 6,0x1010,pscallinc,
            0,0,&xtensa_mask20,0,0,0)
  XTREG(159,656, 4, 4, 4,0x200b,0x0006,-2, 6,0x1010,psowb,
            0,0,&xtensa_mask21,0,0,0)
  XTREG(160,660, 4, 4, 4,0x2010,0x0006,-2, 6,0x1010,dbnum,
            0,0,&xtensa_mask22,0,0,0)
  XTREG(161,664, 1, 4, 4,0x2013,0x0006, 1, 5,0x1010,ae_overflow,
            0,0,&xtensa_mask23,0,0,0)
  XTREG(162,668,14, 4, 4,0x2014,0x0006, 1, 5,0x1010,ae_sar,
            0,0,&xtensa_mask24,0,0,0)
  XTREG(163,672, 1, 4, 4,0x2015,0x0006, 1, 5,0x1010,ae_cwrap,
            0,0,&xtensa_mask25,0,0,0)
  XTREG(164,676, 4, 4, 4,0x2016,0x0006, 1, 5,0x1010,ae_bitptr,
            0,0,&xtensa_mask26,0,0,0)
  XTREG(165,680, 4, 4, 4,0x2017,0x0006, 1, 5,0x1010,ae_bitsused,
            0,0,&xtensa_mask27,0,0,0)
  XTREG(166,684, 4, 4, 4,0x2018,0x0006, 1, 5,0x1010,ae_tablesize,
            0,0,&xtensa_mask28,0,0,0)
  XTREG(167,688, 4, 4, 4,0x2019,0x0006, 1, 5,0x1010,ae_first_ts,
            0,0,&xtensa_mask29,0,0,0)
  XTREG(168,692,27, 4, 4,0x201a,0x0006, 1, 5,0x1010,ae_nextoffset,
            0,0,&xtensa_mask30,0,0,0)
  XTREG(169,696, 1, 4, 4,0x201b,0x0006, 1, 5,0x1010,ae_searchdone,
            0,0,&xtensa_mask31,0,0,0)
  XTREG(170,700, 2, 4, 4,0x201c,0x0006, 1, 6,0x1010,roundmode,
            0,0,&xtensa_mask32,0,0,0)
  XTREG(171,704, 1, 4, 4,0x201d,0x0006, 1, 6,0x1010,invalidflag,
            0,0,&xtensa_mask33,0,0,0)
  XTREG(172,708, 1, 4, 4,0x201e,0x0006, 1, 6,0x1010,divzeroflag,
            0,0,&xtensa_mask34,0,0,0)
  XTREG(173,712, 1, 4, 4,0x201f,0x0006, 1, 6,0x1010,overflowflag,
            0,0,&xtensa_mask35,0,0,0)
  XTREG(174,716, 1, 4, 4,0x2020,0x0006, 1, 6,0x1010,underflowflag,
            0,0,&xtensa_mask36,0,0,0)
  XTREG_END
};



#ifdef XTENSA_CONFIG_INSTANTIATE
XTENSA_CONFIG_INSTANTIATE(rmap,16)
#endif

