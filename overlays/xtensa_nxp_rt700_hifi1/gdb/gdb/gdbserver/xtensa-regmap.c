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

#define XTENSA_ELF_XTREG_SIZE	208

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   51, 180,   0,   0,  4, -1, 0x020c, "scompare1" },
  {   53, 188,  32,  48,  8,  1, 0x1000, "aed0" },
  {   54, 196,  40,  56,  8,  1, 0x1001, "aed1" },
  {   55, 204,  48,  64,  8,  1, 0x1002, "aed2" },
  {   56, 212,  56,  72,  8,  1, 0x1003, "aed3" },
  {   57, 220,  64,  80,  8,  1, 0x1004, "aed4" },
  {   58, 228,  72,  88,  8,  1, 0x1005, "aed5" },
  {   59, 236,  80,  96,  8,  1, 0x1006, "aed6" },
  {   60, 244,  88, 104,  8,  1, 0x1007, "aed7" },
  {   61, 252,  96, 112,  8,  1, 0x1008, "aed8" },
  {   62, 260, 104, 120,  8,  1, 0x1009, "aed9" },
  {   63, 268, 112, 128,  8,  1, 0x100a, "aed10" },
  {   64, 276, 120, 136,  8,  1, 0x100b, "aed11" },
  {   65, 284, 128, 144,  8,  1, 0x100c, "aed12" },
  {   66, 292, 136, 152,  8,  1, 0x100d, "aed13" },
  {   67, 300, 144, 160,  8,  1, 0x100e, "aed14" },
  {   68, 308, 152, 168,  8,  1, 0x100f, "aed15" },
  {   69, 316, 160, 176,  8,  1, 0x1010, "u0" },
  {   70, 324, 168, 184,  8,  1, 0x1011, "u1" },
  {   71, 332, 176, 192,  8,  1, 0x1012, "u2" },
  {   72, 340, 184, 200,  8,  1, 0x1013, "u3" },
  {   73, 348,   8,  24,  8,  1, 0x1020, "circ" },
  {   74, 356,  16,  32,  8,  1, 0x1021, "tablefirstsearchnext" },
  {   75, 364,   0,  16,  8,  1, 0x1022, "fusionmisc" },
  {   76, 372,  24,  40,  4,  1, 0x1023, "fcr_fsr" },
  { 0 }
};

