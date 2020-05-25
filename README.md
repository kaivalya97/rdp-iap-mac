# rdp-iap-mac

A bash script for MacOS to connect to Windows instances on GCP using IAP TCP forwarding

## Prerequisites:

- Setup gcloud with your credentials. You can follow this tutorial: https://cloud.google.com/sdk/docs/quickstart-macos
- Install Microsoft Remote Desktop https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac (Stable or beta both will work)
- Enable IAP in your project: https://cloud.google.com/iap/docs/using-tcp-forwarding#preparing_your_project_for_tcp_forwarding

## Usage:

Run the bash script with the following command line arguments:
- VM name
- VM zone
- VM Project ID

`bash rdp-iap.sh test-windows-vm us-east1-a my-project`

The bash script should print a password in the Terminal and open a session in Microsoft Remote Desktop.

You will have to copy and paste the password into the prompt. This step is needed because RDP links do not support passing password as a parameter as of when this script was created.

## Working:

The bash script will first set a Windows password for your user, write it to a temp file, read the temp file and print just the password for user on the Terminal.

It will then start an IAP tunnel to the VM from a random unused port to 3389.

Finally the script will open Microsoft Remote Desktop using an RDP link as the argument.

## Troubleshooting:

- If you are using the Beta version of Microsoft Remote Desktop, you will have to change the open command to "/Applications/Microsoft\ Remote\ Desktop\ Beta.app"

## Special mention to https://github.com/GoogleCloudPlatform/iap-desktop which is a graphical application that does the same thing for Windows
