# SSH

You can read more about `SSH` in your obsidian page.

## Introduction

SSH is used when you want to encrypt, or securely connect through the internet. There a lot more
usages to it, but for this this is enough.

## Why

In the case of git, one might want to connect to multiple github accounts. But for those that
do not use a MAC or a windows machine cannot use a github credential manager.

## How

### 1. Create a New SSH Key
We need to generate a unique SSH key for our second GitHub account.

```bash
ssh-keygen -t rsa -b 4096 -C "your-email-address"
```
Replace the placeholder with your email address. 

```bash
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vaati/.ssh/id_rsa):
```
Be careful that you don't overwrite your existing key for your default personal account. Instead, when prompted, save the file as id_rsa_COMPANY. In my case, I've saved the file to ~/.ssh/id_rsa_work.

```bash
Enter file in which to save the key (/home/vaati/.ssh/id_rsa): /home/vaati/.ssh/id_rsa_work
```
After you run the command above, you will get a prompt to enter a passphrase. 

```bash
Enter passphrase (empty for no passphrase):
```
A passphrase should be easy to remember but hard for a bot or computer to guess. You could use a favorite line of poetry, for example, or a line from a movie that you like.

You will be prompted to enter the passphrase again.

Once you enter the passphrase again, the key is saved in the default location you specified, and two files are created as shown below.

```bash
Your identification has been saved in /home/vaati/.ssh/id_rsa_work
Your public key has been saved in /home/vaati/.ssh/id_rsa_work.pub
The key fingerprint is:
SHA256:PLusNPF6nf5e2jr/z57EB1gl5YW43Tw55TPqhTu4z3g dummy8@gmail.com
The key's randomart image is: 
+---[RSA 4096]----+ 
| ..o+| 
| . .+o| 
| o.++| 
| . .o.*+| 
| . S . + =| 
| o o o.o | 
| o o. .o +o.| 
| . +..o.+E..o| 
| ooo..=O*++*| 
+----[SHA256]-----+ 
```
One is a public key, and the other is a private key. You will need the key to make a connection with your GitHub account. To view the contents of the saved key, issue the following command.

```bash
cat .ssh/id_rsa_work.pub
```
Copy and store the key on a text file on your computer, as we will need to add it to your second GitHub account.

### 2. Attach the New Key
Next, log in to your second GitHub account, click on the drop-down next to the profile picture at the top right, select Settings, and click on SSH and GPG keys.

Next, add the key you copied earlier. Feel free to give it any title you wish.

### 3. Add the SSH Key to the Agent
Next, because we saved our key with a unique name, we need to tell SSH about it. In the Terminal, type: `ssh-add ~/.ssh/id_rsa_work`. If successful, you'll see a response of Identity Added.

```bash
$ ssh-add ~/.ssh/id_rsa_work
Enter passphrase for /home/vaati/.ssh/id_rsa_work: 
Identity added: /home/vaati/.ssh/id_rsa_work (dummy85@gmail.com)
```
We now have two sets of SSH keys in our machine. They reside in the .ssh directory, and you can view them.

```bash
vaati@vaati-Yoga-9-14ITL5:~$ cd .ssh
vaati@vaati-Yoga-9-14ITL5:~/.ssh$ ls 
config  id_rsa  id_rsa.pub  id_rsa_work  id_rsa_work.pub  known_hosts  known_hosts.old
```

### 4. Create a Config File
We've done the bulk of the workload, but now we need a way to specify when we wish to push to our personal account and when we should instead push to our company account. To do so, let's create a config file.

```bash
touch ~/.ssh/config
vim config
```
If you're not comfortable with Vim, feel free to open the file with any editor of your choice. Paste in the following snippet.

```
#Default GitHub 
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
```
This is the default setup for pushing to our personal GitHub account. Notice that we're able to attach an identity file to the host. Let's add another one for the company account. Directly below the code above, add:

```
Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_work
```
The config file should now look like this:

```
#Default GitHub 
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_work
```
This time, rather than setting the host to `github.com`, we've named it `github.com-work`. The difference is that we're now attaching the new identity file that we created previously: `id_rsa_work`.

Save the page and exit.

### 5. Try It Out!
It's time to see if our efforts were successful. Create a test directory, and add a test.txt file.

```bash
mkdir TEST
cd TEST
touch test.txt
```
Initialize git and create the first commit.

```bash
git init
git add .
git commit -m "first commit'
```
Log in to your company account, create a new repository, and give it the name test_repository. Once the new repository is created, GitHub provides you with some next steps, as shown below.

Since we already have an existing repository on the command line, we only need to add and push changes. This time, rather than pushing to `git@github.com`, we're using the custom host we created in the config file: `git@github.com-work`.

Use

`git@github.com-work`

Instead of 

`git@github.com`

Let's push the changes.

```bash
git remote add origin git@github.com-work:kaththy/Test.git
git push origin main
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 220 bytes | 220.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com-work:kaththy/Test.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'
```
Return to GitHub, and you should now see your repository. Remember:

 - When pushing to your personal account, proceed as you always have.
 - For your company account, make sure that you use `git@github.com-COMPANY` as the host.
