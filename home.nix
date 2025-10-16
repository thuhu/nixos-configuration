{ config, pkgs, ... }:

let  
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		qtile = "qtile";
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
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
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
	];
}
