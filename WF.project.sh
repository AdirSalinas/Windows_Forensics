#!/bin/bash

								#####################################################################################################################################
								# Script Name: wf.project.sh																										#
								# Description: This project involved the creation of a comprehensive program for digital forensic analysis. Focused on automated	#
								#			   hard disk drive (HDD) and memory investigations, it was designed to identify, extract, and display crucial data 		#
								#			   elements like network traffic or human-readable information. Additionally, the program integrates with the			#
								#			   Volatility software for in-depth memory analysis and outputs detailed reports. It also features a dedicated function	#
								#			   to install necessary forensic tools, ensuring smooth operation.														#
								#																																	#
								# Author: Adir Salinas (code S18)																									#
								# Date:  28/02/2024																					   			                    #
								# Class code: 7736																				                     				#
								# Lecturer: Natali Erez																												#
								#####################################################################################################################################


# Functions names and short description:
# --------------------------------------
#  1) Function for the start of the script include displaying a few details and outlining the purpose of the script: START
#  2) Function that check the needed Forensics tools and in case they are not installed, installing them : APPSCHK
#  3) Functions for installing the forensics tools: BULK, SCALPEL, BINWALK, FOREMOST, geoiplookup, STRINGS, EXIFTOOL
#  4) Functions to check if the forensics tools is installed: BULKINFO, SCALPELINFO, BINWALKINFO,FOREMOSTINFO, STRINGSINFO, GEOIPINFO, EXIFINFO
#  5) Function to analyzed the file with different carvers while creating directories and files that storing the data: ANALYZE
#  6) Function that analyzed the file using the forensics tools and different carvers while creating directories and files that storing the data: BulkAnalysis, BinwalkAnalysis, Foremost, Exiftool
#  7) Function that using the Strings command to extract information from a file, using different patterns and keywords and then organizes and inserts the results into directories and files: STRINGS
#  8) Functions inside that STRINGS function that using the strings command and extract information from a file,using different patterns and keywords: emails, IPAddr, MACAddr, FileExt, Security,Credentials, URLS, UserWords.
#  9) Function to check all created files for the presence of ".pcap" files: pcapsearch
# 10) Function for volatility analysis to extract information from a file, using volatility command and then organizes and inserts the results into directories and files: VOL
# 11) Function to remove the existing Volatility files, if they exist, and install Volatility to ensure proper execution of the commands: VOLINSTL
# 12) Function that analysis the file using volatility command while using different keywords: VOLAnalysis, imageinfo, pslist, netscan, dlllist, filescan
# 13) Function that will Check Whether the Provided File Is Compatible for Analysis with Volatility: VOLCHK
# 14) Function that use the volatility to scan for Registry Files information within the file while using different keywords: RegFiles ,SYSTEM, SOFTWARE, SAM ,SECURITY
# 15) Function to ask the user for a file to analyzed , verifying its existence, and if the file exists, calling the function that analyzes the file: FILE
# 16) Function to ask the user for a Directory to analyzed , verifying its existence, and if the file exists, calling the function that analyzes the Directory: DIRECTORY
# 17) Function that will ask the user Whether he want to Analyze A Single File Or A Directory Of Files and then calling the needed functions to continue: CHOICE
# 18) Function to initiates the compression process to create a zip archive of the analysis data: ZIP
# 19) Function for the end of the script that shows a diagram about the locations of all directories and files that was created are stored at: END


# Descriptions About A Few Commands In The Script:
# ------------------------------------------------ 
# "echo" - Making space between commands or displaying text on screen.
# "clear" - clearing the output terminal screen.
# "sleep" - this command used to introduce a delay or pause in the script for a certain period of time.
# "cd" - Short for "change directory," is used in the script and allows you to navigate between directories and move to a different location.
# "grep" - searching for word or sentence inside an output and display them on screen.
# "awk" - have a lot of used most of them in the script is to separate certain words or location.
# "read" - read command reads the user's input and assigns it to the variable, using the flag (-p) after the command for printing text on screen before the input. 
# “sudo” - command is used to execute commands with elevated privileges. and it allows a permitted user to execute a command as the superuser.
# "date" - command displays the current date and time on the system.
# "sudo apt-get install -qq -y" - command to install diffrent packages or applications, The -qq flag suppresses most output, and the -y flag automatically confirms any prompts, allowing for automated installation .
# "> /dev/null 2>&1" - this command used in addition to another command to executed it quietly without displaying any output or errors.


bold=$(tput bold) # sets the variable "bold" to the escape sequence for bold text formatting using the tput terminal utility.-> when using in the the script on text the text will be Bold 
normal=$(tput sgr0) # sets the variable "normal" to the escape sequence that resets text formatting to the default, undoing any previous formatting changes.-> when using in the the script on text the text will be back into normal mode 
green=$(tput setaf 2) # sets the variable "green" to the escape sequence for changing text color to green using the "tput" terminal utility.-> when using in the the script on text the text will be Green color 
blue=$(tput setaf 4) # sets the variable "blue" to the escape sequence for changing text color to blue using the "tput" terminal utility.-> when using in the the script on text the text will be Blue color 
red=$(tput setaf 1) # sets the variable "red" to the escape sequence for changing text color to red using the "tput" terminal utility.-> when using in the the script on text the text will be red color. 
purple=$(tput setaf 5) # sets the variable "purple" to the escape sequence for changing text color to purple using the "tput" terminal utility.-> when using in the the script on text the text will be purple color.

clear
echo
echo "[!] Before We Start, Please Insert Your Password:"
echo
sleep 2
sudo -kv # updates the user's cached credentials, asking for the user's password again if necessary, but without running any command-> Used within a script to ensures that previously entered sudo passwords won't be prompted again for subsequent sudo commands.
sudo apt-get install -y figlet > /dev/null 2>&1 # command to install the 'figlet' package, that generates ASCII art text banners using various font styles.
sudo apt-get install -y lolcat > /dev/null 2>&1 # command to install the 'lolcat' package, which adds rainbow coloring to text output in the terminal, enhancing visual aesthetics.

function START () # Function for the start of the script and display short description about the purpose of the script and few details. 
{
	clear
	echo
	echo
	figlet -t -c -f slant Welcome To My Digital Forensic 	Analysis Tool ! |lolcat # This command convert text to ascii(more artistic way),"-t" for expanding to the entire screen,"-c" for centering the text, and "-f" for specify which font to use in this case its "slant font".
	sleep 3
	echo
	echo
	echo
	echo "${bold}                        This Program Automates Precise Analysis of Hard Disk Drives and Memory Files, Minimizing the Risk of Oversights During Manual Investigations. ${normal}"	
	sleep 6.5
	echo
	echo
	echo "${bold}                                                    Extract Crucial Data, Including Network Traffic and Human-Readable Information.  ${normal}"
	sleep 4
	echo
	echo
	echo "${bold}                                            Combining Investigation with Volatility for In-Depth Hard Disk Drives or Memory Files Analysis.     ${normal}"
	sleep 5
	echo
	echo
	echo "${bold}                                              While Ensuring Efficiency by Installing Essential Forensic Tools with a Dedicated Function.   ${normal}"
	sleep 4
	echo
	echo 
	echo
	echo "${bold}                                                                          Now let's Begin With The Analysis...   ${normal}"
	sleep 1.5
	echo "                                                                              (Press any key to continue)"
	read -n 1 -s -r # The command reads a single character from the user without displaying it to the terminal, and continue with the rest of the script when character has been typed.

}
START

