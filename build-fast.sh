#!/bin/sh
git grep -l CT_COMP_LIBS_NEWLIB_NANO configs/ | xargs sed -i -e 's/CT_COMP_LIBS_NEWLIB_NANO=y/CT_COMP_LIBS_NEWLIB_NANO=n/'
git grep -l CT_CC_LANG_CXX configs/ | xargs sed -i -e 's/CT_CC_LANG_CXX=y/CT_CC_LANG_CXX=n/'
git grep -l CT_DEBUG_GDB configs/ | xargs sed -i -e 's/CT_DEBUG_GDB=y/CT_DEBUG_GDB=n/'
git grep -l CT_MULTILIB configs/ | xargs sed -i -e 's/CT_MULTILIB=y/CT_MULTILIB=n/'

