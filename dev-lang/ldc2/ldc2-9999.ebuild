# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit cmake-utils git-2

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://ldc-developers.github.com/ldc"

EGIT_REPO_URI="git://github.com/ldc-developers/ldc.git"
EGIT_HAS_SUBMODULES="true"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64 ~ppc ~sparc"
IUSE=""

RDEPEND=">=sys-devel/llvm-3.0
         >=dev-libs/libconfig-1.4.7"
DEPEND=">=dev-util/cmake-2.8
        ${RDEPEND}"

src_configure() {
	cd "${S}"
	cmake-utils_src_configure -DD_VERSION=2 -DCMAKE_INSTALL_PREFIX="/usr" -DINCLUDE_INSTALL_DIR=/usr/include/ldc2 -DLIB_SUFFIX=64 ./
}

src_compile() {
	cd "${S}"
	cmake-utils_src_make
}

src_install() {
	cd "${S}"
        cmake-utils_src_install DESTDIR="${D}"
}
