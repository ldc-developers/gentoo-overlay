# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit cmake-utils git-2

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://ldc-developers.github.com/ldc"

EGIT_REPO_URI="git://github.com/ldc-developers/ldc.git"
EGIT_HAS_SUBMODULES="true"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64 ~ppc ~sparc"
IUSE=""

RDEPEND=">=sys-devel/llvm-3.1
         >=dev-libs/libconfig-1.4.7"
DEPEND=">=dev-util/cmake-2.8
        ${RDEPEND}"

src_configure() {
        mycmakeargs=(
            -DD_VERSION=2
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
