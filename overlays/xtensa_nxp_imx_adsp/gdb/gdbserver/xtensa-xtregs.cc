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

#define XTENSA_ELF_XTREG_SIZE	216

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   44, 176,   0,   0,  4, -1, 0x0204, "br" },
  {   45, 180,   4,   4,  4, -1, 0x020c, "scompare1" },
  {   47, 188,   8,  16,  4,  1, 0x03f0, "ae_ovf_sar" },
  {   48, 192,  12,  20,  4,  1, 0x03f1, "ae_bithead" },
  {   49, 196,  16,  24,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
  {   50, 200,  20,  28,  4,  1, 0x03f3, "ae_cw_sd_no" },
  {   51, 204,  24,  32,  4,  1, 0x03f6, "ae_cbegin0" },
  {   52, 208,  28,  36,  4,  1, 0x03f7, "ae_cend0" },
  {   53, 212,  32,  40,  4,  1, 0x03f8, "ae_cbegin1" },
  {   54, 216,  36,  44,  4,  1, 0x03f9, "ae_cend1" },
  {   55, 220,  40,  48,  8,  1, 0x1000, "aed0" },
  {   56, 228,  48,  56,  8,  1, 0x1001, "aed1" },
  {   57, 236,  56,  64,  8,  1, 0x1002, "aed2" },
  {   58, 244,  64,  72,  8,  1, 0x1003, "aed3" },
  {   59, 252,  72,  80,  8,  1, 0x1004, "aed4" },
  {   60, 260,  80,  88,  8,  1, 0x1005, "aed5" },
  {   61, 268,  88,  96,  8,  1, 0x1006, "aed6" },
  {   62, 276,  96, 104,  8,  1, 0x1007, "aed7" },
  {   63, 284, 104, 112,  8,  1, 0x1008, "aed8" },
  {   64, 292, 112, 120,  8,  1, 0x1009, "aed9" },
  {   65, 300, 120, 128,  8,  1, 0x100a, "aed10" },
  {   66, 308, 128, 136,  8,  1, 0x100b, "aed11" },
  {   67, 316, 136, 144,  8,  1, 0x100c, "aed12" },
  {   68, 324, 144, 152,  8,  1, 0x100d, "aed13" },
  {   69, 332, 152, 160,  8,  1, 0x100e, "aed14" },
  {   70, 340, 160, 168,  8,  1, 0x100f, "aed15" },
  {   71, 348, 176, 184,  8,  1, 0x1010, "u0" },
  {   72, 356, 184, 192,  8,  1, 0x1011, "u1" },
  {   73, 364, 192, 200,  8,  1, 0x1012, "u2" },
  {   74, 372, 200, 208,  8,  1, 0x1013, "u3" },
  {   75, 380, 168, 176,  1,  1, 0x1014, "aep0" },
  {   76, 381, 169, 177,  1,  1, 0x1015, "aep1" },
  {   77, 382, 170, 178,  1,  1, 0x1016, "aep2" },
  {   78, 383, 171, 179,  1,  1, 0x1017, "aep3" },
  {   79, 384,   0,   8,  4,  1, 0x1019, "fcr_fsr" },
  { 0 }
};

