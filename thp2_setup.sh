#!/bin/bash
clear

echo "--> Welcome to the CyberIQCrew Kali 2017.1 Supplementary Software Installer."
echo "--> Developed by: Andy B"
echo "--> For support: tecknoh19@gmail.com"
echo ""
sleep 2
echo "--> Determining architecture type."

if [ `getconf LONG_BIT` = "64" ]; then
    MACHINE_TYPE=64
else
    MACHINE_TYPE=32
fi

echo "--> $MACHINE_TYPE architecture dedected.  Continuing."

echo
echo "--> Attempting system update."
	apt-get update
	if [ $? -eq 0 ]; then
		echo "--> Update complete.  Checking for available upgrades."
	else
		echo "--> Could not complete system update. Exiting."
		exit
	fi

echo
echo "--> Checking/Applying upgrades"
	apt-get -y dist-upgrade
	if [ $? -eq 0 ]; then
		echo "--> Upgrade complete."
	else
		echo "--> Could not perform update.  Exiting to prevent installation errors.  "
		echo "--> Possible scenarios are no internet connection, apt being locked by another process (like software center), or an incomplete / damaged previous install of an application."
		exit
	fi

echo
echo "--> Setting up Metasploit database"
	service postgresql start
	echo "--> Metasploit database initialized.  Enabling database startup at boot."
	update-rc.d postgresql enable
	if [ $? -eq 0 ]; then
		echo "--> Database enabled at startup.  Creating database.yml file."
		service metasploit start
		service metasploit stop
	fi
	

echo
echo "--> Installing supplemental software from kali repositories."
	echo "Installing gEdit."
	apt-get -y install gedit

	echo "--> Installing Terminator."
	apt-get -y install Terminator

	echo "--> Installing git."
	apt-get -y install git

	echo "--> Installing dev and compilation tools."
	apt-get -y install gcc make libpcap-dev build-essential libssl-dev libffi-dev python-dev

	echo "--> Installing python elixir."
	apt-get -y install python-elixir

	echo "--> Installing additonal dependenices."
	apt-get -y install ldap-utils rwho rsh-client x11-apps finger

	echo "--> Supplemental software installation from kali repositories complete."


