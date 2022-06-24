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

#define XTENSA_ELF_XTREG_SIZE	192

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   76, 304,   0,   0,  4, -1, 0x0204, "br" },
  {   77, 308,   4,   4,  4, -1, 0x020c, "scompare1" },
  {   79, 316,   0,   8,  4,  1, 0x03f0, "ae_ovf_sar" },
  {   80, 320,   4,  12,  4,  1, 0x03f1, "ae_bithead" },
  {   81, 324,   8,  16,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
  {   82, 328,  12,  20,  4,  1, 0x03f3, "ae_cw_sd_no" },
  {   83, 332,  16,  24,  4,  1, 0x03f6, "ae_cbegin0" },
  {   84, 336,  20,  28,  4,  1, 0x03f7, "ae_cend0" },
  {   85, 340,  24,  32,  8,  1, 0x1000, "aed0" },
  {   86, 348,  32,  40,  8,  1, 0x1001, "aed1" },
  {   87, 356,  40,  48,  8,  1, 0x1002, "aed2" },
  {   88, 364,  48,  56,  8,  1, 0x1003, "aed3" },
  {   89, 372,  56,  64,  8,  1, 0x1004, "aed4" },
  {   90, 380,  64,  72,  8,  1, 0x1005, "aed5" },
  {   91, 388,  72,  80,  8,  1, 0x1006, "aed6" },
  {   92, 396,  80,  88,  8,  1, 0x1007, "aed7" },
  {   93, 404,  88,  96,  8,  1, 0x1008, "aed8" },
  {   94, 412,  96, 104,  8,  1, 0x1009, "aed9" },
  {   95, 420, 104, 112,  8,  1, 0x100a, "aed10" },
  {   96, 428, 112, 120,  8,  1, 0x100b, "aed11" },
  {   97, 436, 120, 128,  8,  1, 0x100c, "aed12" },
  {   98, 444, 128, 136,  8,  1, 0x100d, "aed13" },
  {   99, 452, 136, 144,  8,  1, 0x100e, "aed14" },
  {  100, 460, 144, 152,  8,  1, 0x100f, "aed15" },
  {  101, 468, 152, 160,  8,  1, 0x1010, "u0" },
  {  102, 476, 160, 168,  8,  1, 0x1011, "u1" },
  {  103, 484, 168, 176,  8,  1, 0x1012, "u2" },
  {  104, 492, 176, 184,  8,  1, 0x1013, "u3" },
  { 0 }
};

