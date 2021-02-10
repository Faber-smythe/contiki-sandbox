#!/bin/sh
echo "================================"
if ls contiki; then
	echo "/!\ There can't already be a folder named 'contiki' in reception folder. Aborting."
	echo "================================"1>&2
	exit 1
fi

if unzip contiki.zip; then
	read -p "Unzipping was successful. Do you want to patch contiki ? [YES/no]" patch_answer
	case $patch_answer in
		no|NO|N|n|No)
			echo "================================"
			read -p "Skipped patch. Do you want to compile after installation ?" compilechoice;;
		*)
			cd contiki
			
			if patch -p1 < ../patch.diff; then
				echo "================================"
				read -p "Contiki was successfuly patched. Do you want to compile after installlation ? [YES/no]" compilechoice
			fi
		;;
			
	esac
	cp -r "../src/myapps" "apps/myapps"
	cp -r "../src/myproject" "examples/myproject"
	case $compilechoice in
		no|NO|N|n|No)
			cd "examples/myproject"
			echo "================================"
			echo -p "Installation was succesful. Compile when you like using 'make' in 'contiki/examples/myproject/' then run executable with './myproject.native'" ;;
		*)
			cd "examples/myproject"
			
			if make; then
				echo "================================"
				echo "Installation was sucessful. Run executable when you like 'contiki/examples/myproject/myproject.native'"
			fi
		;;
	esac
fi
