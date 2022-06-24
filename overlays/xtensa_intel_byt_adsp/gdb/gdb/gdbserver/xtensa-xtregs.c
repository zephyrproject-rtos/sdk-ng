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

#define XTENSA_ELF_XTREG_SIZE	152

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   46, 184,  24,  24,  4, -1, 0x0204, "br" },
  {   47, 188,  28,  28,  4, -1, 0x020c, "scompare1" },
  {   48, 192,   0,   0,  4, -1, 0x0210, "acclo" },
  {   49, 196,   4,   4,  4, -1, 0x0211, "acchi" },
  {   50, 200,   8,   8,  4, -1, 0x0220, "m0" },
  {   51, 204,  12,  12,  4, -1, 0x0221, "m1" },
  {   52, 208,  16,  16,  4, -1, 0x0222, "m2" },
  {   53, 212,  20,  20,  4, -1, 0x0223, "m3" },
  {   54, 216,  24,  56,  8,  1, 0x0060, "aep0" },
  {   55, 224,  32,  64,  8,  1, 0x0061, "aep1" },
  {   56, 232,  40,  72,  8,  1, 0x0062, "aep2" },
  {   57, 240,  48,  80,  8,  1, 0x0063, "aep3" },
  {   58, 248,  56,  88,  8,  1, 0x0064, "aep4" },
  {   59, 256,  64,  96,  8,  1, 0x0065, "aep5" },
  {   60, 264,  72, 104,  8,  1, 0x0066, "aep6" },
  {   61, 272,  80, 112,  8,  1, 0x0067, "aep7" },
  {   62, 280,  88, 120,  8,  1, 0x0068, "aeq0" },
  {   63, 288,  96, 128,  8,  1, 0x0069, "aeq1" },
  {   64, 296, 104, 136,  8,  1, 0x006a, "aeq2" },
  {   65, 304, 112, 144,  8,  1, 0x006b, "aeq3" },
  {   66, 312,   0,  32,  4,  1, 0x03f0, "ae_ovf_sar" },
  {   67, 316,   4,  36,  4,  1, 0x03f1, "ae_bithead" },
  {   68, 320,   8,  40,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
  {   69, 324,  12,  44,  4,  1, 0x03f3, "ae_sd_no" },
  {   70, 328,  16,  48,  4,  1, 0x03f6, "ae_cbegin0" },
  {   71, 332,  20,  52,  4,  1, 0x03f7, "ae_cend0" },
  { 0 }
};

