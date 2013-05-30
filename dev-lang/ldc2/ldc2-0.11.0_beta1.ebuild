# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit cmake-utils

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://ldc-developers.github.com/ldc"
MY_P="${PN/ldc2/ldc}-${PVR/_/-}-src"
SRC_URI="http://d32gngvpvl2pi1.cloudfront.net/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm x86 amd64 ~ppc ~sparc"
IUSE=""

RDEPEND=">=sys-devel/llvm-3.1-r2
         >=dev-libs/libconfig-1.4.7"
DEPEND=">=dev-util/cmake-2.8
        ${RDEPEND}"

src_configure() {
	local mycmakeargs=(
            -DINCLUDE_INSTALL_DIR=/usr/include/ldc2
        )
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_make
}

src_install() {
        cmake-utils_src_install
}
