{ config, pkgs, ... }: 
{
	# The Fuck
	programs = {
		thefuck = {
			enable = true;
			enableFishIntegration = true;
		};	
	};
}
