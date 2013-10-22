# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit cmake-utils

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://ldc-developers.github.com/ldc"
MY_P="${P/ldc2/ldc}-src"
SRC_URI="https://github.com/downloads/ldc-developers/ldc/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm x86 amd64 ~ppc ~sparc"
IUSE=""

RDEPEND=">=sys-devel/llvm-3.0
         >=dev-libs/libconfig-1.4.7"
DEPEND=">=dev-util/cmake-2.8
        ${RDEPEND}"

src_prepare() {
	EPATCH_OPTS="-p1"
	epatch "${FILESDIR}/${P}-Workaround-for-AA-literal-initialization-ICE.patch"
	epatch "${FILESDIR}/${P}-Fix-ICE-with-closures-in-member-functions.patch"
	epatch "${FILESDIR}/${P}-Fix-handling-of-NewExpression-for-structs-with-const.patch"
	epatch "${FILESDIR}/${P}-Workaround-for-ICE-due-to-auto-return-type-not-being.patch"
}

src_configure() {
	local mycmakeargs=(
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
