# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

MY_P="OpenCSG-${PV}"
DESCRIPTION="The Constructive Solid Geometry rendering library"
HOMEPAGE="http://www.opencsg.org"
SRC_URI="http://www.opencsg.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/glew:0="
DEPEND="${RDEPEND}
	dev-qt/qtcore:5
"

S="${WORKDIR}/${MY_P}/src"

src_prepare() {
	default

	# removes duplicated headers
	rm -r ../glew || die "failed to remove bundled glew"

	sed -i -e "s:^target.path.*:target.path = \$\$INSTALLDIR/$(get_libdir):" \
		src.pro \
		|| die 'failed to fix target.path in src.pro'
}

src_configure() {
	eqmake5 src.pro INSTALLDIR="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
