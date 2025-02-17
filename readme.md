
# Cloud Hosted Minecraft Server [Forge]

Terraform scripts to quickly deploy a modded minecraft server onto aws
- Works for Forge mc versions 1.18.x -up to-> 1.21.x

## Prerequisites & Setup

Install the following :
- Terraform [https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli]
- AWS CLI [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html]

Setup the following :
- AWS Account [https://aws.amazon.com/resources/create-account/]
- Connect AWS account to AWS CLI by [creating an access key](https://www.youtube.com/watch?v=vZXpmgAs91s)


## Clone Repository

Clone repo with git :

```bash
git clone github.com/...
```
or
- Download the repo by clicking [ <> Code ] -> 'Download ZIP'
- Make sure to unzip the folder after downloading

## 1.) Configure files
- Replace all instances of `s3_bucket_name` in the files below with a unique s3 bucket name (should all be the same name)
```
├───config
│       ec2_role.json
│       s3_policy.json   <--- Change s3_bucket_name
│
│   .gitignore
│   access.tf
│   main.tf              <--- Change s3_bucket_name
│   networking.tf

```

## 2.) Build Server Infastrucutre on AWS
- Run terraform command below
- Running command will outputs server ip address
```
    terraform apply
```

## 3.) Upload Server Files to s3 Bucket

#### a.) Select Mods and Modloader Version
- Download mod loader for minecraft version [pick between 1.18.x - 1.21.x](https://files.minecraftforge.net/net/minecraftforge/forge/)

- Choose or use existing mods
    - Downloads mods : [Modrinth](https://www.curseforge.com/minecraft/mods) / [CurseForge](https://www.curseforge.com/minecraft/mods) (Must match minecraft version)

- Put all mods in a folder named `mods` and zip the folder to `mods.zip` 
    - You can optinally zip configs or defaultconfigs if you wish to add them to your server

#### b.) Upload Files to s3 Bucket 
- Navigate to AWS s3 console [https://us-west-2.console.aws.amazon.com/s3/]
- Upload the following files to the `/setup` folder inside your s3 bucket:
```
    REQUIRED:
        - loader-x.xx.x-xx.x.x-installer.jar
        - minecraft.service (provided)

    OPTIONAL
        - mods.zip
        - configs.zip
        - defaultconfigs.zip
```

## 4.) Connect to ec2 Instance
- Connect via SSH using provided key or ec2 console [https://us-west-2.console.aws.amazon.com/ec2]
- Use ip address provided by terraform output
```
    ssh -i ~/.ssh/mc-ec2-key ubuntu@x.xxx.xx.x
```
- Run the following commands located in `ec2_commands.md` within your ec2 instance