echo
echo "--> Preparing for download and installation of additonal tools from GitHub and BitBucket."
echo "--> Additional software will be downloaded and installed to /opt/"

	echo "--> downloading The Backdoor Factory."
		git clone https://github.com/secretsquirrel/the-backdoor-factory /opt/the-backdoor-factory
		if [ $? -eq 0 ]; then
			echo "--> download successful. Installing."
			cd /opt/the-backdoor-factory
			./install.sh
			echo "--> successfully installed The Backdoor Factory."
		else
			echo "--> Could not download The Backdoor Factory.  Skipping installation."
		fi

	echo "--> downloading HTTPScreenShot."
		echo "--> Installing prerequisite: selenium."
		pip install selenium
		if [ $? -eq 0 ]; then
			echo "--> succesfully installed selenium."
			git clone https://github.com/breenmachine/httpscreenshot.git /opt/httpscreenshot
			cd /opt/httpscreenshot
			chmod +x install-dependencies.sh
			./install-dependencies.sh

			if [ $MACHINE_TYPE -eq 32 ]; then
				echo "--> 32 bit architecture dedected."  
				echo "--> Installing additional dependenices for 32 bit support."
				cd /opt/httpscreenshot
				echo "--> downloading phantomjs."
				wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-i686.tar.bz2
				if [ $? -eq 0 ]; then
					echo "--> installing phantomjs"
					bzip2 -d phantomjs-1.9.8-linux-i686.tar.bz2
					tar xvf phantomjs-1.9.8-linux-i686.tar
					cp phantomjs-1.9.8-linux-i686/bin/phantomjs /usr/bin/
				else
					echo "-->  failed to install HTTPScreenShot 32 bit dependenices."
					echo "--> skipping."
				fi

			else
				echo "--> successfully installed HHTPScreenShot."
			fi

		else
			echo "--> could not install selenium.  Skipping HTTPScreenShot."
		fi


	echo
	echo "--> downloading Masscan."
		git clone https://github.com/robertdavidgraham/masscan.git /opt/masscan
		if [ $? -eq 0 ]; then
			cd /opt/masscan
			make
			make install
			if [ $? -eq 0 ]; then
				echo "--> successfully installed Masscan."
			else
				echo "--> failed to install Masscan.  Skipping."
			fi	
		else
			echo "--> could not download Masscan.  Skipping."
		fi

	echo
	echo "--> downloading CMSmap."
		git clone https://github.com/Dionach/CMSmap /opt/CMSmap
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded CMSmap."
			echo "--> no installation required.  CMSmap is an executable script."
		else
			echo "--> failed to download CMSmap. Skipping."
		fi

	echo "--> downloading WPScan (Wordpress Vuln Scanner)."
		git clone https://github.com/wpscanteam/wpscan.git /opt/wpscan
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded WPScan."
			cd /opt/wpscan
			echo "--> updating WPScan."
			./wpscan.rb --update
			if [ $? -eq 0 ]; then
				echo "--> WPScan successfully updated."
			else
				echo "--> WPScan is installed but failed to update."
				echo "--> You can attempt a manual update later."
			fi

		else
			echo "--> failed to download WPScan. Skipping."
		fi

	echo
	echo "--> downloading Eyewitness (screenshots of websites, server headers, find default creds)."
		git clone https://github.com/ChrisTruncer/EyeWitness.git /opt/EyeWitness
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Eyewitness."
			echo "--> no installation required.  Eyewitness is an executable script."
		else
			echo "--> failed to download Eyewitness. Skipping."
		fi

	echo
	echo "--> downloading praedasploit (Printer Exploits)."
		git clone https://github.com/MooseDojo/praedasploit /opt/praedasploit
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded praedasploit."
			echo "--> no installation required.  praedasploit is an executable script."
		else
			echo "--> failed to download praedasploit. Skipping."
		fi

	echo
	echo "--> downloading SQLMap (SQL Injection Tool)."
		git clone https://github.com/sqlmapproject/sqlmap /opt/sqlmap
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded SQLMap."
			echo "--> no installation required.  SQLMap is an executable script."
		else
			echo "--> failed to download  SQLMap. Skipping."
		fi

	echo
	echo "--> downloading Recon-ng (Python web reconnaissance framework)."
		git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Recon-ng."
			echo "--> no installation required.  Recon-ng is an executable script."
		else
			echo "--> failed to download Recon-ng. Skipping."
		fi

	echo
	echo "--> downloading Discover Scripts (Custom bash scripts used to automate various pentesting tasks)."
		git clone https://github.com/leebaird/discover.git /opt/discover
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Discover Scripts."
			echo "--> running Discover Scripts updater."
			cd /opt/discover
			./update.sh
			if [ $? -eq 0 ]; then
				echo "--> Discover Scripts successfully updated."
			else
				echo "--> Discover Scripts is installed but failed to update."
				echo "--> You can attempt a manual update later."
			fi
		else
			echo "--> failed to download Discover Scripts. Skipping."
		fi

	echo
	echo "--> downloading BeEF Exploitation Framework (cross-site scripting attack framework)."
		cd /opt/
		wget https://raw.github.com/beefproject/beef/a6a7536e/install-beef
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded BeEF Exploitation Framework."
			echo "--> proceeding with installation."
			chmod +x install-beef
			./install-beef
			if [ $? -eq 0 ]; then
				echo "--> BeEF Exploitation Framework successfully installed."
			else
				echo "--> Failed to install BeEF Exploitation Framework. Skipping."
			fi
		else
			echo "--> failed to download BeEF Exploitation Framework. Skipping."
		fi

	echo
	echo "--> downloading Responder (A LLMNR, NBT-NS and MDNS poisoner)"
		git clone https://github.com/SpiderLabs/Responder.git /opt/Responder
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Responder."
			echo "--> no installation required.  Responder is an executable script."
		else
			echo "--> failed to download Responder. Skipping."
		fi







	echo
	echo "--> downloading custom scripts from The Hacker Playbook 2, aka THP2."
		
		echo "--> downloading Easy-P (Powershell Tool by Peter Kim, authoer of THP2)."
		git clone https://github.com/cheetz/Easy-P.git /opt/Easy-P
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Easy-P."
			echo "--> no installation required.  Easy-P is an executable script,"
		else
			echo "--> failed to download Easy-P. Skipping."
		fi

		echo "--> downloading Password Plus One."
		ggit clone https://github.com/cheetz/Password_Plus_One /opt/Password_Plus_One
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Password Plus One."
			echo "--> no installation required.  Password Plus One is an executable script."
		else
			echo "--> failed to download Password Plus One. Skipping."
		fi

		echo "--> downloading Powershell Popup."
		git clone https://github.com/cheetz/PowerShell_Popup /opt/PowerShell_Popup
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Powershell Popup."
			echo "--> no installation required.  Powershell Popup is an executable script."
		else
			echo "--> failed to download Powershell Popup. Skipping."
		fi

		echo --> downloading icmpshock
		git clone https://github.com/cheetz/icmpshock /opt/icmpshock
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded icmpshock."
			echo "--> no installation required.  icmpshock is an executable script."
		else
			echo "--> failed to download Eicmpshock. Skipping."
		fi

		echo "--> downloading brutescrape."
		git clone https://github.com/cheetz/brutescrape /opt/brutescrape
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded brutescrape."
			echo "--> no installation required.  brutescrape is an executable script."
		else
			echo "--> failed to download brutescrape. Skipping."
		fi

		echo "--> downloading Reddit XSS."
		git clone https://www.github.com/cheetz/reddit_xss /opt/reddit_xss
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Reddit XSS."
			echo "--> no installation required.  Reddit XSS is an executable script."
		else
			echo "--> failed to download Reddit XSS. Skipping."
		fi

		echo "--> installation of THP2 custom scripts complete."

	echo
	echo "--> downloading THP2 forked version software (Special versions of PowerSploit and Powertools used in THP2)."

		echo "--> downloading HP PowerSploit."
		git clone https://github.com/cheetz/PowerSploit /opt/HP_PowerSploit
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded HP PowerSploit."
			echo "--> no installation required.  HP PowerSploit is an executable script."
		else
			echo "--> failed to download HP PowerSploit. Skipping."
		fi

		echo "--> downloading HP PowerTools."
		git clone https://github.com/cheetz/PowerTools /opt/HP_PowerTools
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded HP PowerTools."
			echo "--> no installation required.  HP PowerTools is an executable script."
		else
			echo "--> failed to download HP PowerTools. Skipping."
		fi

		echo "--> downloading nishang."
			git clone https://github.com/cheetz/nishang /opt/nishang
			if [ $? -eq 0 ]; then
				echo "--> successfully downloaded nishang."
				echo "--> no installation required.  nishang is an executable script."
			else
				echo "--> failed to download nishang. Skipping."
			fi

		echo "--> downloading THP2 forked version software complete."

	echo
	echo "--> downloading SPARTA (scanning and enumeration tool)."
		git clone https://github.com/secforce/sparta.git /opt/sparta
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded SPARTA."
			echo "--> prerequisites already installed."
			echo "--> no installation required.  SPARTA is an executable script."
		else
			echo "--> failed to download SPARTA. Skipping."
		fi

	echo	
	echo "--> downloading NoSQLMap."
		git clone https://github.com/tcstool/NoSQLMap.git /opt/NoSQLMap
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded NoSQLMap."
			echo "--> no installation required.  NoSQLMap is an executable script."
		else
			echo "--> failed to download NoSQLMap. Skipping."
		fi

	echo
	echo "--> downloading Spiderfoot."
		mkdir /opt/spiderfoot/
		cd /opt/spiderfoot
		wget http://sourceforge.net/projects/spiderfoot/files/spiderfoot-2.3.0-src.tar.gz/download
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Spiderfoot."
			tar xzvf download
			if [ $? -eq 0 ]; then
				echo "--> archive extracted."
				echo "--> installing required python modules."
				pip install lxml
				pip install netaddr
				pip install M2Crypto
				pip install cherrypy
				pip install mako
				echo "--> successfully installed Spiderfoot."
			else
				echo "--> could not extract archive.  Skipping."
			fi
		else
			echo "--> failed to download Spiderfoot. Skipping."
		fi

	echo	
	echo "--> downloading WCE."
		mkdir /opt/wce
		cd /opt/wce
		echo "--> determining which file to download based on architecture."
		if [ $MACHINE_TYPE -eq 32 ]; then
			echo "--> downloading 32bit version."
			wget http://www.ampliasecurity.com/research/wce_v1_42beta_x32.zip
		else
			echo "--> downloading 64bit version."
			wget http://www.ampliasecurity.com/research/wce_v1_42beta_x64.zip
		fi

		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded WCE. Installing."
			unzip wce_v1* -d /opt/wce
			if [ $? -eq 0 ]; then
				echo "--> successfully installed WCE."
				echo "--> cleaing up."
				rm wce_v1*.zip
			else
				echo "--> failed to install WCE. Skipping."
			fi
		else
			echo "--> failed to download WCE. Skipping."
		fi

	echo	
	echo "--> downloading Mimikatz."
		mkdir /opt/mimikatz
		cd /opt/mimikatz
		wget https://github.com/gentilkiwi/mimikatz/releases/download/2.1.1-20170409/mimikatz_trunk.zip
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Mimikatz. Installing."
			unzip -d ./mimikatz mimikatz_trunk.zip
			echo "--> successfully installed mimikatz."
		else
			echo "--> failed to download Mimikatz. Skipping."
		fi

	echo	
	echo "--> downloading SET (Social Engineering Toolkit)."
		git clone https://github.com/trustedsec/social-engineer-toolkit/ /opt/set/
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded SET. Installing."
			cd /opt/set
			./setup.py install
			if [ $? -eq 0 ]; then
				echo "--> successfully installed SET."
			else 
				echo "--> installation of SET has failed.  Skipping."
			fi
		else
			echo "--> failed to download SET. Skipping."
		fi

	echo
	echo "--> downloading PowerSpoit (Powershell Exploitation)."
		git clone https://github.com/mattifestation/PowerSploit.git /opt/PowerSploit
		if [ $? -eq 0 ]; then
				echo "--> successfully downloaded PowerSploit. Installing."
				cd /opt/PowerSploit
				wget https://raw.githubusercontent.com/obscuresec/random/master/StartListener.py
				if [ $? -eq 0 ]; then
					wget https://raw.githubusercontent.com/darkoperator/powershell_scripts/master/ps_encoder.py
					if [ $? -eq 0 ]; then
						echo "--> PowerSploit has been successfully installed."
					else
						echo "--> failed to install ps_encoder.  Skipping PowerSpoit. "
					fi
				else
					echo "--> could not downlod StartListener.  Skipping PowerSpoit."
				fi
			else 
				echo "--> download of PowerSploit has failed.  Skipping."
			fi

	echo	
	echo "--> downloading Nishang. "
		git clone https://github.com/samratashok/nishang /opt/nishang
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Nishang. "
			echo "--> no installation required.  Nishang is an executable script."
		else
			echo "--> failed to download Nishang. Skipping."
		fi

	echo	
	echo "--> downloading Veil-Framework (A red team toolkit focused on evading detection). "
		git clone https://github.com/Veil-Framework/Veil /opt/Veil
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Veil-Framework. Installing."
			cd /opt/Veil/
			./Install.sh -c
			if [ $? -eq 0 ]; then
				echo "--> successfully installed Veil-Framework."
			else
				echo "--> failed to install Veil-Framework.  Skipping."
			fi
		else
			echo "--> failed to download Nishang. Skipping."
		fi


	echo	
	echo "--> downloading Net-Creds Network Parsing (Parse PCAP files for username/passwords)." 
		git clone https://github.com/DanMcInerney/net-creds.git /opt/net-creds
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Net-Creds. "
			echo "--> no installation required.  Net-Creds is an executable script."
		else
			echo "--> failed to download Net-Creds. Skipping."
		fi

	echo	
	echo "--> downloading Wifite (Attacks against WiFi networks). "
		git clone https://github.com/derv82/wifite /opt/wifite
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded Wifite. "
			echo "--> no installation required.  Wifite is an executable script."
		else
			echo "--> failed to download Wifite. Skipping."
		fi

	echo	
	echo "--> downloading WIFIPhisher (Automated phishing attacks against WiFi networks)." 
		git clone https://github.com/sophron/wifiphisher.git /opt/wifiphisher
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded WIFIPhisher. "
			echo "--> no installation required.  WIFIPhisher is an executable script."
					else
			echo "--> failed to download WIFIPhisher. Skipping."
		fi

	echo
	echo "--> ==========================================================================="
	echo
	echo "--> installation of supporting software is complete."
	echo "--> downloading THP2 recommending Burp Suite fuzzing list (danielmiessler/SecLists)."
		git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists
		if [ $? -eq 0 ]; then
			echo "--> successfully downloaded danielmiessler/SecLists." 
		else
			echo "--> failed to download danielmiessler/SecLists. Skipping."
		fi

	echo
	echo "--> Installing the Neo4J requirement from the above Discover installation.  You will not need to install manually."
		wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
		echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
		apt-get update
		apt-get -y install neo4j
		echo "--> Neo4J was successfully installed."
		echo "--> Your Kali 2017.1 installation is now ready to use!"
		echo "--> If you are blessed enough to have the means, Bitcoin tips are accepted.  1QBwwtS7xuGnpK4WbW7x8yfU7EKeX93A7a"


