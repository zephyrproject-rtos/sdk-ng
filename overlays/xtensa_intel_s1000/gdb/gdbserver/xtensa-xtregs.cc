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

#define XTENSA_ELF_XTREG_SIZE	264

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   76, 304,   0,   0,  4, -1, 0x0204, "br" },
  {   77, 308,   4,   4,  4, -1, 0x020c, "scompare1" },
  {   78, 312,   8,  16,  4,  0, 0x0030, "f0" },
  {   79, 316,  12,  20,  4,  0, 0x0031, "f1" },
  {   80, 320,  16,  24,  4,  0, 0x0032, "f2" },
  {   81, 324,  20,  28,  4,  0, 0x0033, "f3" },
  {   82, 328,  24,  32,  4,  0, 0x0034, "f4" },
  {   83, 332,  28,  36,  4,  0, 0x0035, "f5" },
  {   84, 336,  32,  40,  4,  0, 0x0036, "f6" },
  {   85, 340,  36,  44,  4,  0, 0x0037, "f7" },
  {   86, 344,  40,  48,  4,  0, 0x0038, "f8" },
  {   87, 348,  44,  52,  4,  0, 0x0039, "f9" },
  {   88, 352,  48,  56,  4,  0, 0x003a, "f10" },
  {   89, 356,  52,  60,  4,  0, 0x003b, "f11" },
  {   90, 360,  56,  64,  4,  0, 0x003c, "f12" },
  {   91, 364,  60,  68,  4,  0, 0x003d, "f13" },
  {   92, 368,  64,  72,  4,  0, 0x003e, "f14" },
  {   93, 372,  68,  76,  4,  0, 0x003f, "f15" },
  {   94, 376,   0,   8,  4,  0, 0x03e8, "fcr" },
  {   95, 380,   4,  12,  4,  0, 0x03e9, "fsr" },
  {   96, 384,   0,  80,  4,  1, 0x03f0, "ae_ovf_sar" },
  {   97, 388,   4,  84,  4,  1, 0x03f1, "ae_bithead" },
  {   98, 392,   8,  88,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
  {   99, 396,  12,  92,  4,  1, 0x03f3, "ae_cw_sd_no" },
  {  100, 400,  16,  96,  4,  1, 0x03f6, "ae_cbegin0" },
  {  101, 404,  20, 100,  4,  1, 0x03f7, "ae_cend0" },
  {  102, 408,  24, 104,  8,  1, 0x1000, "aed0" },
  {  103, 416,  32, 112,  8,  1, 0x1001, "aed1" },
  {  104, 424,  40, 120,  8,  1, 0x1002, "aed2" },
  {  105, 432,  48, 128,  8,  1, 0x1003, "aed3" },
  {  106, 440,  56, 136,  8,  1, 0x1004, "aed4" },
  {  107, 448,  64, 144,  8,  1, 0x1005, "aed5" },
  {  108, 456,  72, 152,  8,  1, 0x1006, "aed6" },
  {  109, 464,  80, 160,  8,  1, 0x1007, "aed7" },
  {  110, 472,  88, 168,  8,  1, 0x1008, "aed8" },
  {  111, 480,  96, 176,  8,  1, 0x1009, "aed9" },
  {  112, 488, 104, 184,  8,  1, 0x100a, "aed10" },
  {  113, 496, 112, 192,  8,  1, 0x100b, "aed11" },
  {  114, 504, 120, 200,  8,  1, 0x100c, "aed12" },
  {  115, 512, 128, 208,  8,  1, 0x100d, "aed13" },
  {  116, 520, 136, 216,  8,  1, 0x100e, "aed14" },
  {  117, 528, 144, 224,  8,  1, 0x100f, "aed15" },
  {  118, 536, 152, 232,  8,  1, 0x1010, "u0" },
  {  119, 544, 160, 240,  8,  1, 0x1011, "u1" },
  {  120, 552, 168, 248,  8,  1, 0x1012, "u2" },
  {  121, 560, 176, 256,  8,  1, 0x1013, "u3" },
  { 0 }
};

