using Statline.Stattrac.NetworkSetup;

namespace NetworkSetup
{
	class Program
	{
		static void Main(string[] args)
		{
			//CopyFiles copyFiles = new CopyFiles(args[0]);
			CopyFiles copyFiles = new CopyFiles(@"C:\Projects\Statline\StatTrac\Development\Tcss\Main\NetworkSetup\NetworkSetup.xml");
			copyFiles.ExecuteCopyFiles();
		}
	}
}
