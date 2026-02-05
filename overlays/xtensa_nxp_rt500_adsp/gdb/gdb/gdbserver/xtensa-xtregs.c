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
  {   43, 172,   8,   8,  4, -1, 0x0204, "br" },
  {   44, 176,  12,  12,  4, -1, 0x020c, "scompare1" },
  {   45, 180,   0,   0,  4, -1, 0x0210, "acclo" },
  {   46, 184,   4,   4,  4, -1, 0x0211, "acchi" },
  {   47, 188,  16,  16,  4, -1, 0x0220, "m0" },
  {   48, 192,  20,  20,  4, -1, 0x0221, "m1" },
  {   49, 196,  24,  24,  4, -1, 0x0222, "m2" },
  {   50, 200,  28,  28,  4, -1, 0x0223, "m3" },
  {   52, 208,  32,  64,  8,  1, 0x1010, "aed0" },
  {   53, 216,  40,  72,  8,  1, 0x1011, "aed1" },
  {   54, 224,  48,  80,  8,  1, 0x1012, "aed2" },
  {   55, 232,  56,  88,  8,  1, 0x1013, "aed3" },
  {   56, 240,  64,  96,  8,  1, 0x1014, "aed4" },
  {   57, 248,  72, 104,  8,  1, 0x1015, "aed5" },
  {   58, 256,  80, 112,  8,  1, 0x1016, "aed6" },
  {   59, 264,  88, 120,  8,  1, 0x1017, "aed7" },
  {   60, 272,  96, 128,  8,  1, 0x1018, "aed8" },
  {   61, 280, 104, 136,  8,  1, 0x1019, "aed9" },
  {   62, 288, 112, 144,  8,  1, 0x101a, "aed10" },
  {   63, 296, 120, 152,  8,  1, 0x101b, "aed11" },
  {   64, 304, 128, 160,  8,  1, 0x101c, "u0" },
  {   65, 312, 136, 168,  8,  1, 0x101d, "u1" },
  {   66, 320, 144, 176,  8,  1, 0x101e, "u2" },
  {   67, 328, 152, 184,  8,  1, 0x101f, "u3" },
  {   68, 336,   8,  40,  8,  1, 0x1021, "circ" },
  {   69, 344,  16,  48,  8,  1, 0x1022, "tablefirstsearchnext" },
  {   70, 352,   0,  32,  8,  1, 0x1023, "fusionmisc" },
  {   71, 360,  24,  56,  4,  1, 0x1024, "fcr_fsr" },
  { 0 }
};