function APPSCHK () # The following functions is for downloading the necessary forensic applications if they are not installed. 
{
	echo
	echo
	echo	
	echo
	echo
	echo "${bold}[?] Checking If The Necessary Forensics Tools Are Installed... ${normal}"
	echo
	
	function BULK () # Function to install the 'Bulk_extractor' package
	{
		sudo apt-get -qq -y install bulk-extractor > /dev/null 2>&1	
	}
	function SCALPEL () # Function to install the 'Scalpel' package
	{
		sudo apt-get -qq -y install scalpel > /dev/null 2>&1	
	}	
	function BINWALK () # Function to install the 'Binwalk' package
	{
		sudo apt-get -qq -y install binwalk > /dev/null 2>&1	
	}	
	
	function FOREMOST () # Function to install the 'Foremost' package
	{
		sudo apt-get -qq -y install foremost > /dev/null 2>&1	
	}	
		
	function geoiplookup () # Function to install the 'geoip-bin' package
	{
		sudo apt-get -qq -y install geoip-bin > /dev/null 2>&1	
	}		
	
	function STRINGS () # Function to install the 'Strings' package
	{
		sudo apt-get -qq -y install binutils > /dev/null 2>&1	
	}	
	
	function EXIFTOOL () # Function to install the 'Exiftool' package
	{
		sudo apt-get -qq -y install libimage-exiftool-perl > /dev/null 2>&1	
	}
	
	function BULKINFO () # Function to check if Bulk_extractor application is installed and if not calling the function that installed the package.
	{ 
		if command -v bulk_extractor > /dev/null 2>&1  #  if statment that check if the "bulk_extractor" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "Bulk_extractor" is not installed on their system, and calling the function the installed the package
		then
			return   # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Bulk_extractor" Is Not Installed On Your System.'
			echo
			sleep 1.5
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			BULK  # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	BULKINFO
	
	function SCALPELINFO () # Function to check if scalpel application is installed and if not calling the function that installed the package.
	{ 
		if command -v scalpel > /dev/null 2>&1  # if statment that check if the "scalpel" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "scalpel" is not installed on their system, and calling the function the installed the package
		then
			return  # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Scalpel" Is Not Installed On Your System.'
			echo
			sleep 1.5			
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			SCALPEL  # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	SCALPELINFO	
	
	function BINWALKINFO ()  # Function to check if binwalk application is installed and if not calling the function that installed the package.
	{ 
		if command -v binwalk > /dev/null 2>&1  # if statment that check if the "binwalk" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "binwalk" is not installed on their system, and calling the function the installed the package
		then
			return   # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Binwalk" Is Not Installed On Your System.'
			echo
			sleep 1.5			
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			BINWALK # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	BINWALKINFO	
	
	function FOREMOSTINFO ()  # Function to check if foremost application is installed and if not calling the function that installed the package.
	{ 
		if command -v foremost > /dev/null 2>&1  # if statment that check if the "binwalk" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "binwalk" is not installed on their system, and calling the function the installed the package
		then
			return   # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Foremost" Is Not Installed On Your System.'
			echo
			sleep 1.5			
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			FOREMOST # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	FOREMOSTINFO
	
	function STRINGSINFO ()  # Function to check if foremost application is installed and if not calling the function that installed the package.
	{ 
		if command -v strings > /dev/null 2>&1 # if statment that check if the "strings" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "strings" is not installed on their system, and calling the function the installed the package
		then
			return  # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Strings" Is Not Installed On Your System.'
			echo
			sleep 1.5			
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			STRINGS  # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	STRINGSINFO			
	
	function GEOIPINFO ()  # Function to check if geoiplookup application is installed and if not calling the function that installed the package.
	{ 
		if command -v geoiplookup > /dev/null 2>&1  # if statment that check if the "geoiplookup" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "geoiplookup" is not installed on their system, and calling the function the installed the package
		then
			return   # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Geoiplookup" Is Not Installed On Your System.'
			echo
			sleep 1.5			
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			geoiplookup  # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	GEOIPINFO
	
	function EXIFINFO () # Function to check if exiftool application is installed and if not calling the function that installed the package.
	{ 
		if command -v exiftool > /dev/null 2>&1  # if statment that check if the "exiftool" command is available in the system's PATH. if so, it continue to then statment and returns without taking any action, otherwise, it notifies the user that "exiftool" is not installed on their system, and calling the function the installed the package.
		then
			return  # command to return from the current function and continue to the rest of the script.
		else
			echo '[!] The Forensic Tool "Exiftool" Is Not Installed On Your System.'
			echo
			sleep 1.5			
			echo "[*] Advancing With The Installation Of The Forensic Tool."
			EXIFTOOL # Calling the function that installed the application.
			echo
			echo "${bold}[✓] Installation Completed Successfully.  ${normal}"
		fi
	}
	EXIFINFO
	
	sleep 3
	echo
	echo "[✓] All The Necessary Applications Have Been Checked, Prepared, and Installed as Required." 
	sleep 5	
	echo
	echo
}
APPSCHK

function ANALYZE ()  # Function to analyzed the file with different carvers while creating directories and files that storing the data.
{
	sleep 3.5
	clear
	echo
	echo
	echo "${bold}${blue}================================================(${green} Extracting Information And Conducting Forensic Analysis On Your Selection...${blue})===========================================${normal}"
	location=$(pwd) # captures the current working directory path using the "pwd" command and stores it in the variable named "location" 
	mkdir DataAnalysis  > /dev/null 2>&1  # creates a directory named "DataAnalysis"
	cd DataAnalysis  # Entering the new created directory Named "DataAnalysis".
	
	file_path="$1"  # The variable assignment sets the variable "file_path" to the value of the first command-line argument passed to the script or function. Means later the value that is going to be send is the user files that he wants to be analyzed.
    base_name=$(basename "$file_path")  # The command extracts the base name (filename without the directory path) of the file specified in the "file_path" variable and assigns it to the "base_name" variable. This is useful when you want to isolate the filename from its full path in case user input a path to the file.
    file_name="Data_$base_name"  # The command creates a new variable named "file_name" and assigns it a value composed of the string "Data_" followed by the base name extracted from the "base_name" variable.
	 
	mkdir "$file_name" && cd $file_name  # creating a directory using the variable "file_name" as the name of the directory and then entering the new created directory.
	
	function BulkAnalysis ()  # Function that using the Bulk_extractor command to extract data and information from a file, and then organizes and inserts the results into directories."
	{
		sleep 3
		echo
		echo
		echo	
		echo "                                                     ${bold} Extracting And Conducting Forensic Analysis Using Bulk_Extractor...${normal}  "
		cd $location/DataAnalysis/$file_name # changes the current location to a the locations under the vairables and names.
		mkdir Bulk_extractor  # inside the location make a directory named "Bulk_extractor"
		cd $location/DataAnalysis/$file_name/Bulk_extractor # changes the current location to a the locations under the vairables and names
		
		# making a file named "Data_Report" when using ">" and when using ">>" inserting text and data inside the file without overwriting the data inside the file.
		echo > Data_Report 
		echo "Analysis Audit" >> Data_Report
		echo >> Data_Report
		echo "Bulk_extractor Started At: $(date) " >> Data_Report
		time=$(date) # captures the current date and time using the "date" command and assigns it to the variable "time".
		
		cd $location  # changes the current location to the location under the variable "location".
		bulk_extractor "$1" -o $location/DataAnalysis/$file_name/Bulk_extractor/Bulk_FullData > /dev/null 2>&1  # uses the bulk_extractor tool to analyze the file specified by the user input ($1). The extracted data and information will be saved in the directory path that specify in flag "-o" under the variables location, "DataAnalysis", file_name, and "Bulk_extractor/Bulk_FullData".
		cd $location/DataAnalysis/$file_name/Bulk_extractor  # changes the current location to the location under the variables.
		cp -r Bulk_FullData  Bulk_Filtered_Data && cd Bulk_Filtered_Data # copies the contents of the directory "Bulk_FullData" to a new directory called "Bulk_Filtered_Data" and then changes the current location to "Bulk_Filtered_Data".
		find . -type f -size 0 -exec rm -f {} + # the command searches for files in the current directory and its subdirectories with a size of 0 bytes and then removes them using the "rm" command. The "{} +" part is used to efficiently pass multiple file names to a single invocation of rm. This command helps to delete all empty files within the specified directory and its subdirectories.
		
		cd $location  # changes the current location to the location under the variable "location".
		# The following insering diffrent text and data inside the "Data_Report" file. when using ">>" its keep the current data that in the file and not overwrite it.
		echo "Command: bulk_extractor "$1" -o $location/DataAnalysis/$file_name/Bulk_extractor/Bulk_FullData "  >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		echo "Output directory (full data): $location/DataAnalysis/$file_name/Bulk_extractor/Bulk_FullData"  >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		echo "Output directory (filtered data): $location/DataAnalysis/$file_name/Bulk_extractor/Bulk_Filtered_Data"  >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		echo "------------------------------------------------------------------------------------------" >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		echo  >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		echo "File Name: "$1" " >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		cd $location  # changes the current location to the location under the variable "location".
		echo "File Size: $( du -h "$1" |awk '{print $1}') ( $(ls -l "$1" |awk '{print $5}') bytes)"	 >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report  # The "du -h "$1" | awk '{print $1}'" command calculates the disk usage of the specified file or directory ("$1") and then uses awk to print only the first column of the output, which corresponds to the disk usage size. The -h option in du stands for human-readable, providing the output in a more readable format (e.g., using KB, MB, GB).
		cd $location/DataAnalysis/$file_name/Bulk_extractor # changes the current location to the location under the variables.
		
		# The following insering diffrent text and data inside the "Data_Report" file. when using ">>" its keep the current data that in the file and not overwrite it.
		echo >> Data_Report
		echo "Beginning of the Analysis: $time " >> Data_Report
		echo "The End of the Analysis: $(date) " >> Data_Report
		echo >> Data_Report
		echo "------------------------------------------------------------------------------------------" >> Data_Report
		echo >> Data_Report
		echo "The following displays all the capture files within the Bulk_Filtered_Data directory. " >> Data_Report
		cd $location/DataAnalysis/$file_name/Bulk_extractor/Bulk_Filtered_Data  # changes the current location to the location under the variables.
		echo "Total files captured: $(find . -type f |wc -l) Files" >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report  # the command "find . -type f |wc -l" counts and displays the total number of files in the current directory and its subdirectories.
		cd $location/DataAnalysis/$file_name/Bulk_extractor  # changes the current location to the location under the variables.
		echo >> Data_Report
		cd $location/DataAnalysis/$file_name/Bulk_extractor/Bulk_Filtered_Data   # changes the current location to the location under the variables.
		echo " $(find . -type f ) " >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		echo
		echo "Bulk_extractor Concluded At: $(date) " >> $location/DataAnalysis/$file_name/Bulk_extractor/Data_Report
		
		echo
		echo
		echo
		echo "${bold}${blue}=====================================================>${red} Data Was Successfully Analyzed And Extracted With Bulk_Extractor! ${blue}<================================================${normal}"
	}
	BulkAnalysis "$1"
	
	function BinwalkAnalysis ()  # Function that using the Binwalk command to extract data and information from a file, and then organizes and inserts the results into directorie and files."
	{
		sleep 3
		echo
		echo
		echo	
		echo "                                                         ${bold} Extracting And Conducting Forensic Analysis Using Binwalk...${normal}  "	
		echo "                                                                    (This process may take a little while.)   " 	
		cd $location/DataAnalysis/$file_name  # changes the current location to the location under the variables.
		mkdir Binwalk  # inside the location make a directory named "Binwalk"
		cd $location/DataAnalysis/$file_name/Binwalk # changes the current location to the location under the variables.
		
		# The following insering diffrent text and data inside the "Binwalk_Analyzed_Data" file. when using ">>" its keep the current data that in the file and not overwrite it.
		echo "  " > Binwalk_Analyzed_Data
		echo "[!] Presenting the Binwalk-Analyzed Data Along with the Scan Timestamp and a Few Keywords That Indicate Potential Files." >> Binwalk_Analyzed_Data
		echo "  " >> Binwalk_Analyzed_Data
		echo " >  The Binwalk Scan Was Initiated At: $(date) " >> Binwalk_Analyzed_Data
		echo "  " >> Binwalk_Analyzed_Data
		cd $location  # changes the current location to the location under the variable "location".
		binwalk "$1" > $location/DataAnalysis/$file_name/Binwalk/Binwalk_FullData # uses the binwalk tool to analyze the file specified by the user input ($1). The extracted data and information will be saved in the directory path that specify after the symbol ">" under the variables location, "DataAnalysis", file_name, and "Binwalk/Binwalk_FullData".
		cd $location/DataAnalysis/$file_name/Binwalk # changes the current location to the location under the variables.
		echo " >  The Binwalk Scan Was Concluded At: $(date) " >> Binwalk_Analyzed_Data
		echo "  " >> Binwalk_Analyzed_Data
		echo "[*] The Following Displays Keywords Used to Scan the Data, Which Can Be Indicators of Potential Files Within the Data." >> Binwalk_Analyzed_Data
		echo "  " >> Binwalk_Analyzed_Data
		echo " -  The Keyword 'Microsoft Executable, Portable' Indicates for Executables Files (.exe), and Dynamic Link Library (.dll): $(cat Binwalk_FullData | grep -i "Microsoft executable, portable" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo " -  The Keyword 'Zip Archive Data' Indicates for a Compressed File (.zip), That May Contain Multiple Files or Directories: $(cat Binwalk_FullData | grep -i "Zip archive data" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo " -  The Keyword 'HTML Document Header' Indicates the Potential Presence of HTML Files or Data with HTML Formatting (.html): $(cat Binwalk_FullData | grep -i "HTML Document Header" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo " -  The Keyword 'XML Document' Indicates for Configuration Files (.xml), Web Pages, and Documents with Structured Data: $(cat Binwalk_FullData | grep -i "XML Document" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo " -  The Keyword 'GIF Image Data' Indicates the Potential Presence of Files Containing Graphics in GIF Image Format (.GIF): $(cat Binwalk_FullData | grep -i "GIF Image Data" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo " -  The Keyword 'JPEG Image Data' Indicates the Potential Presence of Files Containing Graphics in JPEG Image Format (.JPEG or .JPG): $(cat Binwalk_FullData | grep -i "JPEG image data" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo " -  The Keyword 'PNG image' Indicates the Potential Presence of Files Containing Graphics in PNG Image Format (.PNG): $(cat Binwalk_FullData | grep -i "PNG image" |wc -l) Potential Files Within the Data Were Found.">> Binwalk_Analyzed_Data
		echo "  " >> Binwalk_Analyzed_Data
		echo "[*] The Following Displays the Entire Data Extracted from the Binwalk Scan." >> Binwalk_Analyzed_Data
		echo "  " >> Binwalk_Analyzed_Data
		cat Binwalk_FullData >> Binwalk_Analyzed_Data  # inserting all the text inside the Binwalk_FullData file and copy it inside Binwalk_Analyzed_Data without overwrite it.
		rm Binwalk_FullData # removing the file "Binwalk_FullData"
		echo
		echo
		echo
		echo "${bold}${blue}=========================================================>${red} Data Was Successfully Analyzed And Extracted With Binwalk! ${blue}<===================================================${normal}"						
		
	}
	BinwalkAnalysis "$1"
		

	function Foremost () # Function that using the foremost command to extract data and information from a file, and then organizes and inserts the results into directorie and files."
	{
		sleep 3
		echo
		echo
		echo	
		echo "                                                         ${bold} Extracting And Conducting Forensic Analysis Using Foremost...${normal}  "	
		cd $location/DataAnalysis/$file_name  # changes the current location to the location under the variables.
		mkdir Foremost	 # inside the location make a directory named "Foremost".
		cd $location  # changes the current location to the location under the variable "location".
		foremost -i "$1" -t all -o $location/DataAnalysis/$file_name/Foremost/Foremost_Data > /dev/null 2>&1 # command uses the "foremost" tool to conduct file carving on the specified input file ("$1") and extracts various file types specified by the -t all option. The extracted data is then stored in the directory path under the variables location.
		echo
		echo
		echo
		echo "${bold}${blue}=========================================================>${red} Data Was Successfully Analyzed And Extracted With Foremost! ${blue}<==================================================${normal}"				
	}
	Foremost "$1"
	
	function Exiftool () # Function that using the Exiftool command to extract data and information from a file, and then organizes and inserts the results into directorie and files."
	{
		sleep 3
		echo
		echo
		echo	
		echo "                                                         ${bold} Extracting And Conducting Forensic Analysis Using Exiftool...${normal}  "	
		cd $location/DataAnalysis/$file_name # changes the current location to the location under the variables.
		mkdir Exiftool	 # inside the location make a directory named "Exiftool".
		cd $location # changes the current location to the location under the variable "location".
		exiftool "$1" > $location/DataAnalysis/$file_name/Exiftool/Exiftool_data # command uses the "exiftool" tool to extract metadata from the specified file ("$1") and writes the extracted information to a file named "Exiftool_data" within the directory path under the variables location. 
		cd $location/DataAnalysis/$file_name/Exiftool # changes the current location to the location under the variables.
		echo "  " > Exiftool_Data
		echo "[*] This Document Showcases the Results of the Metadata Output Obtained by Using the 'exiftool' Command:" >> Exiftool_Data
		echo "  " >> Exiftool_Data		
		echo "[*] The Following Displays All Exiftool Data Output: " >> Exiftool_Data
		echo "  " >> Exiftool_Data
		cat Exiftool_data >> Exiftool_Data	# inserting all the text inside the Exiftool_data file and copy it inside Exiftool_Data without overwrite it.
		rm Exiftool_data # removing the file "Exiftool_data"
		sleep 2.5		
		echo
		echo
		echo
		echo "${bold}${blue}=========================================================>${red} Data Was Successfully Analyzed And Extracted With Exiftool! ${blue}<==================================================${normal}"				
	}
	Exiftool "$1"
	
	function STRINGS () # Function that using the Strings command to extract information from a file, using different patterns and keywords and then organizes and inserts the results into directories and files."
	{
		sleep 3
		echo
		echo
		echo
		echo "                                                         ${bold} Extracting And Conducting Forensic Analysis Using Strings...${normal}  "		
		cd $location/DataAnalysis/$file_name  # changes the current location to the location under the variables.
		mkdir Strings	 # inside the location make a directory named "Strings".	
		cd Strings  # entering the new created directory
		mkdir Strings_Analyzed  # inside the location make a directory named "Strings_Analyzed" .
		
		function emails () # Function that using the Strings command to extract information from a file, about Email addresses structure using specific pattern and then organizes and inserts the results into file."
		{
			cd $location  # changes the current location to the location under the variable "location".
			strings "$1" |grep -E -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b' > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_emails  # The provided command extracts email addresses with the according pattern from the content of the file specified by the argument "$1". and save it into the location under the variables.
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed  # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_Emails" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_Emails
			echo "[!] The Total Number Of Emails Stracutre Is: $(cat Strings_emails|wc -l)" >> Strings_Emails
			echo "[*] The Following Displays the Count of Email Addresses from Well-Known Domains:" >> Strings_Emails
			echo "  " >> Strings_Emails
			echo " >  The Total Count of Email Addresses with the '.com' Domain Is: $(cat Strings_emails|grep -i .com|wc -l) " >> Strings_Emails
			echo " >  The Total Count of Email Addresses with the '.net' Domain Is: $(cat Strings_emails|grep -i .net|wc -l) " >> Strings_Emails
			echo " >  The Total Count of Email Addresses with the '.dll' Domain Is: $(cat Strings_emails|grep -i .dll|wc -l) " >> Strings_Emails
			echo " >  The Total Count of Email Addresses with the '.org' Domain Is: $(cat Strings_emails|grep -i .org|wc -l) " >> Strings_Emails
			echo " >  The Total Count of Email Addresses with the '.gov' Domain Is: $(cat Strings_emails|grep -i .gov|wc -l) " >> Strings_Emails
			echo "  " >> Strings_Emails
			echo "[*] The Following Displays All the Discovered Email Addresses.: " >> Strings_Emails
			echo "  " >> Strings_Emails
			cat Strings_emails >> Strings_Emails  # inserting all the text inside the Strings_emails file and copy it inside Strings_Emails without overwrite it.
			rm Strings_emails  # removing the file "Exiftool_data"
		}	
		emails "$1"		
		
		function IPAddr ()  # Function that using the Strings command to extract information from a file, about IP addresses structure using specific pattern and then organizes and inserts the results into file."
		{
			cd $location # changes the current location to the location under the variable "location".
			strings "$1" |grep -E -o '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' |sort |uniq  > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_IP.Addr  # The provided command extracts ip addresses with the according pattern from the content of the file specified by the argument "$1". and save it into the location under the variables. 
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed  # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_IP_Addr" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_IP_Addr
			echo "[!] The Total Count Of IP Addresses Is: $(cat Strings_IP.Addr|wc -l)" >> Strings_IP_Addr
			echo "  " >> Strings_IP_Addr
			echo "[*] The Following Displays All the Discovered IP Addresses: " >> Strings_IP_Addr
			echo "  " >> Strings_IP_Addr
			cat Strings_IP.Addr >> Strings_IP_Addr  # inserting all the text inside the Strings_IP.Addr file and copy it inside Strings_IP_Addr without overwrite it.
			rm Strings_IP.Addr  # removing the file "Strings_IP.Addr"
		}
		IPAddr "$1"	
		
		function MACAddr ()  # Function that using the Strings command to extract information from a file, about MAC addresses structure using specific pattern and then organizes and inserts the results into file."
		{
			cd $location  # changes the current location to the location under the variable "location".
			strings "$1" | grep -Eo "([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}" > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_mac_Addr  # The provided command extracts MAC addresses with the according pattern from the content of the file specified by the argument "$1". and save it into the location under the variables. 
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed  # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_MAC_Addr" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_MAC_Addr
			echo "[!] The Total Count Of MAC Addresses Is: $(cat Strings_mac_Addr |wc -l)" >> Strings_MAC_Addr
			echo "  " >> Strings_MAC_Addr
			echo "[*] The Following Displays All The Discovered MAC Addresses: " >> Strings_MAC_Addr
			echo "  " >> Strings_MAC_Addr
			cat Strings_mac_Addr >> Strings_MAC_Addr # inserting all the text inside the Strings_mac_Addr file and copy it inside Strings_MAC_Addr without overwrite it.
			rm Strings_mac_Addr	 # removing the file "Strings_mac_Addr"
		}
		MACAddr "$1"
		
		function FileExt ()  # Function that using the Strings command to extract information from a file, about File extensions information using specific keywords and then organizes and inserts the results into file."
		{
			cd $location  # changes the current location to the location under the variable "location".
			strings "$1" | grep -iE '\.(exe|dll|zip|html|xml|gif|jpeg|jpg|png)$' > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_File_EXT # The provided command extracts File extensions information with the according keywords from the content of the file specified by the argument "$1". and save it into the location under the variables. 
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed  # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_File_Ext" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_File_Ext
			echo "[!] The Total Count Of Potential Files Within The Data That Was Found is: $(cat Strings_File_EXT |wc -l)" >> Strings_File_Ext
			echo "  " >> Strings_File_Ext
			echo " -  The Keyword 'exe' Indicates for Executables Files With The '.exe' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".exe" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'dll' Indicates for Dynamic Link Library Type of Files With The '.dll' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".dll" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'zip' Indicates for Compressed Files with the '.zip' Extension During the Analysis Process.: $(cat Strings_File_EXT |grep -i ".zip" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'html' Indicates for Hypertext Markup Language Files With The '.html' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".html" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'xml' Indicates for Configuration Files, Web Pages and Documents With The '.xml' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".xml" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'gif' Indicates for Files Containing Graphics in GIF Image Format With The '.gif' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".gif" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'jpeg' Indicates for Files Containing Graphics in JPEG Image Format With The '.jpeg' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".jpeg" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'jpg' Indicates for Files Containing Graphics in JPG Image Format With The '.jpg' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".jpg" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo " -  The Keyword 'png' Indicates for Files Containing Graphics in PNG Image Format With The '.png' Extension During The Analysis Process: $(cat Strings_File_EXT |grep -i ".png" |wc -l) Potential Files Within the Data Were Found." >> Strings_File_Ext
			echo "  " >> Strings_File_Ext
			echo "[*] The Following Displays All The Files Extension Data: " >> Strings_File_Ext
			echo "  " >> Strings_File_Ext
			cat Strings_File_EXT >> Strings_File_Ext  # inserting all the text inside the Strings_File_EXT file and copy it inside Strings_File_Ext without overwrite it.
			rm Strings_File_EXT	 # removing the file "Strings_File_EXT"
		}
		FileExt "$1"
		
		function Security ()  # Function that using the Strings command to extract information from a file, about Security information using specific keywords and then organizes and inserts the results into file."
		{
			cd $location  # changes the current location to the location under the variable "location".
			strings "$1" | grep -Ei 'security|firewall|antivirus|malware' > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_SecuritY   # The provided command extracts Security information with the according keywords from the content of the file specified by the argument "$1". and save it into the location under the variables. 
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed   # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_Security" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_Security
			echo "[*] This File Displays Security-Related Keywords That Have Been Scanned for Investigation Purposes." >> Strings_Security			
			echo "  " >> Strings_Security
			echo "[!] The Total Count Of Security-Related Keywords Is: $(cat Strings_SecuritY |wc -l)" >> Strings_Security
			echo "  " >> Strings_Security
			echo " -  The Keyword 'Security' Will Indicates for the Presence of the Keyword Security Within the Data: $(cat Strings_SecuritY |grep -i "Security"|wc -l) Number of Times the Word Appeared." >> Strings_Security	
			echo " -  The Keyword 'firewall' Will Indicates for the Presence of the Keyword firewall Within the Data: $(cat Strings_SecuritY |grep -i "firewall"|wc -l) Number of Times the Word Appeared." >> Strings_Security	
			echo " -  The Keyword 'antivirus' Will Indicates for the Presence of the Keyword antivirus Within the Data: $(cat Strings_SecuritY |grep -i "antivirus"|wc -l) Number of Times the Word Appeared." >> Strings_Security	
			echo " -  The Keyword 'malware' Will Indicates for the Presence of the Keyword malware Within the Data: $(cat Strings_SecuritY |grep -i "malware"|wc -l) Number of Times the Word Appeared." >> Strings_Security	
			echo "  " >> Strings_Security
			echo "[*] The Following Displays All The Security-Related Keywords Data: " >> Strings_Security
			echo "  " >> Strings_Security
			cat Strings_SecuritY >> Strings_Security  # inserting all the text inside the Strings_SecuritY file and copy it inside Strings_Security without overwrite it.
			rm Strings_SecuritY	 # removing the file "Strings_SecuritY"
		}
		Security "$1"
		
		function Credentials ()  # Function that using the Strings command to extract information from a file, about Credentials information using specific keywords and then organizes and inserts the results into file."
		{
			cd $location  # changes the current location to the location under the variable "location".
			strings "$1" | grep -Ei 'password|login|user|auth|credential' > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_CredentialS  # The provided command extracts Credentials information with the according keywords from the content of the file specified by the argument "$1". and save it into the location under the variables. 
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed  # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_Security" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_Credentials
			echo "[*] This File Displays Authentication And Credentials Related Keywords That Have Been Scanned for Investigation Purposes." >> Strings_Credentials			
			echo "  " >> Strings_Credentials
			echo "[!] The Total Count Of Authentication And Credentials Related Keywords Is: $(cat Strings_CredentialS |wc -l)" >> Strings_Credentials
			echo "  " >> Strings_Credentials
			echo " -  The Keyword 'password' Will Indicates for the Presence of the Keyword password Within the Data: $(cat Strings_CredentialS |grep -i "password"|wc -l) Number of Times the Word Appeared." >> Strings_Credentials	
			echo " -  The Keyword 'login' Will Indicates for the Presence of the Keyword login Within the Data: $(cat Strings_CredentialS |grep -i "login"|wc -l) Number of Times the Word Appeared." >> Strings_Credentials	
			echo " -  The Keyword 'user' Will Indicates for the Presence of the Keyword antivirus Within the Data: $(cat Strings_CredentialS |grep -i "user"|wc -l) Number of Times the Word Appeared." >> Strings_Credentials	
			echo " -  The Keyword 'auth' Will Indicates for the Presence of the Keyword auth Within the Data: $(cat Strings_CredentialS |grep -i "auth"|wc -l) Number of Times the Word Appeared." >> Strings_Credentials	
			echo " -  The Keyword 'credential' Will Indicates for the Presence of the Keyword credential Within the Data: $(cat Strings_CredentialS |grep -i "credential"|wc -l) Number of Times the Word Appeared." >> Strings_Credentials	
			echo "  " >> Strings_Credentials
			echo "[*] The Following Displays All The Authentication And Credentials Related Keywords Data: " >> Strings_Credentials
			echo "  " >> Strings_Credentials
			cat Strings_CredentialS >> Strings_Credentials  # inserting all the text inside the Strings_CredentialS file and copy it inside Strings_Credentials without overwrite it.
			rm Strings_CredentialS	 # removing the file "Strings_CredentialS"
		}
		Credentials "$1"
		
		function URLS ()  # Function that using the Strings command to extract information from a file, about URL addresses structure using specific pattern and then organizes and inserts the results into file."
		{
			cd $location  # changes the current location to the location under the variable "location".
			strings "$1"| grep -E 'http[s]?://[a-zA-Z0-9_\.-]+' > $location/DataAnalysis/$file_name/Strings/Strings_Analyzed/Strings_URLS_Web  # The provided command extracts URL addresses with the according pattern from the content of the file specified by the argument "$1". and save it into the location under the variables. 
			cd $location/DataAnalysis/$file_name/Strings/Strings_Analyzed  # changes the current location to the location under the variables.
			
			# The following insering diffrent text and data inside the "Strings_Security" file. when using ">>" its keep the current data that in the file and not overwrite it.
			echo "  " >> Strings_URLs_Web
			echo "[!] The Total Count Of URLs And Web-Related Information: Is: $(cat Strings_URLS_Web |wc -l) Potential URLs Within the Data Were Found." >> Strings_URLs_Web
			echo "  " >> Strings_URLs_Web
			echo "[*] The Following Displays All The URLs And Web-Related Data: " >> Strings_URLs_Web
			echo "  " >> Strings_URLs_Web
			cat Strings_URLS_Web >> Strings_URLs_Web  # inserting all the text inside the Strings_URLS_Web file and copy it inside Strings_URLs_Web without overwrite it.
			rm Strings_URLS_Web	  # removing the file "Strings_URLS_Web"
		}
		URLS "$1"
		
		
		function UserWords ()  # Function prompts the user for additional keywords that he want to scan also and insert it into diffrent file for each keyword.
		{
			echo
			echo	
			echo "                                    	${bold}    The File Is Being Scanned Using Keywords and Patterns to Assist with Your Data Analysis... ${normal}"
			sleep 3.5
			echo
			echo "                                          ${bold}  ${blue}  If You Want to Include Your Own Keywords in the Scanning Process, Please Provide Them.  ${normal}"
			sleep 3.5
			echo
			read -p "                                                  (Make sure your keywords are separated by spaces when entering): " keys   # command prompts the user to enter keywords, displaying a custom message, and stores the input in the variable "keys."
			IFS=' ' read -ra keywords <<< "$keys"  # The following command takes the user-provided keywords, splits them at spaces, and stores them in an array named "keywords" for further processing in the script.
			for keyword in "${keywords[@]}";   # for statment line that initiates a loop that iterates through each element in the "keywords" array, allowing the script to perform actions for each individual keyword.
			do
				cd $location  # changes the current location to the location under the variable "location".
				output=$(strings "$1" | grep -Ei "$keyword")  # using the "strings" command on the file specified by the argument "$1",then using "grep" command on each word inside the "keyword" variable, which filters lines containing the keyword case-insensitively, and storing the result into an "output" variable.
				cd $location/DataAnalysis/$file_name/Strings  # changes the current location to the location under the variables.
				if [ -n "$output" ];   # if statment line that checks if the variable "output" is non-empty, indicating that the keyword was found in the file during the search. moving to then statment.
				then
					mkdir Strings_User_Input  > /dev/null 2>&1  #  creates a directory named "Strings_User_Input" in the current location.
					echo "$output" > "Strings_User_Input/Strings_${keyword}"  # command writes the content of the "output" variable to a file named "Strings_${keyword}" inside the "Strings_User_Input" directory. Each keyword corresponds to a separate file in the specified directory. the file will saved as "Strings_(and the keyword the user choose)".
				fi
			done
		}
		UserWords "$1"
		
		sleep 2	
		echo
		echo
		echo
		echo "${bold}${blue}=========================================================>${red} Data Was Successfully Analyzed And Extracted With Strings! ${blue}<===================================================${normal}"					
	}
	STRINGS "$1"

	function pcapsearch ()  # Function to check all created files for the presence of ".pcap" files, if found notifying the user and saving the identified files into a separate directory.
	{
		sleep 3
		echo
		echo
		echo
		echo "                                                ${bold} Scanning Each Directory That Was Created In Order To Extract Network Files....${normal}  "				
		cd $location/DataAnalysis/$file_name
		pcapFiles=$(find . -type f -name "*.pcap" -size +0)  #  command searches for files with the ".pcap" extension, larger than 0 bytes, starting from the current directory (.) and stores the list of matching files in the "pcapFiles" variable.
	
		if [ -n "$pcapFiles" ]  #  line checks if the variable "pcapFiles" is non-empty, indicating that there are pcap files found during the search. then moving to "then" statment and if not files was found moving to "else" statment
		then
			rm -rf Network_pcap_file  # command removes the directory named "Network_pcap_file"
			mkdir -p Network_pcap_file  # command creates a directory named "Network_pcap_file" in the current location. The -p option ensures that the command creates parent directories if they don't exist
			cp -t Network_pcap_file $pcapFiles  > /dev/null 2>&1   # command copies the pcap files specified in the variable "pcapFiles" to the "Network_pcap_file" directory.
			cd Network_pcap_file  # entering the directory that was created named "Network_pcap_file".
			echo
			sleep 4.5
			echo
			echo "                                                         ${bold}${blue} The Total Count of Network Files We Managed to Extract Is: $(find . -type f -name '*.pcap' | wc -l  ) ${normal} "		
			echo		
			for i in $(ls)  # for loop that will do actions in all the files in the currect loction and displaying inforamtion about the pcap files that was found.
			do
				sleep 3
				echo
				echo "                                                                         ${bold} The Name Of The Network File   ${normal} "
				sleep 1
				echo
				echo "                                                                           ${bold} ${green}      $i       ${normal}"
				sleep 1
				echo
				echo "                                 	                                 ${bold} The Size Of The Network File   ${normal} "
				sleep 1
				echo
				echo "                                                                               ${bold} ${green}      $(ls -lh $i |grep -i ".pcap" |awk '{print $5}')       ${normal}"    
				sleep 1
				echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- "	  	     
				echo                  
			done
				sleep 2
				echo "                                                        ${bold} The Directory Location/Path That Contains The Network Files Is: ${normal} "  
				sleep 2
				echo
				echo "                                                        ${green}$(pwd)    ${normal}                     "
				sleep 5		
		else
			sleep 3
			echo
			echo
			echo "                                                  ${bold}[!] Unfortunately, No Network Files Were Found Within The Directories Data.   ${normal}"
			sleep 5
			echo
			echo
		fi			
	}
	pcapsearch

	function VOL () # function for volatility analysis to extract information from a file, using volatility command and then organizes and inserts the results into directories and files."
	{
		cd $location/DataAnalysis/$file_name   # changes the current location to the location under the variables.
		rm -rf Volatility_Analysis   # command removes the directory named "Volatility_Analysis"
		mkdir Volatility_Analysis  # command creates a directory named "Volatility_Analysis" in the current location.
		cd Volatility_Analysis  # entering the directory that was created named "Network_pcap_file".
		mkdir Commands_Data  # command creates a directory named "Commands_Data" in the current location.
		
		function VOLINSTL ()  # Function to remove the existing Volatility files, if they exist, and install Volatility to ensure proper execution of the commands.
		{
			clear
			echo
			echo "                                                   ${bold}          Preparing and Installing the Volatility Forensics Tool.    ${normal}"
			sleep 2
			echo
			echo
			echo "                                                   Checking Whether the Provided File Is Compatible for Analysis with Volatility.       "		
			cd $location
			rm -rf volatility_2.6_lin64_standalone*  > /dev/null 2>&1  # command removes the directory named "volatility_2.6_lin64_standalone*"
			rm vol.py  > /dev/null 2>&1  # command removes the file named "vol.py".
			wget http://downloads.volatilityfoundation.org/releases/2.6/volatility_2.6_lin64_standalone.zip > /dev/null 2>&1  # using the "wget" command that download from a URL address a package into linux. the following command downloads the Volatility framework version 2.6 for Linux in a zip file from the specified URL.
			unzip volatility_2.6_lin64_standalone.zip > /dev/null 2>&1 && cd volatility_2.6_lin64_standalone  # unzip and extracts the contents of the "volatility_2.6_lin64_standalone.zip" file. and then entering the extracted directory.
			mv volatility_2.6_lin64_standalone vol.py  # The "nv"  command renames the file "volatility_2.6_lin64_standalone" to "vol.py". 
			cp vol.py $location  # the following command copies the "vol.py" executable file to the location under the "location" variable.
			cd $location  # changes the current location to the location under the variable "location".
			rm -rf volatility_2.6_lin64_standalone*  # command removes the directory named "volatility_2.6_lin64_standalone*"
		}
		VOLINSTL "$1"

		function VOLAnalysis ()  # Function that analysis the file using volatility command while using different keywords.
		{					
			sleep 2
			echo
			echo "${bold}${blue}================================================(${green} Extracting Information And Conducting Forensic Analysis Using Volatility...${blue})===========================================${normal}"	
			echo
			function imageinfo () # Function to extract information with volatility about the image profile of the file
			{
				cd $location   # changes the current location to the location under the variable "location".
				echo "$(./vol.py -f "$1" imageinfo 2>&1)" > $location/DataAnalysis/$file_name/Volatility_Analysis/Commands_Data/Vol_Imageinfo  #  command executes the Volatility command imageinfo on the specified memory dump file, captures the output, and writes it to a file named "Vol_Imageinfo" within the specified directory path.				
				image=$(./vol.py -f "$1" imageinfo 2>&1 |grep -i "Suggested Profile"|awk -F: '{print $2}'|awk '{print $1}'|sed 's/,//g')  # command extracts the suggested profile from the output of the Volatility imageinfo command applied to the specified memory dump file and stores it in the variable "image."
				sleep 1
				echo
				echo "                                                                    ${bold} The Name Of The Memory Profile Image   ${normal} "
				sleep 2
				echo
				echo
				echo "                                                                   ${bold}${green}               $image       ${normal}"	 # displaying the profile of the file on screen under the variable "$image"	
			}
			imageinfo "$1"
			
			function pslist ()  # Function to extract information with volatility about the List Of Processes of the file
			{
				sleep 2
				echo
				echo
				echo		
				echo "                                                                     ${bold} List Of Processes That Were Running.   ${normal} "
				sleep 1
				cd $location  # changes the current location to the location under the variable "location".
				echo "$(./vol.py -f "$1" --profile=$image pslist 2>&1)" > $location/DataAnalysis/$file_name/Volatility_Analysis/Commands_Data/Vol_Pslist  # command executes the Volatility pslist command using the suggested profile obtained previously, to display list Of Processes That Were Running. captures the output, and writes it to a file named "Vol_Pslist" within the specified directory path.			
				echo
				echo
				echo "${bold}${green}$(./vol.py -f "$1" --profile=$image pslist 2>&1 |grep -v "Volatility Foundation" |head)  ${normal}"  # Displaying the "pslist" command on screen and prints the first few lines of the result on the screen
				sleep 1
				echo
				echo "${bold}${green}                                                                  (The entire processes will be in the file.)      ${normal}" 
			}
			pslist "$1"

			function netscan ()  # Function to extract information with volatility about List Of Network-Related Information from the file
			{
				sleep 2
				echo
				echo
				echo
				echo		
				echo "                                                                     ${bold} List Of Network-Related Information.   ${normal} "
				sleep 1
				cd $location  # changes the current location to the location under the variable "location".
				echo "$(./vol.py -f "$1" --profile=$image netscan 2>&1)" > $location/DataAnalysis/$file_name/Volatility_Analysis/Commands_Data/Vol_Netscan  # The command executes the Volatility "netscan" command using the suggested profile, to display List Of Network-Related Information. captures the output, and writes it to a file named "Vol_Netscan" within the specified directory path.
				echo
				echo
				echo "${bold}${green}$(./vol.py -f "$1" --profile=$image netscan 2>&1 |tail)  ${normal}"  # Displaying the "netscan" command on screen and prints the last few lines of the result on the screen
				sleep 1
				echo
				echo "${bold}${green}                                                              (The entire Network Connections will be in the file.)      ${normal}" 
			}
			netscan "$1"
			
			function dlllist ()  # Function to extract information with volatility about List the loaded DLLs for each process information from the file
			{
				sleep 2
				echo
				echo
				echo
				echo
				echo "                                                                     ${bold} List the loaded DLLs for each process.   ${normal} "
				sleep 1
				cd $location  # changes the current location to the location under the variable "location".
				echo "$(./vol.py -f "$1" --profile=$image dlllist 2>&1)" > $location/DataAnalysis/$file_name/Volatility_Analysis/Commands_Data/Vol_Dlllist  # command executes the Volatility "dlllist" command using the suggested profile, to display List the loaded DLLs for each process. captures the output, and writes it to a file named "Vol_Dlllist" within the specified directory path.
				echo
				echo
				echo "${bold}${green}$(./vol.py -f "$1" --profile=$image dlllist 2>&1 |tail)  ${normal}"   # Displaying the "dlllist" command on screen and prints the last few lines of the result on the screen.
				sleep 1
				echo
				echo "${bold}${green}                                                                  (The entire loaded DLLs will be in the file.)      ${normal}" 
			}
			dlllist "$1"

			function filescan ()   # Function to extract information with volatility about the Scans of the memory for file objects information from the file
			{
				sleep 2
				echo
				echo
				echo
				echo		
				echo "                                                                    ${bold}     Scans the memory for file objects.   ${normal} "
				sleep 1
				cd $location
				echo "$(./vol.py -f "$1" --profile=$image filescan 2>&1)" > $location/DataAnalysis/$file_name/Volatility_Analysis/Commands_Data/Vol_Filescan  # command executes the Volatility filescan command using the suggested profile, Scans the memory for file objects. captures the output, and writes it to a file named "Vol_Filescan" within the specified directory path.				
				echo
				echo
				echo "${bold}${green}$(./vol.py -f "$1" --profile=$image filescan 2>&1 |tail)  ${normal}"   # Displaying the "filescan" command on screen and prints the last few lines of the result on the screen.
				sleep 1
				echo
				echo "${bold}${green}                                                                   (The entire Scan Results will be in the file.)      ${normal}" 
				sleep 3.5
			}
			filescan "$1"

		}

		function VOLCHK ()  # Function that will Check Whether the Provided File Is Compatible for Analysis with Volatility.
		{
			if [ -z "$(./vol.py -f "$1" imageinfo 2>&1 |grep -i 'No suggestion')" ]  #  line checks if the output of the Volatility imageinfo command on the specified memory dump file does not contain the phrase "No suggestion," indicating that a suggested profile is available. then moveing to "then" statment if its not contain moving to "else" statment.
			then
				echo
				echo
				echo "${bold}                                               The File "$base_name" Has Been Checked, Examined, and is Valid for Volatility Analysis.  ${normal}"
				sleep 3
				echo
				echo "                                                                      Preparing for the Volatility Analysis...  "
				echo
				VOLAnalysis "$1"
			else
				echo "${bold}${red}                                              After Inspecting the File, "$1" Is Found to Be Invalid for Volatility Analysis.  ${normal}"
			fi		
		}
		VOLCHK "$1"
	}
	VOL "$1"
	
	function RegFiles ()  # Function that use the volatility to scan for Registry Files information within the file while using diffrent keywords.
	{
		clear
		echo 
		echo "                                                    ${bold}${green}     Attempting To Extract Information From The Windows Registry Files.           ${normal}"
		sleep 4
		cd $location/DataAnalysis/$file_name/Volatility_Analysis  # changes the current location to the location under the variables.
		mkdir Registry_Data  # command creates a directory named "Registry_Data" in the current location.
		
		function SYSTEM () # Function that Extracting the Computer Name from the Windows Registry.
		{
			echo
			echo
			echo "                                                          ${bold}     Extracting the Computer Name from the Windows Registry...      ${normal}"
			sleep 1
			echo
			echo
			cd $location
			sysAddr=$(./vol.py -f "$1" --profile=$image hivelist 2>&1 |grep -i registry |grep -i system |awk '{print $1}')  # command retrieves the physical address of the Windows registry hive for the "System" file using Volatility and stores it in the variable "sysAddr."
			./vol.py -f "$1" --profile=$image printkey -o $sysAddr -K "ControlSet001\Control\ComputerName\ComputerName" > $location/DataAnalysis/$file_name/Volatility_Analysis/Registry_Data/ComputerName 2>&1  # command uses Volatility to print the registry key "ControlSet001\Control\ComputerName\ComputerName" from the specified memory dump file, and the output is saved to a file named "ComputerName" within the specified directory path for further analysis.
			echo "                                             ${bold}${blue}     Computer Name Extraction Completed. Check the 'ComputerName' File for the Results.       ${normal}"
			sleep 3
		}
		SYSTEM "$1"

		function SOFTWARE ()  # Function that Extracting Uninstalled Files Information from the Windows Registry.
		{
			echo
			echo
			echo
			echo
			echo "                                                    ${bold}     Extracting Uninstalled Files Information from the Windows Registry...     ${normal}"
			sleep 1
			echo
			echo
			cd $location
			softAddr=$(./vol.py -f "$1" --profile=$image hivelist 2>&1 |grep -i system |grep -i software |awk '{print $1}')  #  command retrieves the physical address of the Windows registry hive for the "Software" file using Volatility and stores it in the variable "softAddr."
			./vol.py -f "$1" --profile=$image printkey -o $softAddr -K "Microsoft\Windows\CurrentVersion\Uninstall" > $location/DataAnalysis/$file_name/Volatility_Analysis/Registry_Data/Uninstall 2>&1  #  command uses Volatility to print the registry key "Microsoft\Windows\CurrentVersion\Uninstall" from the specified memory dump file, and the output is saved to a file named "Uninstall" within the specified directory path for further analysis.
			echo "                                       ${bold}${blue}     Uninstalled Files Information Extraction Completed. Check the 'Uninstall' File for the Results.  ${normal}"	
			sleep 3	
		}
		SOFTWARE "$1"

		function SAM ()   # Function that Extracting User Names Information from the Windows Registry.
		{
			echo
			echo
			echo
			echo			
			echo "                                                       ${bold}     Extracting User Names Information from the Windows Registry...   ${normal}"
			sleep 1
			echo
			echo
			cd $location	
			SamAddr=$(./vol.py -f "$1" --profile=$image hivelist 2>&1 |grep -i system |grep -i SAM |awk '{print $1}')  # command retrieves the physical address of the Windows registry hive for the "SAM" file using Volatility and stores it in the variable "SamAddr."
			./vol.py -f "$1" --profile=$image printkey -o $SamAddr -K "SAM\Domains\Account\Users\Names"  > $location/DataAnalysis/$file_name/Volatility_Analysis/Registry_Data/UserNames 2>&1  # command utilizes Volatility to print the registry key "SAM\Domains\Account\Users\Names" from the specified memory dump file. The output is then saved to a file named "UserNames" within the specified directory path for further analysis.
			echo "                                           ${bold}${blue}     User Names Information Extraction Completed. Check the 'UserNames' File for the Results.  ${normal}"
			sleep 3	
		}
		SAM "$1"

		function SECURITY ()  # Function that Extracting Policy Information from the Windows Registry.
		{
			echo
			echo
			echo
			echo
			echo "                                                         ${bold}     Extracting Policy Information from the Windows Registry...     ${normal}"
			sleep 1
			echo
			echo
			cd $location
			SecAddr=$(./vol.py -f "$1" --profile=$image hivelist 2>&1 |grep -i system |grep -i SECURITY |awk '{print $1}')  # command retrieves the physical address of the Windows registry hive for the "SECURITY" file using Volatility and stores it in the variable "SecAddr."
			./vol.py -f "$1" --profile=$image printkey -o $SecAddr -K "Policy"  > $location/DataAnalysis/$file_name/Volatility_Analysis/Registry_Data/Policy 2>&1  # command employs Volatility to print the registry key "Policy" from the specified memory dump file. The output is then saved to a file named "Policy" within the specified directory path for further analysis.
			echo "                                               ${bold}${blue}     Policy Information Extraction Completed. Check the 'Policy' File for the Results.    ${normal}"
			sleep 3
		}
		SECURITY "$1"
		echo 
		echo
		echo
		echo "                                     ${bold}${green}     All Data From Your File Has Been Thoroughly Scanned, Extracted, and Successfully Saved on Your Computer!      ${normal}"
		echo
		sleep 5
	}
	RegFiles "$1"
}


function FILE ()  # Function to ask the user for a file to analyzed , verifying its existence, and if the file exists, calling the function that analyzes the file.
{
	echo
	echo
	echo "${bold}[*] Preparing The Forensic Tools To Analyze The Selected File...${normal}"	
	
	while true  # while loop that will ask the user for the file ,verifying its existence, and if the file exists, calling the function that analyzes the file. if not loop until a vaild file is input.
	do		
		sleep 1.5
		echo
		echo
		read -p " >  Please Enter The Name/Full Path Of The File You Want To Analyze: " file_name_path  # command prompts the user to enter the name or full path of the file they want to analyze and stores the input in the variable "file_name_path."
		if [ -f "$file_name_path" ]   #  line checks if the file specified by the variable "file_name_path" exists. If the file exists, moved to "then" statment otherwise move to else statment.
		then
			sleep 2.5
			echo
			echo
			echo "${bold}[✓] File Is Exists, Progressing... ${normal}  "
			ANALYZE "$file_name_path"  # This command calling the function "ANALYZE" with the specified file path ("$file_name_path") as an argument, initiating the analysis process for the specified file.
			break  # The break statement is used within the loop to exit the loop prematurely, jumping to the code that follows the loop.
		else
			echo
			echo
			sleep 2
			echo "${bold}[!] File Not Found, Please Try Again... ${normal} "
			sleep 2
		fi	
	done
}

function DIRECTORY ()  # Function to ask the user for a Directory to analyzed , verifying its existence, and if the Directory  exists, calling the function that analyzes the files within Directory.
{
	echo
	echo
	echo "${bold}[*] Preparing The Forensic Tools To Analyze The Selected Directory...${normal}"	
	echo
		
	while true  # while loop that will ask the user for the Directory ,verifying its existence, and if the Directory exists, calling the function that analyzes the file. if not loop until a vaild Directory is input.
	do
		sleep 1.5
		echo
		read -p " > Enter The Name/Full Path Of The Directory You Want To Analyze: " dir_name_path   # command prompts the user to enter the name or full path of the directory they want to analyze and stores the input in the variable "dir_name_path."
		if [ -d "$dir_name_path" ];   # line checks if the Directory specified by the variable "dir_name_path" exists. If the Directory exists, moved to "then" statment otherwise move to else statment.
		then
			sleep 2.5
			echo
			echo
			echo "${bold}[✓] Directory Is Exists, Progressing... ${normal}  "
            for file in "$dir_name_path"/*;   # line initiates a loop that iterates over each file in the specified directory (represented by the variable "dir_name_path"), assigning each file to the variable "file" for further processing within the loop.
            do
				ANALYZE "$file"   # This command calling the function "ANALYZE" with the specified file path ("$file") as an argument, initiating the analysis process for each file in the specified directory. 				
            done
            break   # The break statement is used within the loop to exit the loop prematurely, jumping to the code that follows the loop.
		else
			echo
			echo
			sleep 2
			echo "${bold}[!] Directory Not Found, Please Try Again... ${normal} "
			sleep 2
			echo
		fi
	done
}

function CHOICE ()  # Function that will ask the user Whether he want to Analyze A Single File Or A Directory Of Files and then calling the needed functions to continue.
{
	echo
	echo "${bold}[*] Before We Start The Analysis Of The Files, Please Choose Whether You Want To Analyze A Single File Or A Directory Of Files. ${normal}"
	sleep 4
	echo
    echo "    Please Choose Your Choice: "
    echo
    sleep 1
    echo "${bold}   ${green} 1. Single File"
    sleep 0.5
    echo "    2. Directory of Files ${normal}"
	echo
	echo
	sleep 2
	while true  # while loop to check if the condition is true
	do
		read -p " > Enter your choice (1 - for a file / 2 - for a directory): " choice  # the command prompts the user to enter their choice (either 1 for a file or 2 for a directory) and stores the input in the variable "choice" for further use in the script.

		if [ "$choice" == "1" ]  # the line checks if the value of the variable "choice" is equal to the string "1".
		then
			FILE    # calling the function called FILE
			break   # The break statement is used within the loop to exit the loop prematurely, jumping to the code that follows the loop.
		elif [ "$choice" == "2" ]   # line is part of an if-else statement and checks if the value of the variable "choice" is equal to the string "2". If the previous conditions in the if statement were not true.
		then
			DIRECTORY    # calling the function called DIRECTORY
			break        # The break statement is used within the loop to exit the loop prematurely, jumping to the code that follows the loop.
		else
			echo
			sleep 1.5
			echo "${bold}[!] Invalid choice. Please choose again. ${normal}"
			echo
			sleep 2	
		fi
	done
}
CHOICE


function ZIP () #  Function to initiates the compression process to create a zip archive of the analysis data
{
		echo
		echo
		echo "                                               ${bold}${purple}     Initiating The Compression Process To Create A Zip Archive Of The Analysis Data..."
		sleep 4
		echo
		echo "                                               ${bold}${purple}                 Please Wait While We Organize and Compress Directory. "
		sleep 1
		echo "                                               ${bold}${purple}                           (This Might Take a Few Minutes...) "		
		cd $location  # changes the current location to the location under the variable "location".
		zip -r DataAnalysis.zip DataAnalysis > /dev/null 2>&1  # compress the contents of the "DataAnalysis" directory into a zip file named "DataAnalysis.zip, The "-r" flag it instructs the zip command to recursively include all files and subdirectories within the specified directory.
		cd $location  # changes the current location to the location under the variable "location".
		rm -rf DataAnalysis > /dev/null 2>&1  # The command rm -rf DataAnalysis is used to remove the directory named "DataAnalysis" and its contents forcefully and recursively.
		echo
		echo
		echo "                                               ${bold}${red}                            Compression Completed Successfully! "
		echo
		sleep 4
}
ZIP

function END ()  # Function for the end of the script that shows a diagram about the locations of all directories and files that was created are stored at.
{
	clear
	echo
	echo "                                                      ${red}${bold} The Following Diagram Displays Where All the Data Is Located on Your Computer:     ${normal}"
	sleep 5
	echo
	echo
	echo "${bold}						    |==========================>${blue}${bold} Exiftool ${normal}${bold}======================> Exiftool_Data "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |				${bold}   "
	sleep 0.1
	echo "${bold}						    |				                                  |========> ${green}Filtered_data  ${normal} "
	sleep 0.1
	echo "${bold}						    |				                                  |                            "
	sleep 0.1	
	echo "${bold}						    |				                                  |                            "
	sleep 0.1
	echo "${bold}						    |==========================>${blue}${bold} Bulk_extractor ${normal}${bold} ===============> |========> Data_Report "
	sleep 0.1
	echo "${bold}						    |				                                  |                            "
	sleep 0.1
	echo "${bold}						    |				                                  |                            "
	sleep 0.1																		      
	echo "${bold}						    |				                                  |========> ${green}Full_Data   ${normal} "
	sleep 0.1	
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |==========================>${blue}${bold} Foremost ${normal}${bold}======================> Foremost_Data "
	sleep 0.1
	echo "${blue}${bold} DataAnalysis ${normal}${bold}===========>${blue}${bold} Data_(Name of the file)${normal}${bold}==|  "
	sleep 0.1
	echo "${bold}						    |		${bold}   "
	sleep 0.1
	echo "${bold}						    |				                                  |========> ${green}Strings_Analyzed  ${normal} "
	sleep 0.1
	echo "${bold}						    |				                                  |                            "
	sleep 0.1
	echo "${bold}				                    |==========================>${blue}${bold} Strings ${normal}${bold} ======================> |  "
	sleep 0.1
	echo "${bold}						    |				                                  |                            "
	sleep 0.1
	echo "${bold}						    |				                                  |========> ${green}Strings_User_Input ${normal}(Only if the user typed!) "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |==========================>${blue}${bold} Network_pcap_file ${normal}${bold}=============> (The Network Pcap file) "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |==========================>${blue}${bold} Binwalk ${normal}${bold}=======================> Binwalk_Analyzed_Data "
	sleep 0.1
	echo "${bold}						    |  							${bold}   "
	sleep 0.1
	echo "${bold}						    |  "
	sleep 0.1
	echo "${bold}						    |				                                  |========> ${green}Commands_Data  ${normal} "
	sleep 0.1
	echo "${bold}						    |				                                  |                            "
	sleep 0.1
	echo "${bold}						    |==========================>${blue}${bold} Volatility_Analysis${normal}${bold} ===========> |  "
	sleep 0.1
	echo "${bold}						    				                                  |                            "
	sleep 0.1
	echo "${bold}						    				                                  |========> ${green}Registry_Data ${normal} "
	echo
	sleep 5
	echo "                                                                ${bold}                    Enjoy your investigation!        ${normal}      "   	
	sleep 3
}
END "$1"	
