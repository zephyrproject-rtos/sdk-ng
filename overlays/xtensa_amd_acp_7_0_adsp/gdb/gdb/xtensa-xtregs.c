/* Customized table mapping between kernel xtregset and GDB register cache.

   Customer ID=18056; Build=0xa6a6b; Copyright (c) 2007-2010 Tensilica Inc.

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
  
  #define XTENSA_ELF_XTREG_SIZE	400
  
  const xtensa_regtable_t  xtensa_regmap_table[] = {
    /* gnum,gofs,cpofs,ofs,siz,cp, dbnum,  name */
    {   76, 304,   0,   0,  4, -1, 0x0204, "br" },
    {   77, 308,   4,   4,  4, -1, 0x0300, "xnne_rerr" },
    {   79, 316,  16,  32,  4,  1, 0x03f0, "ae_ovf_sar" },
    {   80, 320,  20,  36,  4,  1, 0x03f1, "ae_bithead" },
    {   81, 324,  24,  40,  4,  1, 0x03f2, "ae_ts_fts_bu_bp" },
    {   82, 328,  28,  44,  4,  1, 0x03f3, "ae_cw_sd_no" },
    {   83, 332,  32,  48,  4,  1, 0x03f6, "ae_cbegin0" },
    {   84, 336,  36,  52,  4,  1, 0x03f7, "ae_cend0" },
    {   85, 340,  40,  56,  4,  1, 0x03f8, "ae_cbegin1" },
    {   86, 344,  44,  60,  4,  1, 0x03f9, "ae_cend1" },
    {   87, 348,  48,  64,  4,  1, 0x03fa, "ae_cbegin2" },
    {   88, 352,  52,  68,  4,  1, 0x03fb, "ae_cend2" },
    {   89, 356,  56,  72,  8,  1, 0x1000, "aed0" },
    {   90, 364,  64,  80,  8,  1, 0x1001, "aed1" },
    {   91, 372,  72,  88,  8,  1, 0x1002, "aed2" },
    {   92, 380,  80,  96,  8,  1, 0x1003, "aed3" },
    {   93, 388,  88, 104,  8,  1, 0x1004, "aed4" },
    {   94, 396,  96, 112,  8,  1, 0x1005, "aed5" },
    {   95, 404, 104, 120,  8,  1, 0x1006, "aed6" },
    {   96, 412, 112, 128,  8,  1, 0x1007, "aed7" },
    {   97, 420, 120, 136,  8,  1, 0x1008, "aed8" },
    {   98, 428, 128, 144,  8,  1, 0x1009, "aed9" },
    {   99, 436, 136, 152,  8,  1, 0x100a, "aed10" },
    {  100, 444, 144, 160,  8,  1, 0x100b, "aed11" },
    {  101, 452, 152, 168,  8,  1, 0x100c, "aed12" },
    {  102, 460, 160, 176,  8,  1, 0x100d, "aed13" },
    {  103, 468, 168, 184,  8,  1, 0x100e, "aed14" },
    {  104, 476, 176, 192,  8,  1, 0x100f, "aed15" },
    {  105, 484, 184, 200,  8,  1, 0x1010, "aed16" },
    {  106, 492, 192, 208,  8,  1, 0x1011, "aed17" },
    {  107, 500, 200, 216,  8,  1, 0x1012, "aed18" },
    {  108, 508, 208, 224,  8,  1, 0x1013, "aed19" },
    {  109, 516, 216, 232,  8,  1, 0x1014, "aed20" },
    {  110, 524, 224, 240,  8,  1, 0x1015, "aed21" },
    {  111, 532, 232, 248,  8,  1, 0x1016, "aed22" },
    {  112, 540, 240, 256,  8,  1, 0x1017, "aed23" },
    {  113, 548, 248, 264,  8,  1, 0x1018, "aed24" },
    {  114, 556, 256, 272,  8,  1, 0x1019, "aed25" },
    {  115, 564, 264, 280,  8,  1, 0x101a, "aed26" },
    {  116, 572, 272, 288,  8,  1, 0x101b, "aed27" },
    {  117, 580, 280, 296,  8,  1, 0x101c, "aed28" },
    {  118, 588, 288, 304,  8,  1, 0x101d, "aed29" },
    {  119, 596, 296, 312,  8,  1, 0x101e, "aed30" },
    {  120, 604, 304, 320,  8,  1, 0x101f, "aed31" },
    {  121, 612, 320, 336, 16,  1, 0x1020, "u0" },
    {  122, 628, 336, 352, 16,  1, 0x1021, "u1" },
    {  123, 644, 352, 368, 16,  1, 0x1022, "u2" },
    {  124, 660, 368, 384, 16,  1, 0x1023, "u3" },
    {  125, 676, 312, 328,  1,  1, 0x1024, "aep0" },
    {  126, 677, 313, 329,  1,  1, 0x1025, "aep1" },
    {  127, 678, 314, 330,  1,  1, 0x1026, "aep2" },
    {  128, 679, 315, 331,  1,  1, 0x1027, "aep3" },
    {  129, 680,   0,  16,  4,  1, 0x1029, "ae_zbiasv8c" },
    {  130, 684,   8,  24,  4,  1, 0x102a, "fcr_fsr" },
    { 0 }
  };
  
  