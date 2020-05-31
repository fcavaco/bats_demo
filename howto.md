# What is [Bats](https://github.com/sstephenson/bats)
- bats is a testing framework for [bash](https://www.gnu.org/software/bash/manual/bash.html) language scripts.
- allows us to be safe/consistent creating and evolving our bash scripts. Safe in the knowledge that our script has been tested.
- equivalent to [Pester](https://devblogs.microsoft.com/scripting/unit-testing-powershell-code-with-pester/) in the Powershell world. (for those windows addicts... who prefer more verbose stuff and wasting fingertips... :) )
  
# How to run bats in vscode using bash console
- presuming you have [Visual Studio Code - VSCode](https://code.visualstudio.com/docs/setup/windows) installed.
- presuming you have [Windows Subsystem Linux - wsl ](https://docs.microsoft.com/en-us/windows/wsl/install-win10) setup
- retrieve this solution from github here and setup local repo.
- open this solution on vscode
- open a new wsl terminal (I am using ubuntu )
![](./../images/wslconsole.png)

## install bats in wsl
```
sudo apt install bats
```
## install dos2unix in wsl 
- useful if one needs convert from windows format to unix, sometimes there are issues editing scripts in windows vscode and trying to execute them in bash console.
```
sudo apt install dos2unix 
```
## install dotnet core on your WSL
[follow this](https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1910)
- install all: runtime, asp.net , sdk
- note : I'm on Windows 10 Pro - 1909 version. using WSL Ubuntu 18.04 and it seems to work...command below to check ubuntu version from the terminal.
  ```
    lsb_release -a
  ```

## install bats submodules, help on making your tests more fluent
```
git submodule init
git submodule add https://github.com/sstephenson/bats test/libs/bats
git submodule add https://github.com/ztombol/bats-assert test/libs/bats-assert
git submodule add https://github.com/ztombol/bats-support test/libs/bats-support
git add .
git commit -m 'installed bats'
```
## run tests

```
cd ./test
bats *.bats
```

# how does it work ?
- you have your suts (subject under test) in the ./src/bash directory
  - these are the actual scripts and modules one wants to test.
- you have your test files under ./test . e.g. addition-test.bats - note this does not refer to any sut is just to ensure the bats framework is working.
  - these are the actual test files (.bats), the source command defines what's the script being tested, and adds any other required functions from external modules.
- under ./test/libs , are the git submodules we have installed for bats. 
  - they are referenced from the .bats file as it loads functions therein defined. e.g. load './libs/bats-support/load' 

- ignore ./images, that's just to allow me to display some images in this markdown.

  
# Test first approach

## use case : script to speed up creation of solution to perform TDD katas with F#.
- I will presume that I have __dotnet core 3.1 installed__ on my wsl (SDK|Runtime).
- I want to __setup a local git repo__ automatically (including .gitignore file) for my solution.
- should create a __solution folder with a structure as defined below__. User is able input solution name as an argument to the script. 
- e.g. solution structure for F# | classlib | paket | nunit
```
  <Solution>
    .config
    .git
    .paket
    src
        <Project>
            Library.fs
            <Project>.fsproj
            paket.references
    test
        <ProjectTests>
            <ProjectTests>.fs
            <ProjectTests>.fsproj
            paket.references
    .gitignore  
    paket.dependencies
    paket.lock
    readme.md
    <Solution>.sln
```
- I should be able to compile and run tests on this solution via VSCode.  
- should create an empty __class library__. should be able to input name as an argument. 
- both solution and project names are alphanumeric string formatted as Pascal case. if not set by the user, the program will convert it.
- should create a __unit test project__ to perform my TDD kata. I can chose the framework and it will be automatically setup. the name of the unit test project will be worked out by convention from the sut project.
- the test project contains reference to the sut project.
- the test project constains watcher tools so that I can watch on tests.
- Something like this:
```
    ./dotnethelper.sh --sol Lusitania --proj LuisVazCamoes --type classlib --lang F# --pman paket --test nunit
```
- so my script will accept a number of argument options:
```
    # --sol : the solution name
    # --proj : a project name
    # --type : the type of project (needs to be subsequent to the --proj argument ) ... classlib only for now
    # --lang : the coding language used. : F# | c# | java | scala | R | ... (this demo will presume F#)
    # --pman : the package manager, e.g :  paket | nuget | ... defaults to paket (for this demo only paket)
    # --test : the unit test framework : nunit | xunit | mstest | fscheck (this demo will presume only nunit)
```
- it defaults to classlib | F# | nunit | paket, so we can simply run:
```
    ./dotnethelper.sh --sol Lusitania --proj LuisVazCamoes
```  

## So... were do I start ?
- it is presumed I have dotnet installed, possibly sdk
# How to CI/CD our scripts tests