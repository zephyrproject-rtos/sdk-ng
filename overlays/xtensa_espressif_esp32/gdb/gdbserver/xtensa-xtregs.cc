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

#define XTENSA_ELF_XTREG_SIZE	116

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   75, 300,   8,   8,  4, -1, 0x0204, "br" },
  {   76, 304,  12,  12,  4, -1, 0x020c, "scompare1" },
  {   77, 308,   0,   0,  4, -1, 0x0210, "acclo" },
  {   78, 312,   4,   4,  4, -1, 0x0211, "acchi" },
  {   79, 316,  16,  16,  4, -1, 0x0220, "m0" },
  {   80, 320,  20,  20,  4, -1, 0x0221, "m1" },
  {   81, 324,  24,  24,  4, -1, 0x0222, "m2" },
  {   82, 328,  28,  28,  4, -1, 0x0223, "m3" },
  {   84, 336,  32,  32,  4, -1, 0x03ea, "f64r_lo" },
  {   85, 340,  36,  36,  4, -1, 0x03eb, "f64r_hi" },
  {   86, 344,  40,  40,  4, -1, 0x03ec, "f64s" },
  {   87, 348,   8,  52,  4,  0, 0x0030, "f0" },
  {   88, 352,  12,  56,  4,  0, 0x0031, "f1" },
  {   89, 356,  16,  60,  4,  0, 0x0032, "f2" },
  {   90, 360,  20,  64,  4,  0, 0x0033, "f3" },
  {   91, 364,  24,  68,  4,  0, 0x0034, "f4" },
  {   92, 368,  28,  72,  4,  0, 0x0035, "f5" },
  {   93, 372,  32,  76,  4,  0, 0x0036, "f6" },
  {   94, 376,  36,  80,  4,  0, 0x0037, "f7" },
  {   95, 380,  40,  84,  4,  0, 0x0038, "f8" },
  {   96, 384,  44,  88,  4,  0, 0x0039, "f9" },
  {   97, 388,  48,  92,  4,  0, 0x003a, "f10" },
  {   98, 392,  52,  96,  4,  0, 0x003b, "f11" },
  {   99, 396,  56, 100,  4,  0, 0x003c, "f12" },
  {  100, 400,  60, 104,  4,  0, 0x003d, "f13" },
  {  101, 404,  64, 108,  4,  0, 0x003e, "f14" },
  {  102, 408,  68, 112,  4,  0, 0x003f, "f15" },
  {  103, 412,   0,  44,  4,  0, 0x03e8, "fcr" },
  {  104, 416,   4,  48,  4,  0, 0x03e9, "fsr" },
  { 0 }
};

