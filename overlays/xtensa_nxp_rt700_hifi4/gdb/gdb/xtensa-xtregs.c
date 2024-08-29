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

#define XTENSA_ELF_XTREG_SIZE	256

const xtensa_regtable_t  xtensa_regmap_table[] = {
  /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
  {   44, 176,   8,   8,  4, -1, 0x0204, "br" },
  {   45, 180,  12,  12,  4, -1, 0x020c, "scompare1" },
  {   46, 184,   0,   0,  4, -1, 0x0210, "acclo" },
  {   47, 188,   4,   4,  4, -1, 0x0211, "acchi" },
  {   48, 192,  16,  16,  4, -1, 0x0220, "m0" },
  {   49, 196,  20,  20,  4, -1, 0x0221, "m1" },
  {   50, 200,  24,  24,  4, -1, 0x0222, "m2" },
  {   51, 204,  28,  28,  4, -1, 0x0223, "m3" },
  {   53, 212,  32,  32,  4, -1, 0x03ea, "f64r_lo" },
  {   54, 216,  36,  36,  4, -1, 0x03eb, "f64r_hi" },
  {   55, 220,  40,  40,  4, -1, 0x03ec, "f64s" },
  {   56, 224,   8,  56,  4,  1, 0x03f0, "ae_ovf_sar" },
  {   57, 228,  12,  60,  4,  1, 0x03f1, "ae_bithead" },
  {   58, 232,  16,  64,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
  {   59, 236,  20,  68,  4,  1, 0x03f3, "ae_cw_sd_no" },
  {   60, 240,  24,  72,  4,  1, 0x03f6, "ae_cbegin0" },
  {   61, 244,  28,  76,  4,  1, 0x03f7, "ae_cend0" },
  {   62, 248,  32,  80,  4,  1, 0x03f8, "ae_cbegin1" },
  {   63, 252,  36,  84,  4,  1, 0x03f9, "ae_cend1" },
  {   64, 256,  40,  88,  8,  1, 0x1010, "aed0" },
  {   65, 264,  48,  96,  8,  1, 0x1011, "aed1" },
  {   66, 272,  56, 104,  8,  1, 0x1012, "aed2" },
  {   67, 280,  64, 112,  8,  1, 0x1013, "aed3" },
  {   68, 288,  72, 120,  8,  1, 0x1014, "aed4" },
  {   69, 296,  80, 128,  8,  1, 0x1015, "aed5" },
  {   70, 304,  88, 136,  8,  1, 0x1016, "aed6" },
  {   71, 312,  96, 144,  8,  1, 0x1017, "aed7" },
  {   72, 320, 104, 152,  8,  1, 0x1018, "aed8" },
  {   73, 328, 112, 160,  8,  1, 0x1019, "aed9" },
  {   74, 336, 120, 168,  8,  1, 0x101a, "aed10" },
  {   75, 344, 128, 176,  8,  1, 0x101b, "aed11" },
  {   76, 352, 136, 184,  8,  1, 0x101c, "aed12" },
  {   77, 360, 144, 192,  8,  1, 0x101d, "aed13" },
  {   78, 368, 152, 200,  8,  1, 0x101e, "aed14" },
  {   79, 376, 160, 208,  8,  1, 0x101f, "aed15" },
  {   80, 384, 176, 224,  8,  1, 0x1020, "u0" },
  {   81, 392, 184, 232,  8,  1, 0x1021, "u1" },
  {   82, 400, 192, 240,  8,  1, 0x1022, "u2" },
  {   83, 408, 200, 248,  8,  1, 0x1023, "u3" },
  {   84, 416, 168, 216,  1,  1, 0x1024, "aep0" },
  {   85, 417, 169, 217,  1,  1, 0x1025, "aep1" },
  {   86, 418, 170, 218,  1,  1, 0x1026, "aep2" },
  {   87, 419, 171, 219,  1,  1, 0x1027, "aep3" },
  {   88, 420,   0,  48,  4,  1, 0x1029, "fcr_fsr" },
  { 0 }
};

