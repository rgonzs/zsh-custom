# OH-MY-ZSH CUSTOM PLUGINS

Para utilizar estos plugins se debe tener habilitado el path `.local/bin` en el usuario, esto se puede lograr descomentando la linea en el archivo `~/.zshrc`
![alt text](images/image.png)

Se puede realizar la configuracion de estos nuevos plugins haciendo un cambio en la configuracion de `~/.zshrc` e indicando la nueva ruta de personalizacion, puedes hacer esto con el siguiente comando.

```shell
sed -i 's|# ZSH_CUSTOM=/path/to/new-custom-folder|ZSH_CUSTOM=$HOME/zsh-custom|' ~/.zshrc
```

En el caso que no desees cambiar este directorio puedes copiar cada plugin de forma independiente a la ruta por defecto de oh-my-zsh.

Para finalizar activa los plugins que deseas utilizar, para realizar esto solo es necesario declararlo en la parte de plugins de la siguiente forma.

~/.zshrc :
```zsh
plugins=(git kubevm)
```

Y despues de eso recargar la shell.

```shell
source ~/.zshrc
```