# Let's Get Started

## Welcome to CSC134

In this class, we will be learning the basics of Cyber Operations! To do so, there are a few things that need to be completed before we get started...

---

### Downloading Kali

In the class, we will be using a operating system called Kali Linux. This is a hacking distribution of Linux and one of the best all-in-one tools you can use as a hacker.

Follow these steps to download Kali:

1. Open `File Explorer` and navigate to your `Documents` folder within the sidebar on the left
2. Right-click within the documents folder in an empty area and create a new folder called `Virtual Machines`
3. Download Kali from [here](https://cdimage.kali.org/kali-2023.2/kali-linux-2023.2-vmware-amd64.7z) and be sure to save the file to the newly created folder under `Documents -> Virtual Machines`
4. Once the file is downloaded it will save as a `7z` file, which you will need to unzip. You should be able to navigate to the `7z` file, right-click on the file, click `Show more options`, hover over 7-Zip, then say `extract files`, then click `ok`.
5. You should now see a new folder created that is the same name as the 7z zip file.

Once you have this downloaded, you will pair up this file with a software called `VMware Workstation Player` to install Kali Linux.

---

### Using VMware

VMware is a company best known for virtualization and cloud computing software. Essentially, using a product like `VMware Workstation Player` allows you to emulate a computer within the current computer you use, this is what is known as a virtual machine. A virtual machine generally interacts with the host computer hardware while being isolated from the software and host operating system. It is a good practice within the cybersecurity industry to use virtual machines for many different areas of work such as organization, security, and making the most of offensive/defensive tools.

If you do not have VMware Workstation Player installed yet, you can do so [here](https://www.vmware.com/go/getplayer-win). <br>(Assuming you are using Windows as your host operating system)

Once you install and open this software you should be presented with this:
<br>
<br>
<img width="600" alt="image" src="https://github.com/ZoneMix/CSC134/assets/38586893/934ca2b5-4740-4584-9e16-cb54e8131638">

Click on `Open a Virtual Machine` and navigate to `Documents -> Virtual Machines`. Inside of the folder you unzipped, double-click on the file that looks like this:<br>
<img width="600" alt="image" src="https://github.com/ZoneMix/CSC134/assets/38586893/b9aa4da3-ae8c-478d-af97-0df42d05aeb3">

It then should appear in the main window:<br>
<img width="600" alt="image" src="https://github.com/ZoneMix/CSC134/assets/38586893/8d1f44ad-2a0d-4393-b998-58942427648b">

To run Kali, click on `Play virtual machine` and this should pop up:<br>
<img width="600" alt="image" src="https://github.com/ZoneMix/CSC134/assets/38586893/9e6e048e-a583-461d-a6a2-911f2af3454f">

The default credentials for the Kali machine are `kali:kali`

**NOTE: Kali will take control of your cursor if you do not click outside the window of Kali, you can use CTRL+ALT to gain cursor control back**

### Setting up Kali

After entering credentials you will open up to this environment:<br>
<img width="600" alt="image" src="https://github.com/ZoneMix/CSC134/assets/38586893/ae3c9387-4bc3-4984-beb2-71192d1e386d">

Click on the icon with a black box, which is called the `Terminal`:<br>
<img width="100" alt="image" src="https://github.com/ZoneMix/CSC134/assets/38586893/2161dd20-3273-4c7a-9ac4-1aa40bb3852e">

Enter each of these commands seperately into the terminal: (when using sudo you will need the password set for the VM, in our case "kali")
```bash
sudo apt update
sudo apt install git -y
cd ~
git clone https://github.com/ZoneMix/CSC134.git
cd CSC134
```

Once the github repository is finished cloning we will need run the install script which will take a while...

```bash
chmod u+x ./kali.sh
sudo ./kali.sh
```

## Errors and Troubleshooting

If you get an error that your virtual machine is not able to start, and that you need to change a setting in BIOS, it is likely that virtualization within your hardware settings is disabled and you will need to enable that. The best way to go about this is googling the make of your computer and looking up "enable virtualization in BIOS on" then the make of your computer.

If you get error about not having internet within Kali, you will need to go into the settings of VMware Player under `Player -> Manage -> Virtual Machine Settings -> Network Adapter` then make sure it is set to `NAT` 
