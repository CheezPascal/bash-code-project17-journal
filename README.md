# bash-code-project17-journal
Made a journal program, for use when you constantly change files in the server that way you have a formatted system for documentation. 
This version is password protected

Key Features
---------------
Encryption/Decryption:

The gpg command encrypts and decrypts the log file using AES256.
A password is prompted at the start and used for all operations in the session.
Menu Options:

View Entries: Displays all journal entries.
Add New Entry: Prompts for a title and entry, then appends it to the log.
Delete Entry: Lists entries with line numbers for deletion.
Log Format:

Entries are stored as DD/MM/YYYY, Title, Entry.

Introduction
---------------
I made a simple journal for Linux server, this would be applicable if you work on systems and need to log what you did daily. 


Installation
----------------

Clone the repository git clone git clone https://github.com/CheezPascal/bash-code-project17-journal.git

Navigate into the folder of the repository

cd bash-code-project17-journal

Change the file permission of the program chmod +x journal.sh

Run the program and follow the menu

./journal.sh

Warnings
I added a clear command to the beginning of the code to clear the screen, this is because when testing i always cleared the screen and this was repetitive.