# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_VERSION=1.16
DIST_AUTHOR=PLICEASE
inherit perl-module

DESCRIPTION="Alien package for the GNU Multiple Precision library"

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~mips ppc x86"

RDEPEND="
	>=dev-perl/Alien-Build-1.460.0
"
BDEPEND="${RDEPEND}
	>=dev-perl/Alien-Build-0.320.0
	dev-perl/Devel-CheckLib
	virtual/perl-ExtUtils-CBuilder
	>=virtual/perl-ExtUtils-MakeMaker-6.520.0
	test? (
		>=virtual/perl-Test2-Suite-0.0.60
	)
"
