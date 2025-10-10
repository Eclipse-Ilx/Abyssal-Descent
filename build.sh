#!/bin/sh

REPO=$(pwd)
VERSION=$(echo "dev-1.0-$(git rev-parse --short HEAD)")

# eventually split these mods into their separate repos with versions we can pull from github
function build_java() {
	mkdir -p "$1/mods"
	for mod in $(ls "$REPO/src"); do
		echo "Building $mod.."
		cd "$REPO/src/$mod" && 
		sed -e 's/\r//' gradlew | sh -s build --quiet || exit 1
		mv build/libs/*.jar "$REPO/$1/mods"
		cd "$REPO"
	done
}

function package() {
	echo "Packaging ver $VERSION.."
	# lil hack but idk zip lol
	cd "$REPO/build"
	zip -r "../Abyssal-Descent-$VERSION.zip" * > /dev/null || exit 1
	cd "$REPO"
}

function clean() {
	echo "Cleaning build dir.."
	rm -r build
}


case $1 in
	"curse")
		clean
		build_java build/overrides
		cp -r overrides/* build/overrides
		awk -v "mode=curse" -f parse-mods.awk mods.csv > build/manifest.json || exit 1
		package
		clean
		;;
	"export")
		clean
		build_java build
		cp -r overrides/* build
		awk -v "mode=install" -v "out_dir=build/mods" -f parse-mods.awk mods.csv || exit 1
		package
		clean
		;;
	"export-no-pack")
		clean
		build_java build
		cp -r overrides/* build
		awk -v "mode=install" -v "out_dir=build/mods" -f parse-mods.awk mods.csv || exit 1
		;;
	"package")
		echo "$VERSION" > build/release.txt
		package
		;;
	*)
		echo -e "\x1b[1mOptions:\x1b[0m"
		echo "   curse           Export the modpack for CurseForge"
		echo "   export          Export the modpack for manual installation"
		echo
		echo -e "\x1b[1mDev Options:\x1b[0m (prob not needed for normal use)"
		echo "   export-no-pack  Export the modpack without zipping it"
		echo "   package         Package from build directory"
		;;
esac
