# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit cmake-utils bash-completion-r1

MY_P="ldc-${PV}-src"
SRC_URI="http://d32gngvpvl2pi1.cloudfront.net/${MY_P}.tar.gz -> ${P}.tar.gz"
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
	${RDEPEND}"

src_prepare() {
	EPATCH_OPTS="-p1"
	epatch "${FILESDIR}/ldc2-${PV}-ppc64-druntime.patch"
	epatch "${FILESDIR}/ldc2-${PV}-ppc64-phobos.patch"
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

	rm -rf "${ED}"/etc/bash_completion.d
	newbashcomp "bash_completion.d/ldc" ${PN}
}
