# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit cmake-utils bash-completion-r1 versionator

MY_PV=$(replace_version_separator '_' '-')
MY_P="ldc-${MY_PV}-src"
SRC_URI="https://github.com/ldc-developers/ldc/releases/download/v${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${MY_P}

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://ldc-developers.github.com/ldc"
KEYWORDS="x86 amd64 ~ppc64"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=sys-devel/llvm-3.1-r2
	>=dev-libs/libconfig-1.4.7"
DEPEND=">=dev-util/cmake-2.8
	!=dev-util/cmake-2.8.12
	${RDEPEND}"

src_prepare() {
	EPATCH_OPTS="-p1"
	epatch "${FILESDIR}/ldc2-$(version_format_string '$1.$2.$3')-issue703.patch"
	epatch "${FILESDIR}/ldc2-$(version_format_string '$1.$2.$3')-ctpop.patch"
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

	rm -rf "${ED}"/usr/share/bash-completion
	newbashcomp "bash_completion.d/ldc" ${PN}
}
