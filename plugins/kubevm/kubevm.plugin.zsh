#!/bin/zsh

typeset -f _help() {
  echo "Uso: kubevm [OPCIÓN]"
  echo ""
  echo "Opciones:"
  echo "  show      Muestra la version de kubectl que esta en uso."
  echo "  latest    Usa la última versión disponible de kubectl."
  echo "  use       Usa la versión especficada de kubectl"
  echo "  remove    Elimina de la cache la version indicada"
  echo "  help      Muestra esta ayuda."
}

cache_path=$HOME/.cache/kubevm

_check_first_execution() {
  if [[ ! -d $cache_path ]]; then
    echo "Creando directorio cache"
    mkdir -p $cache_path
  fi
}

_download_binary() {
  local args=$1
  if [ ! -f $cache_path/kubectl_$args ]; then
    echo "Descargando la version indicada"
    curl -L -o $cache_path/kubectl_$args "https://dl.k8s.io/release/$args/bin/linux/amd64/kubectl"
    chmod +x $cache_path/kubectl_$args
  else
    echo "Utilizando la version de la cache"
  fi
}

_remove_from_cache() {
  local args=$1
  if [ -f $cache_path/kubectl_$args ]; then
    rm $cache_path/kubectl_$args
  fi
}

_show_used_version() {
  local args=$1
  if [ ! -f $HOME/.kubevm ]; then
    echo "No hay una version instalada con kubevm"
    exit 0
  fi
  cat $HOME/.kubevm
}

_set_default_kubectl() {
  local args=$1
  mkdir -p "$HOME/.local/bin"
  ln -s "$cache_path/kubectl_$args" "$HOME/.local/bin/kubectl"

  echo "creando archivo"
  echo "$args" > $HOME/.kubevm 
}

_print_version() {
  echo "Instalando la version $1"
}

kubevm() {
  local args=$#
  if [ -z $args ]; then
    _help
  fi
  _check_first_execution
  
  case "$1" in
    latest)
      version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
      _print_version $version
      _download_binary $version
      _set_default_kubectl $version
      ;;
    use)
      version=$2
      _print_version $version
      _download_binary $version
      _set_default_kubectl $version
      ;;
    show)
      _show_used_version
      ;;
    delete)
      version $2
      _remove_from_cache $version
      ;;
    *)
      _help
      ;;
  esac
}


