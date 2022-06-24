/* Customized table mapping between kernel xtregset and GDB register cache.

   Customer ID=4313; Build=0x5483e; Copyright (c) 2007-2010 Tensilica Inc.

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

#define XTENSA_ELF_XTREG_SIZE	128

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   43, 172,   0,   0,  4, -1, 0x0204, "br" },
  {   44, 176,   4,   4,  4, -1, 0x020c, "scompare1" },
  {   46, 184,  24,  32,  8,  1, 0x0060, "aep0" },
  {   47, 192,  32,  40,  8,  1, 0x0061, "aep1" },
  {   48, 200,  40,  48,  8,  1, 0x0062, "aep2" },
  {   49, 208,  48,  56,  8,  1, 0x0063, "aep3" },
  {   50, 216,  56,  64,  8,  1, 0x0064, "aep4" },
  {   51, 224,  64,  72,  8,  1, 0x0065, "aep5" },
  {   52, 232,  72,  80,  8,  1, 0x0066, "aep6" },
  {   53, 240,  80,  88,  8,  1, 0x0067, "aep7" },
  {   54, 248,  88,  96,  8,  1, 0x0068, "aeq0" },
  {   55, 256,  96, 104,  8,  1, 0x0069, "aeq1" },
  {   56, 264, 104, 112,  8,  1, 0x006a, "aeq2" },
  {   57, 272, 112, 120,  8,  1, 0x006b, "aeq3" },
  {   58, 280,   0,   8,  4,  1, 0x03f0, "ae_ovf_sar" },
  {   59, 284,   4,  12,  4,  1, 0x03f1, "ae_bithead" },
  {   60, 288,   8,  16,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
  {   61, 292,  12,  20,  4,  1, 0x03f3, "ae_sd_no" },
  {   62, 296,  16,  24,  4,  1, 0x03f6, "ae_cbegin0" },
  {   63, 300,  20,  28,  4,  1, 0x03f7, "ae_cend0" },
  { 0 }
};

