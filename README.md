# macOS merge copy service

Leave away drag and drop with [option] key and say Goodbye to the "Replace".
Do Real Merge with a simple service on macOS Finder, just like Windows / Linux.

[中文版](https://github.com/pilisir/macOS_merge_copy/wiki/%E4%B8%AD%E6%96%87%E7%89%88-README)

## Feature
* Copy selected files or folders to a target folder and append as children if not existing or overwrite otherwise. 
## Install
There are two way to create the services.
##### Way 1: Copy and Paste (If you run into a problem about encoding of workflow file while trying this way, please try Way 2 instead.)
1. Directly [download](https://github.com/pilisir/macOS_merge_copy/releases/download/1.1/MergeCopy.zip) the latest release and uncompress it.
2. Move the service file to the local service folder. You can easily copy *merge copy.workflow* to your local __*$USER/Library/Services/*__ directory. (Please set your Finder eanble to see hidden directories via shortcut key **[Shift] + [Command] + [.]**  first.)
3. Done !
##### Way 2: Create services yourself.
1. Open **Automator** app.
2. Press **[Command] + [N]** to new a document which type is *Service*.
3. Select __*Action > Library > Files & Folders > Get Selected Finder Items*__ and drag it to the right side as Step One.
4. Select __*Action > Library > Utillities > Run Shell Script*__ and drag it to the right side as Step Two.
5. Drop down **Pass input** of Step Two and select the **to stdin**.
6. Copy content text of file from this project, __*./src/merge_copy.sh*__, paste it as the Step Two shell content text.
7. Look up the top, drop down **Service receives selected** and select **files or folders**.
8. Press **[Command] + [S]** to save this service with specified name "**Merge Copy**" (or any custom name yourself). 
9. Done !

## Usage
1. Select files or directories in Finder, open conetxt menu and select Service > **Merge Copy**.
2. Select target folder from second Finder dialog.
3. Provide password if files or folders require premissions.
4. That's all !
![context menu](https://github.com/pilisir/macOS_merge_copy/blob/master/doc/image/contextmenu.png)

## Recommend Setting Hot Key
* You can assign shortcut key for the service via Keyboard in System Preferences to make more easily.
* Recommend **[Control] + [Command] + [M]**, meaning as **Merge**.
* [Tutorial](https://apple.stackexchange.com/questions/43998/how-do-i-assign-a-keyboard-shortcut-to-a-service-in-os-x)

## FYI
* I never test it lower than Mojave.
* You may find out the script is not elegant itself, because this is just my second project of Automator with shell script. I look forward to any suggestion or fork.

## License
MIT License

## Reference
* https://grahamrpugh.com/2017/01/07/application-to-run-shell-commands-with-admin-rights.html
* https://stackoverflow.com/questions/39932522/applescript-how-to-get-full-path-of-the-current-finder-window-open

## Donate
[Donate me via PayPal](https://www.paypal.me/pilisir/0.99usd)\
[Donate me via OPay(歐付寶)](https://p.opay.tw/unUun)
