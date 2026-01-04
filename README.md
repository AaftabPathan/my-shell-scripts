User Manager & Automated Backup Script:-
I wrote this Bash script to handle the repetitive task of setting up new Linux users and immediately securing their data with a backup. It’s built with safety in mind—it won't run without root privileges and it keeps a detailed log of everything it does.


🌟 Key Features
👤 User Management
Automated Creation: Creates new system users and sets up home directories in one click.

Secure Deletion: Removes users safely from the system.

Access Control: Simplifies password management for system administrators.

💾 Directory Backup System
High Compression: Uses tar with Gzip compression (.tar.gz) to minimize storage usage.

Timestamped Archives: Every backup is saved with a precise date and time to prevent overwriting.

Custom Paths: Flexibility to back up any system directory by providing the source path


🤖 CI/CD with GitHub Actions:-
I’ve integrated a GitHub Actions workflow into this repo. Every time I push code, an automated runner checks the script for syntax errors using ShellCheck. This ensures that the script remains bug-free and follows best practices for Bash scripting.

What this script actually does:-
Root Protection: First, it checks if you're running with sudo. If not, it stops immediately to prevent permission errors.

Smart User Creation: It asks for a username and checks if it already exists. If the user is new, it creates them, sets up their home directory, and assigns a password securely.

Automated Archiving: Once the user is set up, it automatically grabs their home directory and compresses it into a .tar.gz file inside the /backups folder.

Reliable Logging: Every single step—whether it's a success or a failure—is timestamped and saved to /var/log/user_management.log.



Project Structure:-
manage_users.sh: The main logic.

/backups/: This is where your .tar.gz files will appear.

/var/log/user_management.log: Check this file if something goes wrong or if you want to see a history of users created.


.🛠️ Built With
Shell: Bash
Tools: tar, useradd, chpasswd, tee, date



📝 License
This project is open-source. Feel free to modify and use it for your own administrative tasks.
