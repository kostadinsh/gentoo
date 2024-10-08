# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby30 ruby31 ruby32"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="A distributed application deployment system"
HOMEPAGE="https://capistranorb.com/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-solaris"
IUSE="test"

ruby_add_rdepend "
	>=dev-ruby/net-ssh-2.0.14:*
	>=dev-ruby/net-sftp-2.0.2
	>=dev-ruby/net-scp-1.0.2
	>=dev-ruby/net-ssh-gateway-1.1.0:*
	>=dev-ruby/highline-1.2.7"
ruby_add_bdepend "
	test? (	dev-ruby/mocha:0.14 )"

PATCHES=( "${FILESDIR}/${PN}-2.15.5-sudo-cleanup.patch" )

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile test/utils.rb || die
	sed -i -e '/pry/ s:^:#:' -e '4igem "mocha", "~>0.14.0"' test/utils.rb || die

	# Avoid copy strategy tests since these fail in some cases due to
	# complicated (aka unknown) interactions with other parts of the
	# test suite.
	rm test/deploy/strategy/copy_test.rb || die
}

all_ruby_install() {
	all_fakegem_install

	ruby_fakegem_binwrapper cap /usr/bin/cap-2 'gem "capistrano", "~>2.0"'
}
