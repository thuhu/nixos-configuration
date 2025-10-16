{ config, pkgs, ... }:

let  
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		qtile = "qtile";
		rofi = "rofi";
	};
in

{
	home.username = "thuhu";
	home.homeDirectory = "/home/thuhu";
	programs.git = {
		enable = true;
		userName = "Desmond Letshedi";
		userEmail = "Desmond.thuhu@outlook.com";
	};
	home.stateVersion = "25.05";

	programs.firefox.enable = true;

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
			ls = "ls -al";
			nrss = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
		};
	};

	xdg.configFile = builtins.mapAttrs
		(name: subpath: { 
			source = create_symlink "${dotfiles}/${subpath}";
			recursive = true;
		})
		configs;

	home.packages = with pkgs; [
		neovim
		ripgrep
		nodejs
		nil
		nixpkgs-fmt
		gcc
		rofi
	];
}
