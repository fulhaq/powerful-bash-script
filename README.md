# powerful-bash-script
Farman's powerful bash script to get a new linux mint env setup.

## Backing Up and Restoring Cinnamon Setttings:

Export: dconf dump / > dconf_dump_4_22-19.conf

Import: dconf load / < dconf_dump_4_22-19.conf

https://github.com/linuxmint/Cinnamon/wiki/Backing-up-and-restoring-your-cinnamon-settings-(dconf)

## Adding ssh keys to prevent continous login prompts on Fish Shell:
eval (ssh-agent -c)
ssh-add -k

Ref: https://www.rockyourcode.com/ssh-agent-could-not-open-a-connection-to-your-authentication-agent-with-fish-shell
