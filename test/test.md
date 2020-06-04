# BATS testing demo

![](../images/bat2.png)![](../images/bat2.png)![](../images/bat2.png)

I am no way an expert but have been crafting [bash](https://www.gnu.org/software/bash/manual/bash.html) scripts here and there for some time now, mostly for [CI/CD](https://en.wikipedia.org/wiki/CI/CD) pipelines. Nothing wrong with that except the use of the word "crafting", as I did no such thing. I normally put something together as a script and pray it will never be changed and will keep working as expected by the shear force of repetition... :) enough said...

Using bash scripts to speed up my own software development activities is something I like, for example , creating blank dotnet core solutions to perform katas and quick tests.

To improve my skill in bash and do that in a consistent and sistematic way, I've decided to find a way to perform test driven development while __"crafting"__ my own scripts. Uppon a few minutes googling, I bumped into [bats](https://github.com/bats-core/bats-core) originally by Sam Stepheson [Stepheson repo](https://github.com/sstephenson/bats), which is a [TAP compliant](https://en.wikipedia.org/wiki/Test_Anything_Protocol) testing framework for bash, a simile to [pester](https://devblogs.microsoft.com/scripting/unit-testing-powershell-code-with-pester/) in the __Powershell__ world. _(if you prefer more verbose stuff and wasting fingertips... outch! )_.

Hence, after a go at it... this demo happened.

Here I will:
- describe the prerequisites to run bats on your windows 10 env.
- describe setting up bats and use within VSCode.
- give an example of test first for a pseudo requirement.
- describe how can one use bats within CI/CD pipeline. will use circle.
  
## prerequisites:
- Windows 10 pro OS.
- [Git Bash](https://git-scm.com/) or any other [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) ... [client](https://git-scm.com/download/gui/windows).
- [vscode](https://code.visualstudio.com/docs/setup/windows) and [dotnet core sdk 3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1) installed. if ot you will need to do so using links provided.
- [Windows Linux Subsystem](https://docs.microsoft.com/en-us/windows/wsl/install-win10) - WSL1 (ideally WSL2) setup on your windows 10 pro OS. I prefer [Ubuntu](https://ubuntu.com/wsl) as am used to Debian command structure, but you can use any available linux flavour.
- [Docker desktop for windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows) (optional)
- presuming you have some familiarity with vscode.
  
## setting up bats and use in vscode :

you will need to install bats in the wsl env, then clone this demo repo, open vscode, install a few plugins, and run existing bats test.

### open your ubuntu wsl terminal and run below commands. That will install bats.
```sh
    sudo apt install bats
    sudo apt update
```

### install dotnet core 3.1 sdk on your wsl environment if not already. For more detail [follow this](https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1910). Alternativelly I have put all required steps [here](dotnetcorewsl.md)

### clone this demo [git repo](https://github.com/fcavaco/bats_demo.git) :
```sh
git clone https://github.com/fcavaco/bats_demo.git
```
__open vscode__ inside the local repo directory.
  
### add [J-Et. Martin "Bats"](https://marketplace.visualstudio.com/items?itemName=jetmartin.bats) plugin to vscode.
![](../images/batsplugin.png)

### add Microsoft "Remote - WSL" plugin to vscode.
![](../images/RemoteWSL_VSCodePlugin.png)
- to access your remote wsl terminal. there are many ways to access it, for example as advised [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl), but I normally prefer to get it straight from the terminal window as dpicted below.
![](../images/selectRemoteWSLTerminal0.png)
![](../images/selectRemoteWSLTerminal.png)
- you can then toggle the terminal on/off with ctrl+' .

### try it out by running the test.bats file under test directory...
```sh
cd ./test
bats test.bats
```

## Test First approach using bats
