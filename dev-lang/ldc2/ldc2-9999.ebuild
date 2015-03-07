# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit cmake-utils bash-completion-r1 git-2

EGIT_REPO_URI="git://github.com/ldc-developers/ldc.git"
EGIT_HAS_SUBMODULES="true"

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://ldc-developers.github.com/ldc"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=sys-devel/llvm-3.1-r2
	>=dev-libs/libconfig-1.4.7"
DEPEND=">=dev-util/cmake-2.8
	${RDEPEND}"

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

	[[ -d "${ED}"/usr/share/bash-completion ]] && rm -rf "${ED}"/usr/share/bash-completion
	[[ -d "${ED}"/etc/bash_completion.d ]] && rm -rf "${ED}"/etc/bash_completion.d
	newbashcomp "bash_completion.d/ldc2" ${PN}
}
