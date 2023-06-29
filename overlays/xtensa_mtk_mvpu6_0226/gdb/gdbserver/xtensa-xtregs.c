/* Customized table mapping between kernel xtregset and GDB register cache.

   Copyright (c) 2007-2010 Tensilica Inc.

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


typedef struct {
  int   gdb_regnum;
  int   gdb_offset;
  int   ptrace_cp_offset;
  int   ptrace_offset;
  int   size;
  int   coproc;
  int   dbnum;
  char* name
;} xtensa_regtable_t;

#define XTENSA_ELF_XTREG_SIZE	3712

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   43, 172,   0,   0,  4, -1, 0x0204, "br" },
  {   44, 176,   4,   4,  4, -1, 0x0300, "apb_pipe" },
  {   45, 180, 320, 384, 64,  1, 0x1000, "v0" },
  {   46, 244, 384, 448, 64,  1, 0x1001, "v1" },
  {   47, 308, 448, 512, 64,  1, 0x1002, "v2" },
  {   48, 372, 512, 576, 64,  1, 0x1003, "v3" },
  {   49, 436, 576, 640, 64,  1, 0x1004, "v4" },
  {   50, 500, 640, 704, 64,  1, 0x1005, "v5" },
  {   51, 564, 704, 768, 64,  1, 0x1006, "v6" },
  {   52, 628, 768, 832, 64,  1, 0x1007, "v7" },
  {   53, 692, 832, 896, 64,  1, 0x1008, "v8" },
  {   54, 756, 896, 960, 64,  1, 0x1009, "v9" },
  {   55, 820, 960,1024, 64,  1, 0x100a, "v10" },
  {   56, 884,1024,1088, 64,  1, 0x100b, "v11" },
  {   57, 948,1088,1152, 64,  1, 0x100c, "v12" },
  {   58,1012,1152,1216, 64,  1, 0x100d, "v13" },
  {   59,1076,1216,1280, 64,  1, 0x100e, "v14" },
  {   60,1140,1280,1344, 64,  1, 0x100f, "v15" },
  {   61,1204,1344,1408, 64,  1, 0x1010, "v16" },
  {   62,1268,1408,1472, 64,  1, 0x1011, "v17" },
  {   63,1332,1472,1536, 64,  1, 0x1012, "v18" },
  {   64,1396,1536,1600, 64,  1, 0x1013, "v19" },
  {   65,1460,1600,1664, 64,  1, 0x1014, "v20" },
  {   66,1524,1664,1728, 64,  1, 0x1015, "v21" },
  {   67,1588,1728,1792, 64,  1, 0x1016, "v22" },
  {   68,1652,1792,1856, 64,  1, 0x1017, "v23" },
  {   69,1716,1856,1920, 64,  1, 0x1018, "v24" },
  {   70,1780,1920,1984, 64,  1, 0x1019, "v25" },
  {   71,1844,1984,2048, 64,  1, 0x101a, "v26" },
  {   72,1908,2048,2112, 64,  1, 0x101b, "v27" },
  {   73,1972,2112,2176, 64,  1, 0x101c, "v28" },
  {   74,2036,2176,2240, 64,  1, 0x101d, "v29" },
  {   75,2100,2240,2304, 64,  1, 0x101e, "v30" },
  {   76,2164,2304,2368, 64,  1, 0x101f, "v31" },
  {   77,2228, 256, 320,  8,  1, 0x1020, "vb0" },
  {   78,2236, 264, 328,  8,  1, 0x1021, "vb1" },
  {   79,2244, 272, 336,  8,  1, 0x1022, "vb2" },
  {   80,2252, 280, 344,  8,  1, 0x1023, "vb3" },
  {   81,2260, 288, 352,  8,  1, 0x1024, "vb4" },
  {   82,2268, 296, 360,  8,  1, 0x1025, "vb5" },
  {   83,2276, 304, 368,  8,  1, 0x1026, "vb6" },
  {   84,2284, 312, 376,  8,  1, 0x1027, "vb7" },
  {   85,2292,   0,  64, 64,  1, 0x1028, "u0" },
  {   86,2356,  64, 128, 64,  1, 0x1029, "u1" },
  {   87,2420, 128, 192, 64,  1, 0x102a, "u2" },
  {   88,2484, 192, 256, 64,  1, 0x102b, "u3" },
  {   89,2548,2624,2688,256,  1, 0x102c, "wv0" },
  {   90,2804,2880,2944,256,  1, 0x102d, "wv1" },
  {   91,3060,3136,3200,256,  1, 0x102e, "wv2" },
  {   92,3316,3392,3456,256,  1, 0x102f, "wv3" },
  {   93,3572,2368,2432, 64,  1, 0x1030, "gr0" },
  {   94,3636,2432,2496, 64,  1, 0x1031, "gr1" },
  {   95,3700,2496,2560, 64,  1, 0x1032, "gr2" },
  {   96,3764,2560,2624, 64,  1, 0x1033, "gr3" },
  { 0 }
};

