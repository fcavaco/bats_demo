# add dotnet core to wsl.
1.  add MS repo key and feed

```shell
     wget https://packages.microsoft.com/config/ubuntu/19.10/  packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt update 

```
2. install dotnet core sdk
```shell
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1
```
3. Install the ASP.NET Core runtime
```shell
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install aspnetcore-runtime-3.1
```
4. Install the .NET Core runtime
```shell
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-runtime-3.1
```