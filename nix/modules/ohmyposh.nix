{ config, pkgs, ... }: 
{
	# Oh My Posh
	programs = {
		oh-my-posh = {
			enable = true;
			enableFishIntegration = true;
			useTheme = "peru"; #paradox
		};	
	};
}
