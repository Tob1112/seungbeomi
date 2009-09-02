package seungbeomi.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;

	import seungbeomi.controller.ModelPrepCommand;
	import seungbeomi.controller.ViewPrepCommand;

	public class ApplicationStartupCommand extends MacroCommand
	{
		/**
		 * Adds subcommands to execute in a special order
		 * */
		 override protected function initializeMacroCommand():void
		 {
		 	addSubCommand(ModelPrepCommand);
		 	addSubCommand(ViewPrepCommand);
		 }

	}
}