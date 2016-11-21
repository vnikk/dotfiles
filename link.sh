#!/bin/bash
ln -s -f $PWD/bashrc ~/.bashrc
ln -s -f $PWD/vimrc ~/.vimrc
for i in $(ls *.vim)
    do ln -s -f $PWD/$i ~/.vim/colors/$i
done
