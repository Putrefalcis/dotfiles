EAPI=5
inherit eutils gnome2-utils fdo-mime pax-utils unpacker

DESCRIPTION="Spotify beta is a proprietary music streaming platform"
HOMEPAGE="https://www.spotify.com/download/previews/"
MY_PN="spotify"
MY_P="${MY_PN}-client_${PV}"
SRC_BASE="http://download.spotify.com/beta/"
SRC_URI="${SRC_BASE}${MY_PN}-client_${PV}_amd64.deb"
LICENSE="Spotify"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pulseaudio"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}
		>=media-libs/alsa-lib-1.0.14
		dev-libs/glib:2
		|| ( dev-libs/libgcrypt:11/11 dev-libs/libgcrypt:0/11 )
		x11-libs/libXScrnSaver
		gnome-base/gconf:2
		x11-libs/gtk+:2
		>=dev-libs/nspr-4.9
		dev-libs/nss
		sys-apps/dbus[X]
		pulseaudio? ( >=media-sound/pulseaudio-0.9.21 )"

S=${WORKDIR}

QA_PREBUILT="/opt/spotify/spotify-beta/Spotify
			/opt/spotify/libcef.so
			/opt/spotify/libffmpegsumo.so"

src_install() {
	dodoc usr/share/doc/spotify-client/changelog.Debian.gz

	SPOTIFY_HOME=/opt/spotify/spotify-beta
	insinto ${SPOTIFY_HOME}
	doins -r usr/share/spotify/*
	fperms +x ${SPOTIFY_HOME}/Spotify

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/spotify-beta
		#! /bin/sh
		exec ${SPOTIFY_HOME}/Spotify "\$@"
	EOF
	fperms +x /usr/bin/spotify-beta

	for size in 16 22 24 32 48 64 128 256; do
			newicon -s ${size} "${FILESDIR}/icons/spotify-linux-${size}.png" \
						"spotify-beta.png"
							done

	make_desktop_entry spotify-beta "Spotify Beta"
	domenu "${S}${SPOTIFY_HOME}/spotify-beta.desktop"
}

pkg_preinst() {
	gnome2_icon_savelist
	}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
