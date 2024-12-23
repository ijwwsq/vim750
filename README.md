# 750 Words Plugin for Neovim

This Neovim plugin helps you maintain a daily writing habit by creating and organizing entries in markdown files. It includes features like file generation, organization by month, reminders to revisit older entries, and a simple word count tool.

This is my first plugin, so I’d be grateful if you could point out any mistakes or suggest improvements!

## Features

- **Daily Writing Entries**: Automatically create a markdown file for today's writing.
- **Organized Viewing**: View all entries grouped by month in a temporary buffer.
- **Word Count**: Easily count the number of words in your current buffer.
- **Reminders**: Receive a reminder to revisit an entry written 30 days ago.
- **Customizable Directory**: Default writing directory is `~/Documents/750words`.

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

1. Add the plugin to your `vimrc` or `init.vim`:
   ```vim
   Plug 'ijwwsq/vim750'
   ```
2. Install the plugin:
    ```
    :PlugInstall
    ```

### Using packer.nvim

1. Add the plugin to your lua/plugins.lua or similar:
  ```
  use 'ijwwsq/vim750'
  ```
2. Install the plugin:
  ```
  :PackerSync
  ```

## Usage
### Commands
```
    :Write750: Create or open today's writing entry.
    :Reveal750: Show all entries grouped by month.
    :call WordCount(): Display the word count of the current buffer.
```
### Keybindings
```
    <leader>wc: Count the words in the current buffer.
```
### Reminders

When Neovim starts, you'll be reminded to revisit an entry from 30 days ago if it exists.
Configuration

By default, the plugin uses the directory `~/Documents/750words` for storing files. To change it, modify the `g:work_dir` variable in your Neovim configuration.

Example:
```
let g:work_dir = expand('~/path/to/your/directory')
```
### Contributing

Since this is my first Neovim plugin, feedback is greatly appreciated! Please open an issue or create a pull request if you encounter any problems or have suggestions for improvement.

### License

This plugin is licensed under the MIT License.


